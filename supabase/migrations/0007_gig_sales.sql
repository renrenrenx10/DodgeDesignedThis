-- Dodge Designed This — Gig Mode
-- Adds the gig_sales log table from the shop spec's suggested data model
-- (section 10): every sale logged from the admin Gig Mode screen, at the
-- gig price, regardless of whether it was paid in cash or on SumUp.
--
-- synced_at is set client-side the moment a queued offline sale is
-- actually written here — rows are always inserted with synced_at already
-- set (there's no server-side "pending" state), but the column is still
-- useful for an end-of-night "X sales, last synced at Y" read-out and for
-- telling a same-session queued sale apart from one that's already landed.

create table gig_sales (
  id uuid primary key default gen_random_uuid(),
  variant_id uuid not null references variants(id),
  price_pence integer not null,
  created_at timestamptz not null default now(),
  synced_at timestamptz not null default now()
);

create index gig_sales_created_at_idx on gig_sales (created_at desc);

alter table gig_sales enable row level security;

create policy "admin read gig_sales" on gig_sales
  for select using (auth.role() = 'authenticated');

create policy "admin write gig_sales" on gig_sales
  for insert with check (auth.role() = 'authenticated');
