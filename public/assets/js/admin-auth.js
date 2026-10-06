// Shared admin auth guard. Every admin page (except login.html) imports
// requireSession() first thing — it redirects to login.html if there's no
// signed-in Supabase user, and otherwise resolves with the session.
//
// This is a single-admin shop: any signed-in user is "the admin" (see the
// RLS policies in 0005_admin_backend.sql, which all just check
// auth.role() = 'authenticated'). There's no separate roles table.

import { supabase } from "./supabase-client.js";

export async function requireSession() {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) {
    window.location.href = "login.html";
    return null;
  }
  return session;
}

export async function signOut() {
  await supabase.auth.signOut();
  window.location.href = "login.html";
}
