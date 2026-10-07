// Shared storefront helpers: fetching products from Supabase, and kicking
// off Stripe Checkout via the create-checkout-session edge function.

import { supabase } from "./supabase-client.js";

export function formatPrice(pence) {
  return "£" + (pence / 100).toFixed(2);
}

// Fetch active products, optionally filtered by category, each with its variants.
export async function getActiveProducts({ category, limit } = {}) {
  let query = supabase
    .from("products")
    .select("*, variants(*), product_images(*)")
    .eq("active", true)
    .order("sort_order", { ascending: true });

  if (category) query = query.eq("category", category);
  if (limit) query = query.limit(limit);

  const { data, error } = await query;
  if (error) {
    console.error("Failed to load products", error);
    return [];
  }
  return data;
}

export async function getProductBySlug(slug) {
  const { data, error } = await supabase
    .from("products")
    .select("*, variants(*), product_images(*)")
    .eq("slug", slug)
    .eq("active", true)
    .single();

  if (error) {
    console.error("Failed to load product", error);
    return null;
  }
  return data;
}

// Renders a product card for grids/shelves. No real photos yet, so every
// card shows a plain placeholder — swap this for an <img> once photography
// is in.
export function productCardHTML(product, { showGig = true } = {}) {
  const gig = showGig && product.gig_price_pence
    ? `<span class="gig">· ${formatPrice(product.gig_price_pence)} gig</span>`
    : "";
  return `
    <a class="card" href="product.html?slug=${encodeURIComponent(product.slug)}">
      <div class="imgwrap">${productImageHTML(product)}</div>
      <h3>${escapeHTML(product.title)}</h3>
      <div class="price">${formatPrice(product.price_pence)}${gig}</div>
    </a>
  `;
}

// Renders a real photo if the product has one (product_images row), otherwise
// the placeholder box used everywhere until photography is in.
export function productImageHTML(product) {
  const image = (product.product_images || []).slice().sort((a, b) => a.sort_order - b.sort_order)[0];
  if (image) {
    return `<img src="${escapeHTML(image.url)}" alt="${escapeHTML(image.alt || product.title)}" loading="lazy" style="width:100%; height:100%; object-fit:cover;" />`;
  }
  return `<div class="ph">${escapeHTML(product.title)}</div>`;
}

function escapeHTML(str) {
  const div = document.createElement("div");
  div.textContent = str ?? "";
  return div.innerHTML;
}

// Kicks off Stripe Checkout for a single variant + quantity, bypassing the
// basket entirely. Not called anywhere anymore now product.html uses the
// real basket (assets/js/cart.js) — left in case a one-tap buy path is
// ever wanted again, since create-checkout-session itself didn't change.
export async function buyNow(variantId, qty = 1) {
  const { data, error } = await supabase.functions.invoke("create-checkout-session", {
    body: { items: [{ variant_id: variantId, qty }] },
  });

  if (error || !data?.url) {
    alert(
      (data && data.error) ||
      "Sorry — couldn't start checkout. Please try again.",
    );
    console.error(error || data);
    return;
  }

  window.location.href = data.url;
}
