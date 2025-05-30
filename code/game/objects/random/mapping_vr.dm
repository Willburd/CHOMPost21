/obj/random/empty_or_lootable_crate
	name = "random crate"
	desc = "Spawns a random crate which may or may not have contents. Sometimes spawns nothing."
	icon = 'icons/obj/storage.dmi'
	icon_state = "moneybag"
	spawn_nothing_percentage = 20

/obj/random/empty_or_lootable_crate/item_to_spawn()
	return pick(/obj/random/crate,
			/obj/random/multiple/corp_crate)

/obj/random/forgotten_tram
	name = "random forgotten tram item"
	desc = "Spawns a random item that someone might accidentally leave on a tram. Sometimes spawns nothing."
	spawn_nothing_percentage = 30

/obj/random/forgotten_tram/item_to_spawn()
	return pick(
			prob(2);/obj/item/flashlight,
			prob(2);/obj/item/flashlight/color,
			prob(2);/obj/item/flashlight/color/green,
			prob(2);/obj/item/flashlight/color/purple,
			prob(2);/obj/item/flashlight/color/red,
			prob(2);/obj/item/flashlight/color/orange,
			prob(2);/obj/item/flashlight/color/yellow,
			prob(2);/obj/item/flashlight/glowstick,
			prob(2);/obj/item/flashlight/glowstick/blue,
			prob(1);/obj/item/flashlight/glowstick/orange,
			prob(1);/obj/item/flashlight/glowstick/red,
			prob(1);/obj/item/flashlight/glowstick/yellow,
			prob(1);/obj/item/flashlight/pen,
			prob(2);/obj/item/flashlight/maglight,
			prob(5);/obj/random/cigarettes,
			prob(5);/obj/random/soap,
			prob(5);/obj/random/drinksoft,
			prob(5);/obj/random/snack,
			prob(5);/obj/random/plushie,
			prob(2);/obj/item/storage/secure/briefcase,
			prob(4);/obj/item/storage/briefcase,
			prob(5);/obj/item/storage/backpack,
			prob(5);/obj/item/storage/backpack/medic,
			prob(5);/obj/item/storage/backpack/industrial,
			prob(5);/obj/item/storage/backpack/toxins,
			prob(3);/obj/item/storage/backpack/dufflebag,
			prob(3);/obj/item/storage/backpack/dufflebag/med,
			prob(3);/obj/item/storage/backpack/dufflebag/eng,
			prob(1);/obj/item/storage/backpack/dufflebag/syndie,
			prob(1);/obj/item/storage/backpack/dufflebag/syndie/med,
			prob(1);/obj/item/storage/backpack/dufflebag/syndie/ammo,
			prob(4);/obj/item/storage/backpack/satchel,
			prob(5);/obj/item/storage/backpack/satchel/norm,
			prob(5);/obj/item/storage/backpack/satchel/med,
			prob(5);/obj/item/storage/backpack/satchel/eng,
			prob(5);/obj/item/storage/backpack/satchel/tox,
			prob(5);/obj/item/storage/backpack/messenger/med,
			prob(5);/obj/item/storage/backpack/messenger/engi,
			prob(5);/obj/item/storage/backpack/messenger/tox,
			prob(3);/obj/item/storage/wallet,
			prob(1);/obj/item/clothing/gloves/black,
			prob(1);/obj/item/clothing/gloves/blue,
			prob(1);/obj/item/clothing/gloves/brown,
			prob(1);/obj/item/clothing/gloves/duty,
			prob(1);/obj/item/clothing/gloves/fingerless,
			prob(1);/obj/item/clothing/gloves/green,
			prob(1);/obj/item/clothing/gloves/grey,
			prob(1);/obj/item/clothing/gloves/orange,
			prob(1);/obj/item/clothing/gloves/yellow,
			prob(3);/obj/item/clothing/gloves/botanic_leather,
			prob(2);/obj/item/clothing/gloves/sterile/latex,
			prob(5);/obj/item/clothing/gloves/white,
			prob(5);/obj/item/clothing/gloves/rainbow,
			prob(2);/obj/item/clothing/gloves/fyellow,
			prob(1);/obj/item/clothing/glasses/rimless,
			prob(1);/obj/item/clothing/glasses/thin,
			prob(1);/obj/item/clothing/glasses/regular,
			prob(1);/obj/item/clothing/glasses/regular/rimless,
			prob(1);/obj/item/clothing/glasses/regular/thin,
			prob(1);/obj/item/clothing/glasses/fakesunglasses,
			prob(1);/obj/item/clothing/glasses/fakesunglasses/aviator,
			prob(1);/obj/item/clothing/glasses/omnihud,
			prob(4);/obj/item/clothing/head/hardhat,
			prob(3);/obj/item/clothing/head/hardhat/red,
			prob(2);/obj/item/clothing/head/hardhat/dblue,
			prob(2);/obj/item/clothing/head/hardhat/orange,
			prob(4);/obj/item/clothing/head/soft/,
			prob(4);/obj/item/clothing/head/soft/black,
			prob(4);/obj/item/clothing/head/soft/blue,
			prob(4);/obj/item/clothing/head/soft/green,
			prob(4);/obj/item/clothing/head/soft/grey,
			prob(4);/obj/item/clothing/head/soft/med,
			prob(4);/obj/item/clothing/head/soft/nanotrasen,
			prob(4);/obj/item/clothing/head/soft/red,
			prob(4);/obj/item/clothing/head/soft/orange,
			prob(4);/obj/item/clothing/head/soft/sec,
			prob(4);/obj/item/clothing/head/soft/sec/corp,
			prob(3);/obj/item/clothing/head/soft/yellow,
			prob(1);/obj/item/clothing/head/ushanka,
			prob(3);/obj/item/clothing/head/beret,
			prob(3);/obj/item/clothing/head/beret/engineering,
			prob(1);/obj/item/clothing/head/beret/purple,
			prob(3);/obj/item/clothing/head/beret/sec,
			prob(3);/obj/item/clothing/head/beret/sec/corporate/officer,
			prob(3);/obj/item/clothing/head/beret/sec/navy/officer,
			prob(3);/obj/item/clothing/head/soft/yellow,
			prob(2);/obj/item/clothing/head/orangebandana,
			prob(3);/obj/item/clothing/suit/storage/toggle/bomber,
			prob(3);/obj/item/clothing/suit/storage/toggle/hoodie/black,
			prob(3);/obj/item/clothing/suit/storage/toggle/hoodie/blue,
			prob(3);/obj/item/clothing/suit/storage/toggle/hoodie/red,
			prob(3);/obj/item/clothing/suit/storage/toggle/hoodie/yellow,
			prob(3);/obj/item/clothing/suit/storage/toggle/brown_jacket,
			prob(3);/obj/item/clothing/suit/storage/toggle/leather_jacket,
			prob(4);/obj/item/clothing/suit/storage/toggle/labcoat,
			prob(4);/obj/item/clothing/suit/storage/toggle/labcoat/science,
			prob(4);/obj/item/clothing/suit/storage/miljacket,
			prob(4);/obj/item/clothing/suit/storage/miljacket/alt,
			prob(4);/obj/item/clothing/suit/storage/miljacket/black,
			prob(4);/obj/item/clothing/suit/storage/miljacket/green,
			prob(4);/obj/item/clothing/suit/storage/miljacket/grey,
			prob(4);/obj/item/clothing/suit/storage/miljacket/navy,
			prob(4);/obj/item/clothing/suit/storage/miljacket/tan,
			prob(4);/obj/item/clothing/suit/storage/miljacket/white,
			prob(4);/obj/item/clothing/suit/storage/trench,
			prob(3);/obj/item/clothing/suit/varsity,
			prob(3);/obj/item/clothing/suit/varsity/blue,
			prob(3);/obj/item/clothing/suit/varsity/brown,
			prob(3);/obj/item/clothing/suit/varsity/green,
			prob(3);/obj/item/clothing/suit/varsity/purple,
			prob(3);/obj/item/clothing/suit/varsity/red,
			prob(3);/obj/item/clothing/accessory/poncho,
			prob(3);/obj/item/clothing/accessory/poncho/blue,
			prob(3);/obj/item/clothing/accessory/poncho/green,
			prob(3);/obj/item/clothing/accessory/poncho/purple,
			prob(3);/obj/item/clothing/accessory/poncho/red,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cargo,
			prob(3);/obj/item/clothing/accessory/poncho/roles/engineering,
			prob(3);/obj/item/clothing/accessory/poncho/roles/medical,
			prob(3);/obj/item/clothing/accessory/poncho/roles/science,
			prob(3);/obj/item/clothing/accessory/poncho/roles/security,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/atmos,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/cargo,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/engineer,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/medical,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/mining,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/research,
			prob(3);/obj/item/clothing/accessory/poncho/roles/cloak/security,
			prob(2);/obj/item/clothing/accessory/stethoscope,
			prob(2);/obj/item/camera,
			prob(3);/obj/item/pda,
			prob(3);/obj/item/radio/headset,
			prob(2);/obj/item/toy/tennis,
			prob(2);/obj/item/toy/tennis/red,
			prob(2);/obj/item/toy/tennis/yellow,
			prob(2);/obj/item/toy/tennis/green,
			prob(2);/obj/item/toy/tennis/cyan,
			prob(2);/obj/item/toy/tennis/blue,
			prob(2);/obj/item/toy/tennis/purple,
			prob(2);/obj/item/clothing/ears/earmuffs,
			prob(2);/obj/item/clothing/ears/earmuffs/headphones,
			prob(2);/obj/item/toy/baseball
			)
