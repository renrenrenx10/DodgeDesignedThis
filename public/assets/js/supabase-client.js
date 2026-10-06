// Shared Supabase client for the storefront.
// The URL + publishable (anon) key are not secret — they're meant to be
// public and are protected by Row Level Security policies in the database.
// Never put the service_role / secret key here.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

export const supabase = createClient(
  "https://dqtfyqdzpyvtomafmcrq.supabase.co",
  "sb_publishable_-aDvF76f80LxwiqzxMz19g_r_SNkoxE",
);

// Base URL for calling the edge functions (create-checkout-session, etc.)
export const FUNCTIONS_URL =
  "https://dqtfyqdzpyvtomafmcrq.supabase.co/functions/v1";
