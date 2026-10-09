// Supabase Edge Function: stripe-webhook
//
// Stripe calls this when a checkout session completes. We verify the
// signature, then: decrement stock for each variant purchased, write an
// order + order_items row so it shows up in the Admin Orders page, and
// email a notification so Rene actually knows a sale happened.
//
// Required secrets:
//   STRIPE_SECRET_KEY
//   STRIPE_WEBHOOK_SECRET   — from the Stripe Dashboard once this function's
//                             URL is registered as a webhook endpoint
//   RESEND_API_KEY          — from resend.com, used to send the order
//                             notification email (sent from
//                             onboarding@resend.dev to ORDER_NOTIFY_EMAIL;
//                             no domain verification needed as long as that
//                             address is the one the Resend account itself
//                             was signed up with)
//   ORDER_NOTIFY_EMAIL      — address to send new-order notifications to
// Auto-provided: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

import { createClient } from "npm:@supabase/supabase-js@2";
import Stripe from "npm:stripe@17.5.0";

const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  apiVersion: "2024-06-20",
  httpClient: Stripe.createFetchHttpClient(),
});
const webhookSecret = Deno.env.get("STRIPE_WEBHOOK_SECRET")!;
const resendApiKey = Deno.env.get("RESEND_API_KEY");
const orderNotifyEmail = Deno.env.get("ORDER_NOTIFY_EMAIL");

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

function formatPence(pence: number): string {
  return `£${(pence / 100).toFixed(2)}`;
}

async function sendOrderNotification(
  order: { id: string; email: string; customer_name: string; total_pence: number },
  lineItems: { title: string; size: string; colour: string; qty: number; unit_price_pence: number }[],
) {
  if (!resendApiKey || !orderNotifyEmail) {
    console.warn("RESEND_API_KEY or ORDER_NOTIFY_EMAIL not set — skipping order notification email");
    return;
  }

  const itemsHtml = lineItems
    .map(
      (i) =>
        `<tr><td style="padding:4px 8px">${i.qty} × ${i.title} (${i.size} / ${i.colour})</td><td style="padding:4px 8px;text-align:right">${formatPence(i.unit_price_pence * i.qty)}</td></tr>`,
    )
    .join("");

  const html = `
    <h2>New order on Dodge Designed This</h2>
    <p><strong>${order.customer_name || "Customer"}</strong> (${order.email || "no email given"})</p>
    <table style="border-collapse:collapse;width:100%;max-width:480px">${itemsHtml}</table>
    <p style="margin-top:12px"><strong>Total: ${formatPence(order.total_pence)}</strong></p>
    <p><a href="https://dodgedesignedthis.co.uk/admin/orders.html">View in admin</a></p>
  `;

  try {
    const res = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${resendApiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: "Dodge Designed This <onboarding@resend.dev>",
        to: orderNotifyEmail,
        subject: `New order — ${formatPence(order.total_pence)}`,
        html,
      }),
    });

    if (!res.ok) {
      console.error("Resend API error", res.status, await res.text());
    }
  } catch (err) {
    // Never let a notification failure break the webhook — Stripe just
    // retries on anything other than a 2xx, and the order's already saved.
    console.error("Failed to send order notification email", err);
  }
}

Deno.serve(async (req) => {
  const signature = req.headers.get("stripe-signature");
  const body = await req.text();

  let event: Stripe.Event;
  try {
    event = await stripe.webhooks.constructEventAsync(
      body,
      signature!,
      webhookSecret,
    );
  } catch (err) {
    console.error("Webhook signature verification failed", err);
    return new Response("Invalid signature", { status: 400 });
  }

  if (event.type === "checkout.session.completed") {
    const session = event.data.object as Stripe.Checkout.Session;

    // Avoid double-processing if Stripe retries the webhook
    const { data: existing } = await supabase
      .from("orders")
      .select("id")
      .eq("stripe_checkout_session_id", session.id)
      .maybeSingle();

    if (!existing) {
      const items: { variant_id: string; qty: number }[] = JSON.parse(
        session.metadata?.items ?? "[]",
      );

      const { data: order, error: orderErr } = await supabase
        .from("orders")
        .insert({
          stripe_checkout_session_id: session.id,
          stripe_payment_intent: session.payment_intent as string,
          email: session.customer_details?.email ?? "",
          customer_name: session.customer_details?.name ?? "",
          shipping_address: session.shipping_details?.address ?? null,
          status: "paid",
          total_pence: session.amount_total ?? 0,
        })
        .select()
        .single();

      if (orderErr) {
        console.error("Failed to write order", orderErr);
        return new Response("DB error", { status: 500 });
      }

      const lineItemsForEmail: { title: string; size: string; colour: string; qty: number; unit_price_pence: number }[] = [];

      for (const item of items) {
        const { data: variant } = await supabase
          .from("variants")
          .select("id, size, colour, stock, product_id, products(title, price_pence)")
          .eq("id", item.variant_id)
          .single();

        if (!variant) continue;

        const title = variant.products?.title ?? "";
        const unitPrice = variant.products?.price_pence ?? 0;

        await supabase.from("order_items").insert({
          order_id: order.id,
          product_id: variant.product_id,
          variant_id: variant.id,
          title,
          size: variant.size,
          colour: variant.colour,
          qty: item.qty,
          unit_price_pence: unitPrice,
        });

        // Decrement stock, floored at 0
        await supabase
          .from("variants")
          .update({ stock: Math.max(0, variant.stock - item.qty) })
          .eq("id", variant.id);

        lineItemsForEmail.push({
          title,
          size: variant.size,
          colour: variant.colour,
          qty: item.qty,
          unit_price_pence: unitPrice,
        });
      }

      await sendOrderNotification(order, lineItemsForEmail);
    }
  }

  return new Response("ok", { status: 200 });
});
