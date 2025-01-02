
#define CASINO_PRIZE(n, o, r, p, l) n = new /datum/data/casino_prize(n, o, r, p, l)

/obj/machinery/casino_prize_dispenser/outpost/Initialize()
	. = ..()

	item_list = list()
	//CHOMPEdit Start
	item_list["Weapons"] = list(
		CASINO_PRIZE("Scepter", /obj/item/scepter, 1, 500, "weapons"),
		CASINO_PRIZE("Temperature Gun", /obj/item/gun/energy/temperature, 1, 250, "weapons"),
		CASINO_PRIZE("Floral Gun", /obj/item/gun/energy/floragun, 1, 250, "weapons"),
		CASINO_PRIZE("Net Gun", /obj/item/gun/energy/netgun, 1, 500, "weapons"),
	)
	item_list["Gear"] = list(
		CASINO_PRIZE("Experimental Welder", /obj/item/weldingtool/experimental, 1, 500, "gear"),
		CASINO_PRIZE("Monocoole", /obj/item/clothing/glasses/monocoole, 1, 1000, "gear"),
		CASINO_PRIZE("Chameleon Tie", /obj/item/clothing/accessory/chameleon, 1, 250, "gear"),
		CASINO_PRIZE("Chemsprayer", /obj/item/reagent_containers/spray/chemsprayer, 1, 250, "gear"),
		CASINO_PRIZE("Bluespace Beaker", /obj/item/reagent_containers/glass/beaker/bluespace, 1, 200, "gear"),
		CASINO_PRIZE("Cryo Beaker", /obj/item/reagent_containers/glass/beaker/noreact, 1, 200, "gear"),
	)
	item_list["Clothing"] = list(
		CASINO_PRIZE("Purple cap", /obj/item/clothing/head/soft/purple/wah, 1, 50, "clothing"),
		CASINO_PRIZE("Shark mask", /obj/item/clothing/mask/shark, 1, 50, "clothing"),
		CASINO_PRIZE("Pig mask", /obj/item/clothing/mask/pig, 1, 50, "clothing"),
		CASINO_PRIZE("Luchador mask", /obj/item/clothing/mask/luchador, 1, 50, "clothing"),
		CASINO_PRIZE("Horse mask", /obj/item/clothing/mask/horsehead, 1, 50, "clothing"),
		CASINO_PRIZE("Goblin mask", /obj/item/clothing/mask/goblin, 1, 50, "clothing"),
		CASINO_PRIZE("Fake moustache", /obj/item/clothing/mask/fakemoustache, 1, 50, "clothing"),
		CASINO_PRIZE("Dolphin mask", /obj/item/clothing/mask/dolphin, 1, 50, "clothing"),
		CASINO_PRIZE("Demon mask", /obj/item/clothing/mask/demon, 1, 50, "clothing"),
		CASINO_PRIZE("Chameleon mask", /obj/item/clothing/under/chameleon, 1, 250, "clothing"),
		CASINO_PRIZE("Ian costume", /obj/item/clothing/suit/storage/hooded/costume/ian, 1, 50, "clothing"),
		CASINO_PRIZE("Carp costume", /obj/item/clothing/suit/storage/hooded/costume/carp, 1, 50, "clothing"),
		CASINO_PRIZE("White bunnygirl outfit", /obj/item/storage/box/casino/costume_whitebunny, 1, 100, "clothing"),
		CASINO_PRIZE("Black bunnygirl outfit", /obj/item/storage/box/casino/costume_blackbunny, 1, 100, "clothing"),
		CASINO_PRIZE("Sexy mime costume", /obj/item/storage/box/casino/costume_sexymime, 1, 100, "clothing"),
		CASINO_PRIZE("Sexy clown costume", /obj/item/storage/box/casino/costume_sexyclown, 1, 100, "clothing"),
		CASINO_PRIZE("Catgirl costume", /obj/item/storage/box/casino/costume_nyangirl, 1, 100, "clothing"),
		CASINO_PRIZE("Wizard costume", /obj/item/storage/box/casino/costume_wizard, 1, 100, "clothing"),
		CASINO_PRIZE("Chicken costume", /obj/item/storage/box/casino/costume_chicken, 1, 100, "clothing"),
		CASINO_PRIZE("Gladiator costume", /obj/item/storage/box/casino/costume_gladiator, 1, 100, "clothing"),
		CASINO_PRIZE("Pirate costume", /obj/item/storage/box/casino/costume_pirate, 1, 100, "clothing"),
		CASINO_PRIZE("Commie costume", /obj/item/storage/box/casino/costume_commie, 1, 100, "clothing"),
		CASINO_PRIZE("Imperium monk costume", /obj/item/storage/box/casino/costume_imperiummonk, 1, 100, "clothing"),
		CASINO_PRIZE("Plague doctor costume", /obj/item/storage/box/casino/costume_plaguedoctor, 1, 100, "clothing"),
		CASINO_PRIZE("Witch costume", /obj/item/storage/box/casino/costume_cutewitch, 1, 100, "clothing"),
	)
	item_list["Miscellaneous"] = list(
		CASINO_PRIZE("Toy sword", /obj/item/toy/sword, 1, 50, "misc"),
		CASINO_PRIZE("Waterflower", /obj/item/reagent_containers/spray/waterflower, 1, 50, "misc"),
		CASINO_PRIZE("Horse stick", /obj/item/toy/stickhorse, 1, 50, "misc"),
		CASINO_PRIZE("katana", /obj/item/toy/katana, 1, 50, "misc"),
		CASINO_PRIZE("Conch", /obj/item/toy/eight_ball/conch, 1, 50, "misc"),
		CASINO_PRIZE("Eight ball", /obj/item/toy/eight_ball, 1, 50, "misc"),
		CASINO_PRIZE("Foam sword", /obj/item/material/sword/foam, 1, 50, "misc"),
		CASINO_PRIZE("Foam crossbow", /obj/item/storage/box/casino/foamcrossbow, 1, 50, "misc"),
		CASINO_PRIZE("Whistle", /obj/item/toy/bosunwhistle, 1, 50, "misc"),
		CASINO_PRIZE("Golden cup", /obj/item/reagent_containers/food/drinks/golden_cup, 1, 50, "misc"),
		CASINO_PRIZE("Quality cigars", /obj/item/storage/fancy/cigar/havana, 1, 50, "misc"),
		CASINO_PRIZE("Casino cards", /obj/item/deck/cards/casino, 1, 50, "misc"),
		CASINO_PRIZE("Instrument: Accordion", /obj/item/instrument/accordion, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Banjo", /obj/item/instrument/banjo, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Musical bikehorn", /obj/item/instrument/bikehorn, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Electric guitar", /obj/item/instrument/eguitar, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Glockenspiel", /obj/item/instrument/glockenspiel, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Guitar", /obj/item/instrument/guitar, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Harmonica", /obj/item/instrument/harmonica, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Keytar", /obj/item/instrument/keytar, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Synthethic Piano", /obj/item/instrument/piano_synth, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Recorder", /obj/item/instrument/recorder, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Saxophone", /obj/item/instrument/saxophone, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Trombone", /obj/item/instrument/trombone, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Trumpet", /obj/item/instrument/trumpet, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Violin", /obj/item/instrument/violin, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Xylophone", /obj/item/instrument/xylophone, 1, 100, "misc"),
		CASINO_PRIZE("Instrument: Golden fiddle", /obj/item/instrument/violin/golden, 1, 250, "misc"),
		CASINO_PRIZE("Instrument: Trumpet (warning: spooky)", /obj/item/instrument/trumpet/spectral, 1, 200, "misc"),
		CASINO_PRIZE("Instrument: Trombone (warning: spooky)", /obj/item/instrument/trombone/spectral, 1, 200, "misc"),
		CASINO_PRIZE("Instrument: Saxophone (warning: spooky)", /obj/item/instrument/saxophone/spectral, 1, 200, "misc"),
		CASINO_PRIZE("Instrument: Musical Moth (you monster)", /obj/item/instrument/musicalmoth, 1, 100, "misc"),
	)
	item_list["Drinks"] = list(
		CASINO_PRIZE("Redeemer's brew", /obj/item/reagent_containers/food/drinks/bottle/redeemersbrew, 1, 50, "drinks"),
		CASINO_PRIZE("Poison wine", /obj/item/reagent_containers/food/drinks/bottle/pwine, 1, 50, "drinks"),
		CASINO_PRIZE(REAGENT_PATRON, /obj/item/reagent_containers/food/drinks/bottle/patron, 1, 50, "drinks"),
		CASINO_PRIZE("Holy water", /obj/item/reagent_containers/food/drinks/bottle/holywater, 1, 50, "drinks"),
		CASINO_PRIZE(REAGENT_GOLDSCHLAGER, /obj/item/reagent_containers/food/drinks/bottle/goldschlager, 1, 50, "drinks"),
		CASINO_PRIZE(REAGENT_CHAMPAGNE, /obj/item/reagent_containers/food/drinks/bottle/champagne, 1, 50, "drinks"),
		CASINO_PRIZE("Bottle of Nothing", /obj/item/reagent_containers/food/drinks/bottle/bottleofnothing, 1, 50, "drinks"),
		CASINO_PRIZE("Snaps", /obj/item/reagent_containers/food/drinks/bottle/snaps, 1, 50, "drinks"),
	)
	item_list["Pets"] = list(
		CASINO_PRIZE("Casino Geese", /obj/item/grenade/spawnergrenade/casino, 1, 200, "pets"),
		CASINO_PRIZE("Goat", /obj/item/grenade/spawnergrenade/casino/goat, 1, 150, "pets"),
		CASINO_PRIZE("Armadillo", /obj/item/grenade/spawnergrenade/casino/armadillo, 1, 150, "pets"),
		CASINO_PRIZE("Cat", /obj/item/grenade/spawnergrenade/casino/cat, 1, 150, "pets"),
		CASINO_PRIZE("Chicken", /obj/item/grenade/spawnergrenade/casino/chicken, 1, 200, "pets"),
		CASINO_PRIZE("Cow", /obj/item/grenade/spawnergrenade/casino/cow, 1, 200, "pets"),
		CASINO_PRIZE("Corgi", /obj/item/grenade/spawnergrenade/casino/corgi, 1, 200, "pets"),
		CASINO_PRIZE("Fox", /obj/item/grenade/spawnergrenade/casino/fox, 1, 150, "pets"),
		CASINO_PRIZE("Lizard", /obj/item/grenade/spawnergrenade/casino/lizard, 1, 150, "pets"),
		CASINO_PRIZE("Penguin", /obj/item/grenade/spawnergrenade/casino/penguin, 1, 150, "pets"),
		CASINO_PRIZE("Snake", /obj/item/grenade/spawnergrenade/casino/snake, 1, 200, "pets"),
		CASINO_PRIZE("Fennec", /obj/item/grenade/spawnergrenade/casino/fennec, 1, 300, "pets"),
		CASINO_PRIZE("Red panda", /obj/item/grenade/spawnergrenade/casino/redpanda, 1, 300, "pets"),
		CASINO_PRIZE("Horse", /obj/item/grenade/spawnergrenade/casino/horse, 1, 300, "pets"),
		CASINO_PRIZE("Otie", /obj/item/grenade/spawnergrenade/casino/otie, 1, 500, "pets"),
		CASINO_PRIZE("Absolute unit of an Otie", /obj/item/grenade/spawnergrenade/casino/otie/chubby, 1, 500, "pets"),
	)
	item_list["Mechs and Rigs"] = list(
		CASINO_PRIZE("Mech:Mining Ripley", /obj/item/grenade/spawnergrenade/casino/gygax/mining, 1, 1000, "mechs"),
		CASINO_PRIZE("Mech:Firefighter Ripley", /obj/item/grenade/spawnergrenade/casino/gygax/firefighter, 1, 750, "mechs"),
		CASINO_PRIZE("Mech:Serenity", /obj/item/grenade/spawnergrenade/casino/gygax/serenity, 1, 1500, "mechs"),
		CASINO_PRIZE("Mech:Odysseus", /obj/item/grenade/spawnergrenade/casino/gygax/Odysseus, 1, 1250, "mechs"),
		CASINO_PRIZE("Rig: Solgov engineering hardsuit control module", /obj/item/rig/bayeng, 1, 500, "mechs"),
		CASINO_PRIZE("Rig: Solgov medical hardsuit control module", /obj/item/rig/baymed, 1, 500, "mechs"),
		CASINO_PRIZE("Rig: Advanced hardsuit control module", /obj/item/rig/ce, 1, 500, "mechs"),//CHOMPEDIT: Hardsuit
		CASINO_PRIZE("Rig: Pursuit hardsuit control module", /obj/item/rig/ch/pursuit, 1, 750, "mechs"),
		CASINO_PRIZE("Rig: Combat hardsuit control module", /obj/item/rig/combat, 1, 750, "mechs"),
		CASINO_PRIZE("Rig: ERT-J suit control module (Elite Janitor)", /obj/item/rig/ert/janitor, 1, 250, "mechs"),
		CASINO_PRIZE("Rig: Augmented tie (Elite Paper-Pusher)", /obj/item/rig/internalaffairs, 1, 250, "mechs"),
		CASINO_PRIZE("Rig: Industrial suit control module", /obj/item/rig/industrial, 1, 300, "mechs"),
		CASINO_PRIZE("Rig: Rescue suit control module", /obj/item/rig/medical, 1, 300, "mechs"),
	)
	item_list["Implants and Genemods"] = list(
		CASINO_PRIZE("Implanter (Remember to get one unless you want to borrow from station!)", /obj/item/implanter, 1, 100, "implants"),
		CASINO_PRIZE("Implant: Medkit", /obj/item/implantcase/medkit, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Shades", /obj/item/implantcase/shades, 1, 750, "implants"),
		CASINO_PRIZE("Implant: Sprinter", /obj/item/implantcase/sprinter, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Toolkit", /obj/item/implantcase/toolkit, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Language", /obj/item/implantcase/vrlanguage, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Analyzer", /obj/item/implantcase/analyzer, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Adrenaline", /obj/item/implantcase/adrenalin, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Freedom", /obj/item/implantcase/freedom, 1, 500, "implants"),
		// Traitgenes edit begin - New injector loot
		CASINO_PRIZE("Genemod: No breath", /obj/item/dnainjector/set_trait/nobreathe , 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Regenerate", /obj/item/dnainjector/set_trait/regenerate , 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Remote view", /obj/item/dnainjector/set_trait/remoteview , 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Sprinter", /obj/item/dnainjector/set_trait/haste , 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Telekinesis", /obj/item/dnainjector/set_trait/tk , 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: X-ray", /obj/item/dnainjector/set_trait/xray , 1, 1000, "implants"),
		// Traitgenes edit end
	)

	item_list["Event"] = list(
	)
	//CHOMPEdit End

#undef CASINO_PRIZE
