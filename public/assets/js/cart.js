// Shared basket (shop spec section "Basket and Stripe checkout"). The
// basket itself is just localStorage — no DB table, no login — so it's
// purely a browser-side list of {variantId, qty} until the customer hits
// Checkout, at which point it's handed to the same create-checkout-session
// edge function that single-item buy-now used to call directly (that
// function already re-checks price/stock/active against the database, so
// nothing about the basket being client-side weakens that check).

import { supabase } from "./supabase-client.js";

const CART_KEY = "ddt_cart_v1";

export function getCart() {
  try {
    const raw = JSON.parse(localStorage.getItem(CART_KEY) || "[]");
    return Array.isArray(raw) ? raw : [];
  } catch {
    return [];
  }
}

function saveCart(cart) {
  try {
    localStorage.setItem(CART_KEY, JSON.stringify(cart));
  } catch {
    // Storage full/unavailable (private browsing etc.) — the basket just
    // won't survive a reload; nothing to do about it from here.
  }
  renderBasketBadges();
}

export function addToCart(variantId, qty = 1) {
  const cart = getCart();
  const existing = cart.find((i) => i.variantId === variantId);
  if (existing) existing.qty += qty;
  else cart.push({ variantId, qty });
  saveCart(cart);
}

export function setQty(variantId, qty) {
  let cart = getCart();
  if (qty <= 0) {
    cart = cart.filter((i) => i.variantId !== variantId);
  } else {
    const existing = cart.find((i) => i.variantId === variantId);
    if (existing) existing.qty = qty;
  }
  saveCart(cart);
}

export function removeFromCart(variantId) {
  saveCart(getCart().filter((i) => i.variantId !== variantId));
}

export function clearCart() {
  saveCart([]);
}

export function cartCount() {
  return getCart().reduce((sum, i) => sum + i.qty, 0);
}

// Every page with a basket icon gives it this class — call this once on
// load (and it's called automatically on every cart change) to keep every
// badge on the page in sync, no matter how many there are.
export function renderBasketBadges() {
  const count = cartCount();
  document.querySelectorAll(".basket-count").forEach((el) => {
    el.textContent = count;
    el.classList.toggle("zero", count === 0);
  });
}

// Hands the basket to the same checkout edge function buy-now used — it
// re-validates price, stock and active status server-side regardless of
// what's in the (client-editable) basket, and errors out with a plain
// message if something in it is no longer available.
export async function checkoutCart() {
  const cart = getCart();
  if (cart.length === 0) return { error: "Your basket's empty." };

  const { data, error } = await supabase.functions.invoke("create-checkout-session", {
    body: { items: cart.map((i) => ({ variant_id: i.variantId, qty: i.qty })) },
  });

  if (error || !data?.url) {
    return { error: (data && data.error) || "Sorry — couldn't start checkout. Please try again." };
  }

  window.location.href = data.url;
  return {};
}

// Keep every basket badge on the page in sync on load too, not just after
// a change made on that same page.
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", renderBasketBadges);
} else {
  renderBasketBadges();
}
