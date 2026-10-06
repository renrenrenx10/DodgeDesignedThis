-- Dodge Designed This — initial schema
-- Products, variants (size/colour/stock), orders, order items.

create extension if not exists "pgcrypto";

create table products (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  category text not null,              -- 'tees' | 'hoodies-sweats' | 'caps' | 'out-the-bin' | 'band-print-bundles'
  title text not null,
  tag text,                            -- e.g. "Tees — Screen Printed"
  blurb text,                          -- short product description
  boilerplate text,                    -- category boilerplate paragraph (tees boilerplate etc.)
  price_pence integer not null,
  gig_price_pence integer,             -- nullable; not every category has a gig price
  active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table product_images (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  url text not null,
  alt text not null default '',
  sort_order integer not null default 0
);

create table variants (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  size text not null,                  -- 'XS' | 'S' | 'M' | 'L' | 'XL' | '2XL'
  colour text not null,
  colour_hex text,
  sku text unique,
  stock integer not null default 0,
  unique (product_id, size, colour)
);

create table orders (
  id uuid primary key default gen_random_uuid(),
  stripe_checkout_session_id text unique not null,
  stripe_payment_intent text,
  email text not null,
  customer_name text,
  shipping_address jsonb,
  status text not null default 'pending',   -- 'pending' | 'paid' | 'fulfilled' | 'cancelled'
  total_pence integer not null,
  created_at timestamptz not null default now()
);

create table order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  product_id uuid references products(id),
  variant_id uuid references variants(id),
  title text not null,
  size text,
  colour text,
  qty integer not null,
  unit_price_pence integer not null
);

-- Row Level Security
alter table products enable row level security;
alter table product_images enable row level security;
alter table variants enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;

-- Public (anon) can read active products/images/variants — this is the storefront.
create policy "public read active products" on products
  for select using (active = true);

create policy "public read product images" on product_images
  for select using (
    exists (select 1 from products p where p.id = product_images.product_id and p.active = true)
  );

create policy "public read variants" on variants
  for select using (
    exists (select 1 from products p where p.id = variants.product_id and p.active = true)
  );

-- Orders/order_items: no public access at all. Only the service role (used by
-- edge functions) and an authenticated admin can read/write these — add an
-- admin-specific policy once the admin login page exists and you know your
-- Supabase auth user id, e.g.:
--   create policy "admin read orders" on orders for select
--     using (auth.uid() = '<rene's supabase user id>');

-- Products/variants write access: same story — handled by the service role
-- for now (edge functions / manual SQL). Add authenticated-admin write
-- policies once Admin-Product / Admin-Stock pages are wired up.
