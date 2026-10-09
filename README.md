# Dodge Designed This

Live shop for Dodge Designed This — plain HTML/CSS/JS, no build step, deployed
to GitHub Pages. Products, stock and orders live in Supabase; Stripe Checkout
handles payment.

## How it fits together

```
public/            → the actual site, this is what GitHub Pages serves
  assets/js/supabase-client.js   → shared Supabase connection (safe to be public)
  *.html                         → storefront pages

supabase/
  migrations/       → database schema (run these against your Supabase project)
  functions/
    create-checkout-session/   → called by the basket/checkout button;
                                  re-checks price + stock, creates a Stripe
                                  Checkout Session
    stripe-webhook/             → Stripe calls this when payment completes;
                                  decrements stock, saves the order
```

Nothing in `public/` ever sees your Stripe **secret** key — only the two
edge functions do, and that key lives in Supabase's secret store, never in
this repo.

## One-time setup

1. **Database**: in the Supabase dashboard → SQL Editor, run the files in
   `supabase/migrations/` in order (0001, then 0002).
2. **Edge functions**: install the [Supabase CLI](https://supabase.com/docs/guides/cli),
   then from this repo:
   ```
   supabase link --project-ref dqtfyqdzpyvtomafmcrq
   supabase secrets set STRIPE_SECRET_KEY=sk_test_...
   supabase secrets set STRIPE_WEBHOOK_SECRET=whsec_...
   supabase secrets set RESEND_API_KEY=re_...
   supabase secrets set ORDER_NOTIFY_EMAIL=dodgedesignedthis@gmail.com
   supabase secrets set SITE_URL=https://dodgedesignedthis.co.uk
   supabase functions deploy create-checkout-session
   supabase functions deploy stripe-webhook
   ```
3. **Stripe webhook**: in the Stripe Dashboard → Developers → Webhooks, add
   an endpoint pointing at your deployed `stripe-webhook` function's URL
   (the CLI prints it after `functions deploy`), listening for
   `checkout.session.completed`. Copy the signing secret it gives you into
   `STRIPE_WEBHOOK_SECRET` above.
4. **GitHub Pages**: in the repo's Settings → Pages, set the source to
   "GitHub Actions" (the workflow in `.github/workflows/deploy.yml` handles
   the rest — it deploys `public/` on every push to `main`).
5. **Domain**: once `dodgedesignedthis.co.uk` is transferred, point it at
   GitHub Pages (Settings → Pages → Custom domain) and add a `CNAME` file —
   GitHub's UI does this for you when you type the domain in there.

## Status

- [x] Database schema + seed data for the Tees category (placeholder stock —
      replace with real numbers)
- [x] Checkout + webhook edge functions
- [x] Deploy pipeline (GitHub Pages via GitHub Actions)
- [ ] Storefront pages converted from the Design mockup into live,
      Supabase-backed HTML (next step)
- [ ] Admin pages (login, stock, orders) wired to real data
- [ ] Real product catalogue + photos for every product, not just one tee
- [ ] Live Stripe keys swapped in before launch
