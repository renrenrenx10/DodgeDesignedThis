-- Real catalogue, crawled from the live Freewebstore site on 2026-10-06.
-- Replaces the earlier placeholder tee/hoodie seed data (0002, 0003) with real
-- products, real stock counts, real sizes/colours and real descriptions.
-- Stock is the real total per product at crawl time, split evenly across each
-- product's size/colour combinations since Freewebstore didn't track per-variant
-- stock separately -- correct any individual counts once you're checking stock by hand.
-- Out The Bin (seeded in 0003) is untouched -- those are standalone one-offs, not
-- part of the main catalogue.

-- Remove the old placeholder products this replaces (cascades to their variants).
delete from products where slug in (
  'hide-and-seek-club-tee', 'og-dodge-tee', 'attack-on-dodgetan', 'brain-dump',
  'gtfod-garage-punks-tee', 'angry-ape-hoodie', 'wayne-campbell-purple-sweat'
);

insert into products (slug, category, title, tag, blurb, boilerplate, price_pence, gig_price_pence, active, sort_order)
values
  ('gtfod-angry-ape-hoodie', 'hoodies-sweats', 'GTFOD Angry Ape hoodie', 'Hoodies & Sweats — Screen Printed', 'Angry Ape is more than a hoody — it’s the start of an era. Featuring bold hand-printed graphics on both front and back, this piece was designed as a “get the outta Dodge” statement without using the F-word, capturing the irreverent, DIY spirit that defines the brand. Printed on heavyweight cotton, the hoody balances warmth, comfort, and durability, making it ready for gigs, streetwear, or long nights plotting your next chaotic adventure. The hand-printed technique ensures that every hoody carries subtle variations, giving each piece its own personality and making it a genuine one-of-a-kind item. Angry Ape launched a new chapter for the Dodge crew — a visual, wearable declaration of attitude, independence, and punk energy. Wear it to show you’re part of the movement, to make a statement, or just to stay warm while keeping it loud, cheeky, and unapologetic. This hoody isn’t just apparel; it’s a flag planted firmly in Dodge history. The LowDownUsually printed on Fruit of the Loom heavyweight cotton blend. Sometimes we switch brands, but we always aim to stay over 300gsm for every hoody. Hoody tech spec:Heavyweight cotton blendHand-printed front & backKangaroo pocketAdjustable drawcord hoodRibbed cuffs & hemSizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit — be nice.', 'All Dodge hoodies and sweats are hand screen-printed in Sheffield, one at a time. Heavyweight blanks, built to survive gigs, winters and whatever you throw at them. Hand-printed means no two are ever quite identical — that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run.', 2000, 1000, true, 1),
  ('hide-and-seek-club', 'hoodies-sweats', 'Hide & Seek Club', 'Hoodies & Sweats — Screen Printed', 'The Hide & Seek Club sweatshirt flips collegiate tradition on its head. Forget crests, Latin mottos, and ivy-league pretense — this one celebrates the ultimate elusive champion: Bigfoot. Bold, hand-screen-printed graphics on heavyweight cotton capture the parody while keeping it authentically DIY. Each print carries tiny variations, making every sweatshirt a unique piece of wearable urban legend. It’s part homage, part joke, part punk manifesto: a statement that says, “we do our own thing.” The heavyweight cotton is warm, durable, and built to survive gigs, basements, and the occasional forest adventure. The sweatshirt embodies the spirit of Dodge: playful, rebellious, and unapologetically handcrafted. It’s meant to be worn into life, not polished into oblivion. Each piece connects you to DIY punk energy, Bigfoot mythos, and a cheeky reimagining of collegiate tradition. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge hoodies and sweats are hand screen-printed in Sheffield, one at a time. Heavyweight blanks, built to survive gigs, winters and whatever you throw at them. Hand-printed means no two are ever quite identical — that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run.', 1500, 750, true, 2),
  ('hide-and-seek-club-big-foot-sasquatch-tee', 'tees', 'Hide & Seek Club Big Foot/Sasquatch Tee', 'Tees — Screen Printed', 'Join the club nobody can find. The Hide & Seek Club Tee takes Bigfoot — the ultimate elusive legend — and puts him through the collegiate machine. Forget Latin mottos and ivy-league crests. This one celebrates the champion of disappearing acts. Bold varsity graphics, DIY energy, 100% cotton. Hand screen-printed in Sheffield on college yellow. Every print has subtle variations — because Bigfoot doesn''t do perfect, and neither do we. Part homage, part joke, part punk manifesto. Wear it to gigs, basements, or the occasional forest adventure. THE BASICS Printed on tees over 150GSM. Sizes S–2XL. College yellow. Wash inside-out cool machine wash. Tumble dry at your own risk.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 1),
  ('og-dodge-tee-est-2021', 'tees', 'OG Dodge Tee (Est. 2021)', 'Tees — Screen Printed', 'Before zombies, parodies, gorillas, and chaos, there was the OG Dodge Tee. Our first-ever design, printed in 2021 when we had more attitude than equipment and more ideas than sense. The bold, minimal design planted the Dodge flag firmly in punk soil. Hand-pulled and slightly rough around the edges, the tee carries a raw, handcrafted feel that makes every shirt unique. The “Dodge Designed This” stamp isn’t just a logo — it’s a declaration: home-brewed, hand-printed, and built to stand out in a sea of mass-produced nothingness. Still our reference point, the OG Dodge Tee represents the ethos, humour, and DIY spirit that defines the brand. Wear it to gigs, streets, or anywhere you want to carry a piece of Dodge history. This is the tee that answers the question, “so what’s Dodge all about?” — and the answer is simple: this. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 2),
  ('brain-dump', 'tees', 'Brain Dump', 'Tees — Screen Printed', '“Brain Dump” is the tee for anyone whose thoughts are a bit too messy for polite conversation. It’s a hand-drawn zombie with a tin can where its brain should be, snarling in a way that feels both hilarious and unsettling. The design is pure DIY energy, inspired by ’90s zines, photocopies, and the kind of chaos that punk thrives on. Printed by hand on soft cotton, each tee has tiny variations that make it one of a kind — just like your head when it’s full of too many ideas at once. The ink bonds to the fabric for durability while keeping the raw, imperfect vibe that defines the Dodge boys’ work. Every shirt is ready to be worn, survived, and loved. It’s not just a design; it’s a statement: embrace the mess, stay loud, and wear your chaos with pride. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 3),
  ('wayne-campbell-donna-tee', 'tees', 'The Wayne Campbell', 'Tees — Screen Printed', '“Wayne’s World, Wayne’s World, party time, excellent!” If you read that in the voice, you already get it. This is Wayne Campbell — cable-access hero, basement philosopher, and patron saint of wearing your own merch. Only this time, he’s not plugging Aurora’s number-one public-access show. He’s all in on Dodge Designed This. The Wayne Campbell tee takes that classic grinning thumbs-up pose and drags it through the DIY screen-printing process. The result? A bold, raw black-and-white design that looks like it could’ve been torn from a zine in ’92, bootlegged at the back of the record store, and sold next to VHS tapes of Wayne’s World taped off late-night telly. It’s equal parts parody and tribute: a nod to the joy of dumb jokes, loud music, and cult cinema, but filtered through Dodge’s grimy, hand-pulled aesthetic. Like Wayne himself, it’s unpolished, enthusiastic, and completely in on the joke. Wear it to gigs, wear it to the pub, or wear it to explain to confused strangers that yes, it’s Wayne Campbell, yes, it says Dodge Designed This, and yes, that makes perfect sense if you live in our world. The LowDownPrinted on Bella & Canvas EcoMax Short Sleeve Tee.These are a bit stretchy Tee tech spec:150gsmFabric: 65% recycled polyester, 35% recycled Airlume combed and ring-spun cottonSizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit — be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 4),
  ('baby-baybi', 'tees', 'Baby BAYBI', 'Tees — Screen Printed', 'Baby BAYBI! is our hand-printed homage to the iconic Paul Shane moment on Pebble Mill back in the 1990s — the pre-internet, pre-VHS, unrepeatable performance of You Lost the Loving Feeling. For those lucky enough to see it live, it’s seared into memory; for everyone else, this tee is the closest you’ll get to that chaotic, giddy, unforgettable magic. The design captures Shane mid-performance, full of energy, emotion, and charm. Hand screen-printed on soft cotton, every print carries slight variations, giving each shirt its own personality — just like the original moment, which could never be replicated. It’s punk, DIY, and celebratory of fleeting brilliance, a wearable shrine to pre-digital TV absurdity. Wear it if you love cult performances, absurd nostalgia, or just want a tee that sparks conversations, laughter, and occasional disbelief. Baby BAYBI! isn’t just merch — it’s a statement: some moments are bigger than the internet, and some performances are legendary enough to deserve their own shirt. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 5),
  ('attack-on-dodgetan', 'tees', 'Attack on Dodgetan', 'Tees — Screen Printed', '“Attack on Dodgetin” isn’t just a t-shirt. It’s chaos, punk, and cult anime energy all rolled into one thick, hand-printed slab of cotton. Designed by our good friend Thomas Mannion as the cover for These Songs Aren’t Ours, it smashes onto fabric with titanic force, featuring scratchy, anarchic lines and a face that’s half-snarling, half-legendary — the kind of image that makes people stop, stare, and double-take. Every line, every ink stroke feels alive, like it might leap off the shirt and join you on the street, ready to wreak havoc at any moment. It embodies DIY energy in its purest form. Nothing about it is clean or safe. It’s messy, chaotic, and completely unapologetic — the perfect visual representation of surviving the attack while standing out from the crowd. Wearing it makes a statement: you’re loud, independent, and you don’t play by conventional rules. The combination of punk aesthetics and cult anime influence gives it a rebellious personality all its own, making it the kind of tee that sparks conversation, admiration, and the occasional jealous glance. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 6),
  ('be-excellent-to-each-other', 'tees', 'Be Excellent To Each Other', 'Tees — Screen Printed', '“Be Excellent To Each Other” isn’t just a line from a cult classic — it’s a philosophy, now emblazoned on a tee that blends nostalgia and punk grit. This design takes Bill & Ted’s Excellent Adventure and runs it through the Dodge boys’ DIY lens, creating a shirt that feels simultaneously playful and rebellious. The artwork is hand-pulled on soft cotton, giving every tee unique quirks that machine prints can’t replicate. Tiny variations in the ink add character, making each shirt a one-off slice of punk culture. It’s designed for life: surviving garage gigs, long nights, and all the chaos you throw at it. At 165gsm, the cotton balances comfort with durability, resisting the flimsy feel of mass-market tees while staying light enough to wear all day. Beyond the material, the shirt carries a message. “Be Excellent To Each Other” started as a line in a stoner comedy but became a code for kindness, friendship, and chaos done right. Punk has always been about connection as much as rebellion — looking out for your mates, sharing moments, and enjoying the ride. This tee embodies that spirit, reminding you that attitude matters as much as aesthetics. The Dodge boys’ approach isn’t about perfection. It’s about heart, DIY energy, and culture you can wear. Each print is hand-crafted with care, bonded to the cotton so it lasts through washes and wear. Over time, the tee develops its own life — a lived-in feel that mirrors the ethos of punk itself: rough around the edges, authentic, and proudly individual. Culturally, it bridges worlds. Late-night VHS obsession meets garage-band scrappiness. The line is nostalgic, but the attitude is timeless. It’s for anyone who understands that a simple philosophy can carry a lot of weight: be loud, be kind, be excellent. This isn’t just a garment — it’s a conversation starter, a reminder, and a badge for anyone who values friendship, laughter, and the DIY way. Wear it into life, into chaos, and into the moments that make memories. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 7),
  ('d-a-r-e', 'tees', 'D.A.R.E', 'Tees — Screen Printed', 'The D.A.R.E. tee is a rebellion wrapped in red ink. Remember those stiff school shirts? The Dodge remix tosses that idea out the window. Bold red lettering, DIY screen printing, and a slogan that refuses to play nice — that’s the essence. This was our first experiment using two colours on one screen, which gives each print slight roughness around the edges. That’s the point. Punk has never been about perfection, and this shirt embraces the raw energy that makes each piece unique. Every tee is hand-pulled, so no two are exactly the same. It’s meant for anyone who values authenticity over polish, chaos over conformity, and attitude over trends. Wear it proud, loud, and unapologetic — a true Dodge original. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 800, 400, true, 8),
  ('easter-bonnie', 'tees', 'Easter Bonnie', 'Tees — Screen Printed', 'Easter Bonnie hops straight from the haunted mind of Thomas Mannion. Half cute, half terrifying, this stitched-up bunny looks like it crawled out of an abandoned soft play centre and onto your chest. The bold white print pops on black cotton, capturing the right amount of wrong without losing clarity. Hand-pulled, every tee carries subtle variations, keeping the design alive and uniquely Dodge. Part horror, part parody, fully punk — it embodies the brand’s “who asked for this? (we did)” energy. Perfect for fans of weird art, creepy humour, or anyone wanting a tee that breaks the rules of seasonal cheer. Wear it to gigs, nights out, or just to confuse the neighbours. Easter Bonnie is absurd, chaotic, and a perfect example of Dodge’s DIY ethos translated into cotton and ink. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 9),
  ('goop', 'tees', 'Goop', 'Tees — Screen Printed', 'Goop takes Sonic Youth’s iconic Goo album cover and flips it into Dodge territory. Equal parts homage, equal parts piss-take, the design turns legendary artwork into something bold, grimy, and chaotic. Hand screen-printed on heavyweight cotton, the ink captures the perfect balance of sharp lines and DIY roughness, giving every shirt its own subtle quirks. This tee celebrates music, parody, and the absurd joy of messing with cultural icons. Each print is slightly unique, reflecting the imperfections that make Dodge originals so special. Perfect for gigs, pub debates, or just showing off your love of loud graphics and DIY energy, Goop turns a classic album into wearable chaos. It’s bold, it’s weird, it’s probably sacrilegious to some — but that’s the point. Dodge doesn’t do subtle. This tee is loud, proud, and ready to spark conversation, nostalgia, and a little discomfort in equal measure. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 800, 400, true, 10),
  ('gtfod-cbgb-burgundy-tee', 'tees', 'GTFOD - CBGB Burgundy Tee', 'Tees — Screen Printed', 'GTFOD CBGB is a love letter to punk’s golden era and James Dodge’s personal holy trinity: 3/4 raglan sleeves (on the original, not this), punk, and CBGBs. We ripped the iconic font, flipped the text, and threw in a gorilla — a little extra chaos to celebrate the DIY spirit. Hand screen-printed on a Burgendy, each tee carries subtle variations that make every print one of a kind. The ink is bold but imperfect, maintaining the raw energy that embodies both Dodge and the sweat-soaked clubs of New York. This shirt is about nostalgia and attitude: it references punk history while giving it a cheeky Dodge twist. Wear it for gigs, for streetwear rebellion, or just to remember the times when punk meant community, chaos, and loud, unapologetic energy. This is not a polished homage; it’s a living, breathing, hand-made piece of DIY punk history. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 11),
  ('gtfod-rubber-hose', 'tees', 'GTFOD Rubber Hose', 'Tees — Screen Printed', 'The Rubber Hose tee is a collision of eras, punk, and city pride. Drawing on the elastic-limbed style of 1930s cartoons, the design explodes into a pair of chaotic characters with radioactive grins, pushing vintage visuals into noisy, modern territory. Sheffield’s garage punk energy bleeds through every hand-pulled screen print, making each shirt unique, raw, and full of movement. Printed on bright green cotton, it pops visually while retaining that DIY roughness that makes Dodge originals unmistakable. The hand-screened ink adheres firmly but keeps the imperfections that define its punk character. Each tee is slightly different, embodying the same chaotic unpredictability that made the city’s music scene legendary. This shirt isn’t just for style — it’s a manifesto. It’s cartoons done loud, punk done personal, and chaos worn proudly. It bridges nostalgia and present-day energy, giving anyone who wears it a slice of Sheffield’s underground spirit. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 12),
  ('gtfod-vs-kiyomi', 'tees', 'GTFOD vs kiYOmi', 'Tees — Screen Printed', 'GTFOD Vs kiYOmi is more than a t-shirt — it’s a bridge across continents, connecting Sheffield’s DIY punk energy with Tokyo’s manga artistry. Designed by kiYOmi, the illustration was originally the cover for our split EP, where Japanese vocals collided with Dodge tracks. On fabric, the design bursts with motion and raw intensity, echoing the energy of both cities’ underground cultures. Hand screen-printed on soft cotton, each tee has subtle differences, making every shirt unique. The ink adheres tightly while preserving the raw, imperfect edge that defines Dodge prints. The piece captures contrast, movement, and a narrative that is both collaborative and chaotic. This shirt tells a story of friendship, music, and the crossing of creative worlds — Sheffield grit meeting Tokyo flair, immortalised in ink and cotton. It’s a tee for anyone who values authenticity, storytelling, and the thrill of culture mixing. It’s loud, it’s bold, and it’s unapologetically DIY. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 13),
  ('gtfod-cbgb', 'tees', 'GTFOD-CBGB', 'Tees — Screen Printed', 'GTFOD CBGB is a love letter to punk’s golden era and James Dodge’s personal holy trinity: 3/4 raglan sleeves, punk, and CBGBs. We ripped the iconic font, flipped the text, and threw in a gorilla — a little extra chaos to celebrate the DIY spirit. Hand screen-printed on a black-and-white raglan, each tee carries subtle variations that make every print one of a kind. The ink is bold but imperfect, maintaining the raw energy that embodies both Dodge and the sweat-soaked clubs of New York. This shirt is about nostalgia and attitude: it references punk history while giving it a cheeky Dodge twist. Wear it for gigs, for streetwear rebellion, or just to remember the times when punk meant community, chaos, and loud, unapologetic energy. This is not a polished homage; it’s a living, breathing, hand-made piece of DIY punk history. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 14),
  ('real-life-goo', 'tees', 'Real Life Goo', 'Tees — Screen Printed', 'Reality bites, and this tee proves it. The Real Life Goo design takes the cult energy of Sonic Youth’s legendary album art and flips it into pure Dodge territory. Shot like a lo-fi zine cover, it captures that perfect mix of attitude, humour, and homemade charm — a modern-day snapshot of chaos in graphic form.Printed by hand in the UK, no two are exactly the same — part tribute, part parody, and fully loaded with punk DIY spirit. Whether you actually remember the original ‘Goo’ or just wish you did, this one’s for the lovers of irony, lo-fi legends, and Vans-wearing villains.Soft cotton, crisp print, and just enough nostalgia to make you look twice. Wear it, smirk, and remember: sometimes art imitates life — badly.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 15),
  ('wayne-campbell-purple-sweat', 'hoodies-sweats', 'The Wayne Campbell', 'Hoodies & Sweats — Screen Printed', 'Party time. Excellent. But make it cosy. The Wayne Campbell sweatshirt takes the grinning thumbs-up parody from the tee and puts it on a purple B&C Collection sweatshirt — because Wayne Campbell would absolutely have a purple sweatshirt and it would absolutely be mint. Bold black-and-white screen print. Hand-pulled in Sheffield. The heavy 280gsm fabric is built to survive gigs, winters, and whatever chaos you throw at it. Equal parts parody, tribute, and just a genuinely good sweatshirt. Independent parody/tribute design. Not affiliated with or endorsed by any rights holder. THE BASICS B&C Collection 280gsm, 80% cotton/20% polyester. Sizes S–2XL. Purple. Wash inside-out cool machine wash. Tumble dry at your own risk.', 'All Dodge hoodies and sweats are hand screen-printed in Sheffield, one at a time. Heavyweight blanks, built to survive gigs, winters and whatever you throw at them. Hand-printed means no two are ever quite identical — that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run.', 1500, 750, true, 3),
  ('human-beanz', 'tees', 'Human Beanz', 'Tees — Screen Printed', 'Human Beanz is what happens when everyday breakfast collides with underground weirdness. Designed by Thomas Mannion, it transforms a humble tin of beans into a disturbing, surreal figure that’s simultaneously absurd and hilarious. Hand-pulled screen printing brings the design to life, leaving subtle imperfections that make each shirt unique — much like the chaotic can it depicts. The shirt embodies Dodge’s DIY ethos: raw, rough around the edges, and unapologetically strange. Printed on soft cotton, the fabric balances comfort with durability, ensuring the artwork survives gigs, nights out, and general daily chaos. The visual impact is immediate: absurd imagery, bold lines, and quirks in the ink make each tee a conversation starter. Wear it as a badge for fans of dark humour, punk culture, and off-kilter art. It’s a shirt that’s equal parts statement, joke, and collectible, reflecting the weird, noisy, and creative energy of Dodge. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 16),
  ('live-fast-print-hard-trucker-cap', 'caps', 'Live Fast / Print Hard Trucker Cap', 'Caps — Screen Printed', 'A skull, a slogan, and a screen-print attitude. The Live Fast / Print Hard trucker cap is Dodge Designed This in wearable form — unapologetic, handmade, and built for chaos.It’s half tribute to punk’s DIY ethics and half reminder that creativity doesn’t clock off. Featuring the Dodge skull logo front and centre, this cap was made for anyone who burns through ink, ideas, and the occasional late-night print run.Black-and-white contrast mesh keeps it classic, while the hand-printed design keeps it dirty in the best possible way. Whether you’re pulling a squeegee, hitting a gig, or just trying to look like you don’t sleep — this one’s for you.Live fast. Print hard. Repeat until burnout.', 'Hand screen-printed caps, one size fits most. Free UK postage on everything. Same print''s a couple quid cheaper at gigs.', 1000, 800, true, 1),
  ('meltvis', 'tees', 'Meltvis', 'Tees — Screen Printed', 'Meet Meltvis — Elvis after too many nights under the stage lights, fully in meltdown mode. Designed by Thomas Mannion, the artwork is part parody, part horror, and all attitude. The dripping King motif transforms the iconic rock’n’roll figure into surreal, chaotic artwork, perfectly capturing Dodge’s DIY spirit. Hand screen-printed on quality cotton, each shirt carries subtle variations in the ink, ensuring no two Meltvis tees are exactly the same. The bold black-on-white design pops while maintaining that slightly rough, handcrafted feel that defines every Dodge original. Whether you’re an Elvis fan, a Mannion fan, or just someone who loves shirts that make people do a double-take, Meltvis is your new gig companion. It’s grotesque, iconic, chaotic, and still somehow cool. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 17),
  ('its-not-our-fault-that-your-boyfriends-stupid', 'tees', 'Its Not Our Fault That Your Boyfriends Stupid', 'Tees — Screen Printed', 'It’s Not Our Fault Your Boyfriend’s Stupid translates Mannion’s LP cover into wearable chaos. The surreal slab of ink is equal parts creepy, funny, and absurd — a perfect example of Dodge embracing their own brand of ugly-beautiful nonsense. Hand-pulled on heavyweight cotton, each print carries slight imperfections that give it character, echoing the raw energy of the original artwork. This isn’t just merch; it’s a historical snapshot of Dodge’s creative evolution. The shirt embodies the era when the band stopped trying to please anyone and leaned fully into their unique vision. The heavyweight cotton ensures durability while keeping the tee comfortable, making it suitable for gigs, streetwear, or just lounging in unapologetic style. Wear it if you’ve ever loved a record so much you wanted to crawl inside the artwork. Wear it if you’ve ever rolled your eyes at a bad boyfriend. Mostly — wear it because it looks sick and perfectly embodies DIY punk attitude. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 18),
  ('renvis-and-butt-james', 'tees', 'Renvis & Butt-James', 'Tees — Screen Printed', 'Some friendships are forged in noise, cheap beer, and really dumb jokes. Renvis & Butt-James is our parody of the kings of 90s stupidity, Beavis & Butt-Head, reimagined as Dodge boys. The hand-pulled black-and-white screen print brings a crisp, raw, DIY energy that perfectly captures the essence of irreverent friendship and chaotic humour. The tee balances comfort and durability with heavyweight cotton, making it ready for gigs, shops, and even questionable washing cycles. Every shirt carries slight variations from hand-printing, so each piece is unique — just like the ridiculous antics it celebrates. It’s not high art — it’s low-brow brilliance. Wear it to share a laugh, make your mates snort, or just flex the chaotic energy of Dodge in your wardrobe. It’s punk, it’s funny, it’s unapologetic — and it’s ready to survive everything you throw at it. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 19),
  ('they-lived', 'tees', 'They Lived', 'Tees — Screen Printed', 'They Lived is a hand-printed homage to John Carpenter’s cult classic They Live, translated through a punk DIY lens. The iconic shades, hidden messages, and underground paranoia are reimagined as bold black-and-white artwork on soft cotton, with textures that feel like a back-alley zine or garage cinema flyer. Hand screen-printing ensures each shirt is unique, with subtle imperfections that add character and depth. The design captures the essence of the film — seeing the truth beneath the surface — while staying firmly in the realm of Dodge’s chaotic, DIY aesthetic. The tee balances bold visuals with comfortable wear, making it a statement piece for fans of cult cinema, punk culture, and underground art. Wear it as a reminder that sometimes the world is stranger than it seems and that underground culture always notices what’s really going on. This tee turns classic paranoia into wearable punk philosophy. The LowDownUsually printed on Fruit of the Loom Valueweight 165gsm. Sometimes we switch brands, but we always aim to stay over 150gsm for every tee. Tee tech spec:Fruit of the Loom Valueweight 165gsm100% CottonCrew neck with Cotton/ LYCRA® ribSelf-fabric neck tapeFine knit gauge for enhanced printabilitySizes: S–2XL Wash sensibly. Tumble drying is at yr risk, but if it shrinks, that’s on you.If your size or print is out of stock, just holla up — we’ll try and work something out.This is just a one-man-band kinda outfit - be nice.', 'All Dodge tees are hand screen-printed in Sheffield, one at a time. We rotate between different tee stocks, but nothing ever goes out under 150gsm — proper weight, not fast-fashion tissue paper. Hand-printed means no two shirts are ever quite identical: smudges, wobble and all, that''s the point, not a fault. Free UK postage on everything. Can''t see your size? Just shout, we''ll sort a custom run. Same print''s a fiver at gigs.', 1000, 500, true, 20)
on conflict (slug) do nothing;

-- Variants (size/colour/stock), one insert block per product.
-- GTFOD Angry Ape hoodie (gtfod-angry-ape-hoodie) -- 8 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 2),
  ('M', 'Default', null, 2),
  ('L', 'Default', null, 2),
  ('2XL', 'Default', null, 2)
) as v(size, colour, colour_hex, stock)
where p.slug = 'gtfod-angry-ape-hoodie'
on conflict (product_id, size, colour) do nothing;

-- Hide & Seek Club (hide-and-seek-club) -- 3 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'hide-and-seek-club'
on conflict (product_id, size, colour) do nothing;

-- Hide & Seek Club Big Foot/Sasquatch Tee (hide-and-seek-club-big-foot-sasquatch-tee) -- 5 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Yellow', '#F5D64B', 1),
  ('M', 'Yellow', '#F5D64B', 1),
  ('L', 'Yellow', '#F5D64B', 1),
  ('XL', 'Yellow', '#F5D64B', 1),
  ('2XL', 'Yellow', '#F5D64B', 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'hide-and-seek-club-big-foot-sasquatch-tee'
on conflict (product_id, size, colour) do nothing;

-- OG Dodge Tee (Est. 2021) (og-dodge-tee-est-2021) -- 1 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Black', '#0A0A0A', 1),
  ('S', 'White', '#FFFFFF', 0),
  ('S', 'Yellow', '#F5D64B', 0),
  ('M', 'Black', '#0A0A0A', 0),
  ('M', 'White', '#FFFFFF', 0),
  ('M', 'Yellow', '#F5D64B', 0),
  ('L', 'Black', '#0A0A0A', 0),
  ('L', 'White', '#FFFFFF', 0),
  ('L', 'Yellow', '#F5D64B', 0),
  ('XL', 'Black', '#0A0A0A', 0),
  ('XL', 'White', '#FFFFFF', 0),
  ('XL', 'Yellow', '#F5D64B', 0),
  ('2XL', 'Black', '#0A0A0A', 0),
  ('2XL', 'White', '#FFFFFF', 0),
  ('2XL', 'Yellow', '#F5D64B', 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'og-dodge-tee-est-2021'
on conflict (product_id, size, colour) do nothing;

-- Brain Dump (brain-dump) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 0),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'brain-dump'
on conflict (product_id, size, colour) do nothing;

-- The Wayne Campbell (wayne-campbell-donna-tee) -- 8 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 2),
  ('M', 'Default', null, 2),
  ('L', 'Default', null, 2),
  ('XL', 'Default', null, 1),
  ('2XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'wayne-campbell-donna-tee'
on conflict (product_id, size, colour) do nothing;

-- Baby BAYBI (baby-baybi) -- 5 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 1),
  ('2XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'baby-baybi'
on conflict (product_id, size, colour) do nothing;

-- Attack on Dodgetan (attack-on-dodgetan) -- 3 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Yellow', '#F5D64B', 1),
  ('S', 'Power Blue', '#4169E1', 1),
  ('S', 'White', '#FFFFFF', 1),
  ('M', 'Yellow', '#F5D64B', 0),
  ('M', 'Power Blue', '#4169E1', 0),
  ('M', 'White', '#FFFFFF', 0),
  ('L', 'Yellow', '#F5D64B', 0),
  ('L', 'Power Blue', '#4169E1', 0),
  ('L', 'White', '#FFFFFF', 0),
  ('XL', 'Yellow', '#F5D64B', 0),
  ('XL', 'Power Blue', '#4169E1', 0),
  ('XL', 'White', '#FFFFFF', 0),
  ('2XL', 'Yellow', '#F5D64B', 0),
  ('2XL', 'Power Blue', '#4169E1', 0),
  ('2XL', 'White', '#FFFFFF', 0),
  ('3XL', 'Yellow', '#F5D64B', 0),
  ('3XL', 'Power Blue', '#4169E1', 0),
  ('3XL', 'White', '#FFFFFF', 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'attack-on-dodgetan'
on conflict (product_id, size, colour) do nothing;

-- Be Excellent To Each Other (be-excellent-to-each-other) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Black Tee-White Ink', '#0A0A0A', 1),
  ('S', 'Pink Tee - White Ink', '#FFC0CB', 1),
  ('M', 'Black Tee-White Ink', '#0A0A0A', 0),
  ('M', 'Pink Tee - White Ink', '#FFC0CB', 0),
  ('L', 'Black Tee-White Ink', '#0A0A0A', 0),
  ('L', 'Pink Tee - White Ink', '#FFC0CB', 0),
  ('XL', 'Black Tee-White Ink', '#0A0A0A', 0),
  ('XL', 'Pink Tee - White Ink', '#FFC0CB', 0),
  ('2XL', 'Black Tee-White Ink', '#0A0A0A', 0),
  ('2XL', 'Pink Tee - White Ink', '#FFC0CB', 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'be-excellent-to-each-other'
on conflict (product_id, size, colour) do nothing;

-- D.A.R.E (d-a-r-e) -- 4 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 1),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'd-a-r-e'
on conflict (product_id, size, colour) do nothing;

-- Easter Bonnie (easter-bonnie) -- 5 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 2),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'easter-bonnie'
on conflict (product_id, size, colour) do nothing;

-- Goop (goop) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 0),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'goop'
on conflict (product_id, size, colour) do nothing;

-- GTFOD - CBGB Burgundy Tee (gtfod-cbgb-burgundy-tee) -- 1 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('One Size', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'gtfod-cbgb-burgundy-tee'
on conflict (product_id, size, colour) do nothing;

-- GTFOD Rubber Hose (gtfod-rubber-hose) -- 10 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Red', '#CC2936', 1),
  ('S', 'Army Green', '#4B5320', 1),
  ('S', 'Green', '#228B22', 1),
  ('S', 'Brown', '#6F4E37', 1),
  ('M', 'Red', '#CC2936', 1),
  ('M', 'Army Green', '#4B5320', 1),
  ('M', 'Green', '#228B22', 1),
  ('M', 'Brown', '#6F4E37', 1),
  ('L', 'Red', '#CC2936', 1),
  ('L', 'Army Green', '#4B5320', 1),
  ('L', 'Green', '#228B22', 0),
  ('L', 'Brown', '#6F4E37', 0),
  ('XL', 'Red', '#CC2936', 0),
  ('XL', 'Army Green', '#4B5320', 0),
  ('XL', 'Green', '#228B22', 0),
  ('XL', 'Brown', '#6F4E37', 0),
  ('2XL', 'Red', '#CC2936', 0),
  ('2XL', 'Army Green', '#4B5320', 0),
  ('2XL', 'Green', '#228B22', 0),
  ('2XL', 'Brown', '#6F4E37', 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'gtfod-rubber-hose'
on conflict (product_id, size, colour) do nothing;

-- GTFOD vs kiYOmi (gtfod-vs-kiyomi) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 0),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'gtfod-vs-kiyomi'
on conflict (product_id, size, colour) do nothing;

-- GTFOD-CBGB (gtfod-cbgb) -- 5 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 1),
  ('2XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'gtfod-cbgb'
on conflict (product_id, size, colour) do nothing;

-- Real Life Goo (real-life-goo) -- 9 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 2),
  ('M', 'Default', null, 2),
  ('L', 'Default', null, 2),
  ('XL', 'Default', null, 2),
  ('2XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'real-life-goo'
on conflict (product_id, size, colour) do nothing;

-- The Wayne Campbell (wayne-campbell-purple-sweat) -- 3 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'wayne-campbell-purple-sweat'
on conflict (product_id, size, colour) do nothing;

-- Human Beanz (human-beanz) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'human-beanz'
on conflict (product_id, size, colour) do nothing;

-- Live Fast / Print Hard Trucker Cap (live-fast-print-hard-trucker-cap) -- 4 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('One Size', 'Default', null, 4)
) as v(size, colour, colour_hex, stock)
where p.slug = 'live-fast-print-hard-trucker-cap'
on conflict (product_id, size, colour) do nothing;

-- Meltvis (meltvis) -- 2 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 0),
  ('XL', 'Default', null, 0),
  ('2XL', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'meltvis'
on conflict (product_id, size, colour) do nothing;

-- Its Not Our Fault That Your Boyfriends Stupid (its-not-our-fault-that-your-boyfriends-stupid) -- 5 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('S', 'Default', null, 1),
  ('M', 'Default', null, 1),
  ('L', 'Default', null, 1),
  ('XL', 'Default', null, 1),
  ('2XL', 'Default', null, 1)
) as v(size, colour, colour_hex, stock)
where p.slug = 'its-not-our-fault-that-your-boyfriends-stupid'
on conflict (product_id, size, colour) do nothing;

-- Renvis & Butt-James (renvis-and-butt-james) -- 3 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('One Size', 'Default', null, 3)
) as v(size, colour, colour_hex, stock)
where p.slug = 'renvis-and-butt-james'
on conflict (product_id, size, colour) do nothing;

-- They Lived (they-lived) -- 0 total units at crawl time
insert into variants (product_id, size, colour, colour_hex, stock, sku)
select p.id, v.size, v.colour, v.colour_hex, v.stock, p.slug || '-' || lower(v.size) || '-' || lower(replace(v.colour, ' ', '-'))
from products p
cross join (values
  ('One Size', 'Default', null, 0)
) as v(size, colour, colour_hex, stock)
where p.slug = 'they-lived'
on conflict (product_id, size, colour) do nothing;
-- Real product photos we actually have on file for this batch (the rest still
-- show a placeholder box on the storefront until photos exist for them).
insert into product_images (product_id, url, alt, sort_order)
select p.id, v.url, v.alt, 0
from products p
cross join (values
  ('gtfod-angry-ape-hoodie', 'img/products/gtfod-angry-ape-hoodie.webp', 'GTFOD Angry Ape Hoodie'),
  ('wayne-campbell-purple-sweat', 'img/products/wayne-campbell-purple-sweat.webp', 'The Wayne Campbell — Purple Sweat'),
  ('hide-and-seek-club-big-foot-sasquatch-tee', 'img/products/hide-and-seek-club-big-foot-sasquatch-tee.webp', 'Hide & Seek Club Big Foot/Sasquatch Tee'),
  ('baby-baybi', 'img/products/baby-baybi.webp', 'Baby BAYBI'),
  ('real-life-goo', 'img/products/real-life-goo.webp', 'Real Life Goo'),
  ('brain-dump', 'img/products/brain-dump.webp', 'Brain Dump')
) as v(slug, url, alt)
where p.slug = v.slug
on conflict do nothing;
