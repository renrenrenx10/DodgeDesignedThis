-- Seed data matching the current Tees mockup (placeholder prices/stock —
-- replace with real catalogue figures before going live).

insert into products (slug, category, title, tag, blurb, boilerplate, price_pence, gig_price_pence, sort_order)
values
  (
    'hide-and-seek-club-tee', 'tees', 'Hide & Seek Club Tee', 'Tees — Screen Printed',
    'Join the club nobody can find. The Hide & Seek Club Tee takes Bigfoot — the ultimate elusive legend — and puts him through the collegiate machine. Forget Latin mottos and ivy-league crests, this one celebrates the champion of disappearing acts. Bold varsity graphics, DIY energy, 100% cotton. Hand screen-printed in Sheffield on college yellow — every print has subtle variations, because Bigfoot doesn''t do perfect, and neither do we. Part homage, part joke, part punk manifesto. Wear it to gigs, basements, or the occasional forest adventure.',
    'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.',
    1000, 500, 1
  ),
  ('og-dodge-tee', 'tees', 'OG Dodge Tee', 'Tees — Screen Printed', null, null, 1000, 500, 2),
  ('attack-on-dodgetan', 'tees', 'Attack on Dodgetan', 'Tees — Screen Printed', null, null, 1000, 500, 3),
  ('brain-dump', 'tees', 'Brain Dump', 'Tees — Screen Printed', null, null, 1000, 500, 4),
  ('gtfod-garage-punks-tee', 'tees', 'GTFOD Garage Punks Tee', 'Tees — Screen Printed', null, null, 1000, 500, 5)
on conflict (slug) do nothing;

-- Hide & Seek Club Tee variants (the one product with full detail so far)
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('XS', 'College Yellow', '#F5D64B', 10),
  ('S',  'College Yellow', '#F5D64B', 10),
  ('M',  'College Yellow', '#F5D64B', 10),
  ('L',  'College Yellow', '#F5D64B', 10),
  ('XL', 'College Yellow', '#F5D64B', 10),
  ('XS', 'White', '#FFFFFF', 10),
  ('S',  'White', '#FFFFFF', 10),
  ('M',  'White', '#FFFFFF', 10),
  ('L',  'White', '#FFFFFF', 10),
  ('XL', 'White', '#FFFFFF', 10),
  ('XS', 'Black', '#0A0A0A', 10),
  ('S',  'Black', '#0A0A0A', 10),
  ('M',  'Black', '#0A0A0A', 10),
  ('L',  'Black', '#0A0A0A', 10),
  ('XL', 'Black', '#0A0A0A', 10)
) as v(size, colour, colour_hex, stock)
where p.slug = 'hide-and-seek-club-tee'
on conflict (product_id, size, colour) do nothing;

-- Note: 2XL deliberately left out here to match the mockup's "disabled" state
-- (shown but out of stock) — add a 2XL row with stock = 0 if you want it to
-- render as sold-out rather than hidden, once the real site reads live stock.
