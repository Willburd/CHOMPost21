
//Original Casino Code created by Shadowfire117#1269 - Ported from CHOMPstation
//Modified by GhostActual#2055 for use with VOREstation

// Use this define to register a prize!
// * n - The proper name of the purchasable
// * o - The object type path of the purchasable to spawn
// * r - The amount to dispense
// * p - The price of the purchasable in chips
// * l - The restriction of the item
#define CASINO_PRIZE(n, o, r, p, l) n = new /datum/data/casino_prize(n, o, r, p, l)

/datum/data/casino_prize
	var/equipment_path = null
	var/equipment_amt = 1
	var/cost = 0
	var/category = null
	var/restriction = null

/datum/data/casino_prize/New(name, path, amt, cost, restriction)
	src.name = name
	src.equipment_path = path
	src.equipment_amt = amt
	src.cost = cost
	src.category = category
	src.restriction = restriction

/obj/machinery/casino_prize_dispenser
	name = "Casino Prize Exchanger"
	desc = "Exchange your chips to obtain wonderful prizes! Hoepfully you'll get to keep some of them for a while."
	icon = 'icons/obj/casino_ch.dmi' //CHOMPEdit
	icon_state ="casino_prize_dispenser"
	var/icon_vend ="casino_prize_dispenser-vend"
	anchored = 1
	density = 1
	opacity = 0
	var/list/item_list

	clicksound = "button"
	var/vending_sound = "machines/vending/vending_drop.ogg"

	// Power
	use_power = USE_POWER_IDLE
	idle_power_usage = 10
	var/vend_power_usage = 150 //actuators and stuff

	// Vending-related
	var/datum/data/casino_prize/currently_vending = null // What we're requesting payment for right now
	var/list/log = list() //Log only SS13 staff is allowed to look at, CKEYS are listed here for record keeping of prizes and players for events!

	//CHOMPEdit Start
	var/category_weapons	 = 1	//For listing categories, if false then prizes of this categories cant be obtained nor bought for post-shift enjoyment
	var/category_gear		 = 1	//If 1 prizes will be only logged
	var/category_clothing	 = 1	//If 2 prizes will both be logged and spawned
	var/category_misc		 = 1
	var/category_drinks		 = 1
	var/category_pets		 = 1
	var/category_mechs		 = 1
	//CHOMPEdit End
	var/category_implants	 = 1
	var/category_event		 = 1	//For special events, holidays, etc

/obj/machinery/casino_prize_dispenser/Initialize(mapload)
	. = ..()
	power_change()

	item_list = list()
	//CHOMPEdit Start
	item_list["Weapons"] = list(
		CASINO_PRIZE("Scepter", /obj/item/scepter, 1, 500, "weapons"),
		CASINO_PRIZE("Chain of Command", /obj/item/melee/chainofcommand, 1, 250, "weapons"),
		CASINO_PRIZE("Size Gun", /obj/item/gun/energy/sizegun, 1, 100, "weapons"),
		CASINO_PRIZE("Advanced Particle Rifle", /obj/item/gun/energy/particle/advanced, 1, 500, "weapons"),
		CASINO_PRIZE("Temperature Gun", /obj/item/gun/energy/temperature, 1, 250, "weapons"),
		CASINO_PRIZE("Alien Pistol", /obj/item/gun/energy/alien, 1, 1000, "weapons"),
		CASINO_PRIZE("Floral Gun", /obj/item/gun/energy/floragun, 1, 250, "weapons"),
		CASINO_PRIZE("Net Gun", /obj/item/gun/energy/netgun, 1, 500, "weapons"),
	)
	item_list["Gear"] = list(
		CASINO_PRIZE("Experimental Welder", /obj/item/weldingtool/experimental, 1, 500, "gear"),
		CASINO_PRIZE("Alien Belt", /obj/item/storage/belt/utility/alien, 1, 500, "gear"),
		CASINO_PRIZE("Alien Armor", /obj/item/clothing/suit/armor/alien, 1, 1000, "gear"),
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
		CASINO_PRIZE("Casino wallet (kept after event)", /obj/item/storage/wallet/casino, 1, 50, "misc"),
		CASINO_PRIZE("Casino cards", /obj/item/deck/cards/casino, 1, 50, "misc"),
		CASINO_PRIZE("Casino Sentient Prize Collar", /obj/item/clothing/accessory/collar/holo/casinoslave_fake, 1, 50, "misc"),
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
		CASINO_PRIZE("Whiskey bliss", /obj/item/reagent_containers/food/drinks/bottle/specialwhiskey, 1, 50, "drinks"),
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
		CASINO_PRIZE("Yithian", /obj/item/grenade/spawnergrenade/casino/yithian, 1, 200, "pets"),
		CASINO_PRIZE("Tindalos", /obj/item/grenade/spawnergrenade/casino/tindalos, 1, 200, "pets"),
		CASINO_PRIZE("Fennec", /obj/item/grenade/spawnergrenade/casino/fennec, 1, 300, "pets"),
		CASINO_PRIZE("Red panda", /obj/item/grenade/spawnergrenade/casino/redpanda, 1, 300, "pets"),
		CASINO_PRIZE("Horse", /obj/item/grenade/spawnergrenade/casino/horse, 1, 300, "pets"),
		CASINO_PRIZE("Otie", /obj/item/grenade/spawnergrenade/casino/otie, 1, 500, "pets"),
		CASINO_PRIZE("Absolute unit of an Otie", /obj/item/grenade/spawnergrenade/casino/otie/chubby, 1, 500, "pets"),
		CASINO_PRIZE("Zorgoia", /obj/item/grenade/spawnergrenade/casino/zorgoia, 1, 500, "pets"),
	)
	item_list["Mechs and Rigs"] = list(
		CASINO_PRIZE("Mech:Mining Ripley", /obj/item/grenade/spawnergrenade/casino/gygax/mining, 1, 1000, "mechs"),
		CASINO_PRIZE("Mech:Firefighter Ripley", /obj/item/grenade/spawnergrenade/casino/gygax/firefighter, 1, 750, "mechs"),
		CASINO_PRIZE("Mech:Serenity", /obj/item/grenade/spawnergrenade/casino/gygax/serenity, 1, 1500, "mechs"),
		CASINO_PRIZE("Mech:Odysseus", /obj/item/grenade/spawnergrenade/casino/gygax/Odysseus, 1, 1250, "mechs"),
		CASINO_PRIZE("Mech:Phazon Scuttlebug", /obj/item/grenade/spawnergrenade/casino/gygax/scree, 1, 2000, "mechs"),
		CASINO_PRIZE("Mech:Phazon Janus", /obj/item/grenade/spawnergrenade/casino/gygax/janus, 1, 2500, "mechs"),
		CASINO_PRIZE("Mech:Scarab", /obj/item/grenade/spawnergrenade/casino/gygax/scarab, 1, 500, "mechs"),
		CASINO_PRIZE("Mech:Shuttlepod", /obj/item/grenade/spawnergrenade/casino/gygax/shuttlepod, 1, 250, "mechs"),
		CASINO_PRIZE("Mech:Shuttlecraft", /obj/item/grenade/spawnergrenade/casino/gygax/shuttlecraft, 1, 500, "mechs"),
		CASINO_PRIZE("Rig: Solgov engineering hardsuit control module", /obj/item/rig/bayeng, 1, 500, "mechs"),
		CASINO_PRIZE("Rig: Solgov medical hardsuit control module", /obj/item/rig/baymed, 1, 500, "mechs"),
		CASINO_PRIZE("Rig: Advanced hardsuit control module", /obj/item/rig/ce, 1, 500, "mechs"),//CHOMPEDIT: Hardsuit
		CASINO_PRIZE("Rig: Pursuit hardsuit control module", /obj/item/rig/ch/pursuit, 1, 750, "mechs"),
		CASINO_PRIZE("Rig: Combat hardsuit control module", /obj/item/rig/combat, 1, 750, "mechs"),
		CASINO_PRIZE("Rig: ERT-J suit control module (Elite Janitor NT approved)", /obj/item/rig/ert/janitor, 1, 250, "mechs"),
		CASINO_PRIZE("Rig: Augmented tie (Elite Paper-Pusher NT approved)", /obj/item/rig/internalaffairs, 1, 250, "mechs"),
		CASINO_PRIZE("Rig: Industrial suit control module", /obj/item/rig/industrial, 1, 300, "mechs"),
		CASINO_PRIZE("Rig: Rescue suit control module", /obj/item/rig/medical, 1, 300, "mechs"),
	)
	item_list["Implants and Genemods"] = list(
		CASINO_PRIZE("Implanter (Remember to get one unless you want to borrow from station!)", /obj/item/implanter, 1, 100, "implants"),
		CASINO_PRIZE("Implant: Tazer", /obj/item/implantcase/taser, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Medkit", /obj/item/implantcase/medkit, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Shades", /obj/item/implantcase/shades, 1, 750, "implants"),
		CASINO_PRIZE("Implant: Sprinter", /obj/item/implantcase/sprinter, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Toolkit", /obj/item/implantcase/toolkit, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Language", /obj/item/implantcase/vrlanguage, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Analyzer", /obj/item/implantcase/analyzer, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Size control", /obj/item/implant/sizecontrol , 1, 500, "implants"),
		CASINO_PRIZE("Implant: Adrenaline", /obj/item/implantcase/adrenalin, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Armblade", /obj/item/implantcase/armblade, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Wrist dartgun", /obj/item/implantcase/dart, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Freedom", /obj/item/implantcase/freedom, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Handblade", /obj/item/implantcase/handblade, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Hand laser", /obj/item/implantcase/laser, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Loyalty", /obj/item/implantcase/loyalty, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Restraining bolt", /obj/item/implantcase/restrainingbolt, 1, 1000, "implants"),
		CASINO_PRIZE("Implant: Surge", /obj/item/implantcase/surge, 1, 500, "implants"),
		CASINO_PRIZE("Implant: Wrist sword", /obj/item/implantcase/sword, 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: No breath", /obj/item/dnainjector/set_trait/nobreathe, 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Regenerate", /obj/item/dnainjector/set_trait/regenerate, 1, 1000, "implants"),
		// CASINO_PRIZE("Genemod: Remote view", /obj/item/dnainjector/set_trait/remoteview, 1, 1000, "implants"), Outpost 21 edit - Disabled due to balance issues
		CASINO_PRIZE("Genemod: Sprinter", /obj/item/dnainjector/set_trait/haste, 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: Telekinesis", /obj/item/dnainjector/set_trait/tk, 1, 1000, "implants"),
		CASINO_PRIZE("Genemod: X-ray", /obj/item/dnainjector/set_trait/xray, 1, 1000, "implants"),
	)

	item_list["Event"] = list(
	)
	//CHOMPEdit End

/obj/machinery/casino_prize_dispenser/power_change()
	..()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
	else
		if(!(stat & NOPOWER))
			icon_state = initial(icon_state)
		else
			spawn(rand(0, 15))
				icon_state = "[initial(icon_state)]-off"

/obj/machinery/casino_prize_dispenser/attack_hand(mob/user as mob)
	if(stat & (BROKEN|NOPOWER))
		return
	tgui_interact(user)

/obj/machinery/casino_prize_dispenser/attackby(obj/item/W as obj, mob/user as mob)
	if(currently_vending)
		if(istype(W, /obj/item/spacecasinocash))
			to_chat(user, span_warning("Please select prize on display with sufficient amount of chips."))
		else
			SStgui.update_uis(src)
			return // don't smack that machine with your 2 chips

	if(istype(W, /obj/item/spacecasinocash))
		attack_hand(user)
		return
	..()

/obj/machinery/casino_prize_dispenser/proc/pay_with_chips(var/obj/item/spacecasinocash/cashmoney, mob/user, var/price)
	//"cashmoney_:[cashmoney] user:[user] currently_vending:[currently_vending]"
	if(price > cashmoney.worth)
		to_chat(user, "[icon2html(cashmoney, user.client)] " + span_warning("That is not enough chips."))
		return 0

	if(istype(cashmoney, /obj/item/spacecasinocash))
		visible_message(span_info("\The [user] inserts some chips into \the [src]."))
		cashmoney.worth -= price

		if(cashmoney.worth <= 0)
			user.drop_from_inventory(cashmoney)
			qdel(cashmoney)
		else
			cashmoney.update_icon()
	return 1

/obj/machinery/casino_prize_dispenser/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/vending),
	)

/obj/machinery/casino_prize_dispenser/tgui_data(mob/user)
	var/list/data[0]

	data["items"] = list()
	for(var/cat in item_list)
		var/list/cat_items = list()
		for(var/prize_name in item_list[cat])
			var/datum/data/casino_prize/prize = item_list[cat][prize_name]
			cat_items[prize_name] = list("name" = prize_name, "price" = prize.cost, "restriction" = prize.restriction)
		data["items"][cat] = cat_items
	return data

/obj/machinery/casino_prize_dispenser/tgui_interact(mob/user, datum/tgui/ui = null)
	// Open the window
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CasinoPrizeDispenser", name)
		ui.open()

/obj/machinery/casino_prize_dispenser/tgui_act(action, params, datum/tgui/ui)
	if(stat & (BROKEN|NOPOWER))
		return
	if(ui.user.stat || ui.user.restrained())
		return
	if(..())
		return TRUE
	. = TRUE
	switch(action)
		if("purchase")
			var/paid = FALSE
			var/category = params["cat"]
			var/restriction_category = params["restriction"]
			var/restriction_check = 0
			var/item_given = FALSE
			var/name = params["name"]
			var/price = params["price"]
			var/datum/data/casino_prize/bi = item_list[category][name]
			switch(restriction_category)
				if("weapons")
					restriction_check = category_weapons
				if("gear")
					restriction_check = category_gear
				if("clothing")
					restriction_check = category_clothing
				if("misc")
					restriction_check = category_misc
				if("drinks")
					restriction_check = category_drinks
				//CHOMPAdd Start
				if("pets")
					restriction_check = category_pets
				if("mechs")
					restriction_check = category_mechs
				//CHOMPAdd End
				if("implants")
					restriction_check = category_implants
				if("event")
					restriction_check = category_event
				else
					to_chat(ui.user, span_warning("Prize checkout error has occurred, purchase cancelled."))
					return FALSE

			if(restriction_check < 1)
				to_chat(ui.user, span_warning("[name] is restricted, this prize can't be bought."))
				return FALSE
			if(restriction_check > 1)
				item_given = TRUE

			if(price <= 0 && item_given == TRUE)
				vend(bi, ui.user)
				return TRUE

			currently_vending = bi

			if(istype(ui.user.get_active_hand(), /obj/item/spacecasinocash))
				var/obj/item/spacecasinocash/cash = ui.user.get_active_hand()
				paid = pay_with_chips(cash, ui.user, price)
			else
				to_chat(ui.user, span_warning("Payment failure: Improper payment method, please provide chips."))
				return TRUE // we set this because they shouldn't even be able to get this far, and we want the UI to update.
			if(paid)
				if(item_given == TRUE)
					vend(bi, ui.user)

				speak("Thank you for your purchase, your [bi] has been logged.")
				do_logging(currently_vending, ui.user, bi)
				. = TRUE
			else
				to_chat(ui.user, span_warning("Payment failure: unable to process payment."))

/obj/machinery/casino_prize_dispenser/proc/vend(datum/data/casino_prize/bi, mob/user)
	SStgui.update_uis(src)

	if(ispath(bi.equipment_path, /obj/item/stack))
		new bi.equipment_path(loc, bi.equipment_amt)
		playsound(src, 'sound/machines/vending/vending_drop.ogg', 100, 1)
		return TRUE

	for(var/i in 1 to bi.equipment_amt)
		new bi.equipment_path(loc)
		playsound(src, 'sound/machines/vending/vending_drop.ogg', 100, 1)

	currently_vending = null
	use_power(vend_power_usage)	//actuators and stuff
	flick("[icon_state]-vend",src)


/obj/machinery/casino_prize_dispenser/proc/do_logging(item, mob/user, datum/data/casino_prize/bi)
	var/prize_log = "{ckey:[user.ckey]character_name:[user.name]item_path: [bi.equipment_path]}"
	log[++log.len] = prize_log
	//Currently doesnt have an ingame way to show. Can only be viewed through View-Variables, to ensure theres no chance of players ckeys exposed - Jack

/obj/machinery/casino_prize_dispenser/proc/speak(var/message)
	if(stat & NOPOWER)
		return

	if(!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message(span_npc_say(span_name("\The [src]") + " beeps, \"[message]\""),2)
	return

/obj/machinery/casino_prize_dispenser/process() //Might not need this, but just to be safe for now
	if(stat & (BROKEN|NOPOWER))
		return

#undef CASINO_PRIZE
