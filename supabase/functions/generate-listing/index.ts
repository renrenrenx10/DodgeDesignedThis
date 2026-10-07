// Supabase Edge Function: generate-listing
//
// The AI Listing Helper on admin/product-edit.html. Takes the product's
// main photo + a few keywords and asks Claude to write a listing in Rene's
// voice: blurb, SEO title, meta description, image alt text, slug and tags.
// Matches the spec in dodge-designed-this-shop-spec.md section 8.
//
// Always human-reviewed: this only fills in the admin form fields. Nothing
// is saved to the database until Rene hits Save Product himself.
//
// Required secrets (set with `supabase secrets set`):
//   ANTHROPIC_API_KEY  — from console.anthropic.com, billed separately from
//                        any Claude.ai subscription. Set a spend cap there.
// Auto-provided by Supabase: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

import { createClient } from "npm:@supabase/supabase-js@2";

const ANTHROPIC_API_KEY = Deno.env.get("ANTHROPIC_API_KEY")!;
const MODEL = "claude-haiku-4-5-20251001";

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const SYSTEM_PROMPT = `You write product listings for Dodge Designed This, a one-person DIY punk screen-printing brand run by Rene out of a Sheffield basement, tied to his band Get The Fuck Outta Dodge (GTFOD) — a Sheffield garage punk band that set up Dodge Designed This because they make their own tees anyway. Collaborators include Thomas Mannion and kiYOmi — credit them only if the keywords say to.

Voice: punk, DIY, cheeky, straight-talking, funny, a bit sweary. Take the piss; don't sound like a shop window. This is the real brand voice to match:

"Born in a basement and printed by hand, Dodge Designed This is a DIY clothing brand fuelled by noise, ink, and pure chaos. Forget factory lines – this is screen printed punk fashion where every design is unique, raw, and made to stand out."
"Hand printed: every shirt and hoodie is smashed with ink by hand – no robots, no bullshit. Truly unique: no two prints ever look the same – H.U.M.A.N error. Always a homage, never a theft."
"Ink first, ask later. Ink smudges? Maybe. Every one the same? Fuck no. Cool as fuck? Always."

Rules:
- Lead with the story or joke actually visible in the photo or given in the keywords — never generic punk-speak with nothing behind it.
- Blurb: about 70-120 words.
- Mention hand screen printing only lightly. Fabric weight and "no two are ever quite alike" already live in boilerplate text shown elsewhere on the page — don't repeat them.
- Never use these overused phrases: "isn't just a tee", "it's a statement", "chaos" (as a noun describing the product itself), "DIY energy", "unapologetic", "sparks conversation", "wear your chaos".
- Describe only what's actually visible in the photo. Don't invent facts, brands or artist credits.
- If "GTFOD" or "Get The Fuck Outta Dodge" appears in the keywords or is visible on the garment, treat this as a band tee and lean into the "our band" angle.
- Keep the SEO title and slug clean — no swearing — even when the blurb is sweary.

Reply with ONLY raw JSON, no markdown code fences, no commentary before or after, in exactly this shape:
{"blurb": "...", "seo_title": "...", "meta_description": "...", "alt_text": "...", "slug": "...", "tags": "comma, separated, tags"}

- seo_title: under 60 characters, roughly "<Product Name> Tee | <short descriptor> | Dodge Designed This"
- meta_description: under 155 characters
- alt_text: a plain, literal description of what's visible in the photo (for accessibility/SEO) — not in the punk voice
- slug: lowercase-hyphenated, no swearing, no spaces
- tags: 6-10 short lowercase tags, comma separated`;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: CORS_HEADERS });
  }

  try {
    // Only a signed-in admin can run this — the anon key alone (which is
    // not secret, it's embedded in every page) isn't enough, since each
    // call costs real money against Rene's Anthropic account.
    const authHeader = req.headers.get("Authorization") || "";
    const token = authHeader.replace(/^Bearer\s+/i, "");
    const { data: userData, error: authErr } = await supabase.auth.getUser(token);
    if (authErr || !userData?.user) {
      return json({ error: "Not signed in" }, 401);
    }

    const { image_url, title, category, keywords } = await req.json() as {
      image_url: string;
      title: string;
      category: string;
      keywords?: string;
    };

    if (!image_url || !title) {
      return json({ error: "Need a product photo and a title first" }, 400);
    }

    const imgResp = await fetch(image_url);
    if (!imgResp.ok) {
      return json({ error: "Couldn't fetch the product photo" }, 400);
    }
    const contentType = imgResp.headers.get("content-type") || "image/jpeg";
    const bytes = new Uint8Array(await imgResp.arrayBuffer());
    let binary = "";
    for (let i = 0; i < bytes.length; i++) binary += String.fromCharCode(bytes[i]);
    const base64 = btoa(binary);

    const userText = `Product name: ${title}
Category: ${category || "tees"}
Keywords from Rene: ${keywords?.trim() || "(none given — go on what's visible in the photo)"}

Write the listing JSON for this product based on the attached photo.`;

    const aiResp = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": ANTHROPIC_API_KEY,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify({
        model: MODEL,
        max_tokens: 700,
        system: SYSTEM_PROMPT,
        messages: [
          {
            role: "user",
            content: [
              { type: "image", source: { type: "base64", media_type: contentType, data: base64 } },
              { type: "text", text: userText },
            ],
          },
        ],
      }),
    });

    if (!aiResp.ok) {
      const errText = await aiResp.text();
      console.error("Anthropic API error:", errText);
      return json({ error: "AI generation failed — check the ANTHROPIC_API_KEY secret and spend cap" }, 502);
    }

    const aiData = await aiResp.json();
    const text = aiData?.content?.[0]?.text || "";

    let parsed;
    try {
      parsed = JSON.parse(text);
    } catch {
      const match = text.match(/\{[\s\S]*\}/);
      if (!match) return json({ error: "Couldn't parse the AI's response — try again" }, 502);
      parsed = JSON.parse(match[0]);
    }

    return json(parsed);
  } catch (err) {
    console.error(err);
    return json({ error: "Something went wrong generating the listing" }, 500);
  }
});

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}
