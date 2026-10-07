-- Dodge Designed This — AI listing helper fields
-- Adds the 3 extra fields the AI Listing Helper fills in alongside the
-- blurb: an SEO title, a meta description, and a few tags. All nullable —
-- nothing breaks for products that don't have them set.

alter table products add column if not exists seo_title text;
alter table products add column if not exists meta_description text;
alter table products add column if not exists tags text;
