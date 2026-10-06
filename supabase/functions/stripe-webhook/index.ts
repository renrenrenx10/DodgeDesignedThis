// Supabase Edge Function: stripe-webhook
//
// Stripe calls this when a checkout session completes. We verify the
// signature, then: decrement stock for each variant purchased, and write
// an order + order_items row so it shows up in the (future) Admin Orders page.
//
// Required secrets:
//   STRIPE_SECRET_KEY
//   STRIPE_WEBHOOK_SECRET   — from the Stripe Dashboard once this function's
//                             URL is registered as a webhook endpoint
// Auto-provided: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import Stripe from "https://esm.sh/stripe@17?target=deno";

const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  apiVersion: "2024-06-20",
});
const webhookSecret = Deno.env.get("STRIPE_WEBHOOK_SECRET")!;

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

serve(async (req) => {
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

      for (const item of items) {
        const { data: variant } = await supabase
          .from("variants")
          .select("id, size, colour, stock, product_id, products(title, price_pence)")
          .eq("id", item.variant_id)
          .single();

        if (!variant) continue;

        await supabase.from("order_items").insert({
          order_id: order.id,
          product_id: variant.product_id,
          variant_id: variant.id,
          title: variant.products?.title ?? "",
          size: variant.size,
          colour: variant.colour,
          qty: item.qty,
          unit_price_pence: variant.products?.price_pence ?? 0,
        });

        // Decrement stock, floored at 0
        await supabase
          .from("variants")
          .update({ stock: Math.max(0, variant.stock - item.qty) })
          .eq("id", variant.id);
      }
    }
  }

  return new Response("ok", { status: 200 });
});
