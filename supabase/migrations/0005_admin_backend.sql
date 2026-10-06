-- Dodge Designed This — admin backend
-- Adds: authenticated-admin write access to products/variants/images/orders,
-- a site_settings key/value table (for things like the homepage category
-- tile images), and a public storage bucket for admin-uploaded images.
--
-- This is a single-admin shop, so every policy below just checks
-- auth.role() = 'authenticated' rather than a specific user id — there is
-- only one person who will ever have a login. Create that login in the
-- Supabase dashboard (Authentication -> Users -> Add user) with Rene's
-- email + a password; nothing here creates the user itself.

-- ---------------------------------------------------------------------------
-- Admin write access: products, variants, product_images
-- ---------------------------------------------------------------------------

create policy "admin read all products" on products
  for select using (auth.role() = 'authenticated');

create policy "admin write products" on products
  for insert with check (auth.role() = 'authenticated');

create policy "admin update products" on products
  for update using (auth.role() = 'authenticated');

create policy "admin delete products" on products
  for delete using (auth.role() = 'authenticated');

create policy "admin read all variants" on variants
  for select using (auth.role() = 'authenticated');

create policy "admin write variants" on variants
  for insert with check (auth.role() = 'authenticated');

create policy "admin update variants" on variants
  for update using (auth.role() = 'authenticated');

create policy "admin delete variants" on variants
  for delete using (auth.role() = 'authenticated');

create policy "admin read all product_images" on product_images
  for select using (auth.role() = 'authenticated');

create policy "admin write product_images" on product_images
  for insert with check (auth.role() = 'authenticated');

create policy "admin update product_images" on product_images
  for update using (auth.role() = 'authenticated');

create policy "admin delete product_images" on product_images
  for delete using (auth.role() = 'authenticated');

-- ---------------------------------------------------------------------------
-- Admin access: orders, order_items (read-only from the admin UI for now —
-- orders are written by the Stripe webhook edge function via the service
-- role, not from the browser)
-- ---------------------------------------------------------------------------

create policy "admin read orders" on orders
  for select using (auth.role() = 'authenticated');

create policy "admin update orders" on orders
  for update using (auth.role() = 'authenticated');

create policy "admin read order_items" on order_items
  for select using (auth.role() = 'authenticated');

-- ---------------------------------------------------------------------------
-- site_settings — small key/value store for admin-editable site content
-- that isn't a product. First use: the 3 homepage category tile images
-- (tees / hoodies-sweats / caps).
-- ---------------------------------------------------------------------------

create table site_settings (
  key text primary key,
  value text,
  updated_at timestamptz not null default now()
);

alter table site_settings enable row level security;

create policy "public read site_settings" on site_settings
  for select using (true);

create policy "admin write site_settings" on site_settings
  for insert with check (auth.role() = 'authenticated');

create policy "admin update site_settings" on site_settings
  for update using (auth.role() = 'authenticated');

-- Seed the 2 category tile keys that already have a real photo with the
-- existing static file paths, so the homepage keeps working exactly as it
-- does today until someone changes one from the admin Settings page. The
-- caps tile has no photo yet, so it's deliberately left unset — the admin
-- Settings page falls back to its own placeholder until one is uploaded.
insert into site_settings (key, value) values
  ('category_tile_tees', 'img/categories/tees.jpg'),
  ('category_tile_hoodies-sweats', 'img/categories/hoodies-sweats.jpg')
on conflict (key) do nothing;

-- ---------------------------------------------------------------------------
-- Storage bucket for admin-uploaded images (category tiles now, product
-- photos later). Public read (it's product/marketing photography, nothing
-- sensitive); only an authenticated admin can upload/replace/delete.
-- ---------------------------------------------------------------------------

insert into storage.buckets (id, name, public)
values ('site-assets', 'site-assets', true)
on conflict (id) do nothing;

create policy "public read site-assets" on storage.objects
  for select using (bucket_id = 'site-assets');

create policy "admin upload site-assets" on storage.objects
  for insert with check (bucket_id = 'site-assets' and auth.role() = 'authenticated');

create policy "admin update site-assets" on storage.objects
  for update using (bucket_id = 'site-assets' and auth.role() = 'authenticated');

create policy "admin delete site-assets" on storage.objects
  for delete using (bucket_id = 'site-assets' and auth.role() = 'authenticated');
