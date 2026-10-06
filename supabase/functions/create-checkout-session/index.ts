// Supabase Edge Function: create-checkout-session
//
// Called by the storefront's basket/checkout button. Takes the items in the
// customer's basket, re-checks price + stock against the database (never
// trust prices sent from the browser), and creates a Stripe Checkout Session.
//
// Required secrets (set with `supabase secrets set`):
//   STRIPE_SECRET_KEY        — sk_test_... while testing, sk_live_... at launch
//   SITE_URL                 — e.g. https://dodgedesignedthis.co.uk (no trailing slash)
// Auto-provided by Supabase: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import Stripe from "https://esm.sh/stripe@17?target=deno";

const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  apiVersion: "2024-06-20",
});

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const SITE_URL = Deno.env.get("SITE_URL")!;

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: CORS_HEADERS });
  }

  try {
    const { items } = await req.json() as {
      items: { variant_id: string; qty: number }[];
    };

    if (!Array.isArray(items) || items.length === 0) {
      return json({ error: "Basket is empty" }, 400);
    }

    const variantIds = items.map((i) => i.variant_id);
    const { data: variants, error } = await supabase
      .from("variants")
      .select("id, size, colour, stock, product_id, products(title, price_pence, slug, active)")
      .in("id", variantIds);

    if (error) throw error;

    const line_items = [];
    for (const item of items) {
      const v = variants?.find((v) => v.id === item.variant_id);
      if (!v || !v.products?.active) {
        return json({ error: `Item no longer available` }, 409);
      }
      if (item.qty < 1 || item.qty > v.stock) {
        return json({
          error: `Not enough stock for ${v.products.title} (${v.size}/${v.colour})`,
        }, 409);
      }
      line_items.push({
        quantity: item.qty,
        price_data: {
          currency: "gbp",
          unit_amount: v.products.price_pence,
          product_data: {
            name: `${v.products.title} — ${v.size} / ${v.colour}`,
          },
        },
        // stash enough to reconcile stock on the webhook without a second DB round trip
        // (Stripe doesn't let us attach metadata per line item on Checkout, so we
        // encode it into a single metadata field on the session instead — see below)
      });
    }

    const session = await stripe.checkout.sessions.create({
      mode: "payment",
      line_items,
      shipping_address_collection: { allowed_countries: ["GB"] },
      metadata: {
        // JSON-encoded so the webhook can decrement the right variants/stock
        items: JSON.stringify(items),
      },
      success_url: `${SITE_URL}/order-confirmed.html?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${SITE_URL}/basket.html`,
    });

    return json({ url: session.url });
  } catch (err) {
    console.error(err);
    return json({ error: "Something went wrong creating checkout" }, 500);
  }
});

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}
