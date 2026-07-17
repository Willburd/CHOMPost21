/obj/item/gun
	persist_storable = FALSE
/obj/item/ammo_magazine
	persist_storable = FALSE //We're blocking guns, should block ammo, too. JUST INCASE someone wants to be funny
/obj/item/storage/backpack/holding
	persist_storable = FALSE //Maybe let's keep the high end "earn it" kind of stuff out?
/obj/item/storage/backpack/stunstaff
	persist_storable = FALSE //This one spawns with a weapon inside of it.
/obj/item/melee/artifact_blade
	persist_storable = FALSE //No cult tools.
/obj/item/areaeditor
	persist_storable = FALSE //Station blueprints and whatnot
/obj/item/archaeological_find
	persist_storable = FALSE //No xenoarch shit being kept. This stuff gets broken
/obj/item/bluespace_harpoon
	persist_storable = FALSE //Why was this missed in the first file?
/obj/item/assembly
	persist_storable = FALSE //Let's just cut off a huge hydra here...
/obj/item/card/emag
	persist_storable = TRUE //Intentionally allowing a rare funny here... if it's abused, just comment this line out, cuz /card is blocked in the original file.
/obj/item/capture_crystal
	persist_storable = FALSE //These have a lot of goofy presets and can be... silly. So let's not.
/obj/item/deadringer
	persist_storable = FALSE //Antag item.
/obj/item/dnainjector
	persist_storable = FALSE //Again, lot of broken stuff in here, easily exploitable. Even if once.
/obj/item/gunbox
	persist_storable = FALSE //Banning guns from being saved. A gun spawner should be caught, too.
/obj/item/mindbinder
	persist_storable = FALSE
/obj/item/research_sample
	persist_storable = FALSE //Not sure what these are but just to be safe.
/obj/item/spellbook
	persist_storable = FALSE //No long term magic, especially if books for more than one use get added.
