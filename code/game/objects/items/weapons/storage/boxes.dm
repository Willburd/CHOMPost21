/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon = 'icons/obj/boxes.dmi'
	icon_state = "box"
	item_state = "syringe_kit"
	center_of_mass_x = 13
	center_of_mass_y = 10
	var/foldable = /obj/item/stack/material/cardboard	// BubbleWrap - if set, can be folded (when empty) into a sheet of cardboard
	var/trash = null  // if set, can be crushed into a trash item when empty
	max_w_class = ITEMSIZE_SMALL
	max_storage_space = INVENTORY_BOX_SPACE
	use_sound = 'sound/items/storage/box.ogg'
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

// BubbleWrap - A box can be folded up to make card
/obj/item/storage/box/attack_self(mob/user as mob)
	if(..()) return

	//try to fold it
	if(ispath(foldable))
		if (contents.len)
			return
		var/found = 0
		// Close any open UI windows first
		for(var/mob/M in range(1))
			if (M.s_active == src)
				close(M)
			if (M == user)
				found = 1
		if (!found)	// User is too far away
			return
		// Now make the cardboard
		to_chat(user, span_notice("You fold [src] flat."))
		playsound(src, 'sound/items/storage/boxfold.ogg', 30, 1)
		new foldable(get_turf(src))
		qdel(src)

	//try to crush it
	if(ispath(trash))
		if(contents.len &&  user.a_intent == I_HURT)  // only crumple with things inside on harmintent.
			user.visible_message(span_danger("[user] crushes \the [src], spilling its contents everywhere!"), span_danger("You crush \the [src], spilling its contents everywhere!"))
			spill()
		else
			to_chat(user, span_notice("You crumple up \the [src].")) //make trash
		playsound(src.loc, 'sound/items/drop/wrapper.ogg', 30, 1)
		var/obj/item/trash = new src.trash()
		qdel(src)
		user.put_in_hands(trash)


/obj/item/storage/box/survival
	name = "emergency supply box"
	desc = "A survival box issued to crew members for use in emergency situations."
	icon_state = "survival"
	starts_with = list(
		/obj/item/tool/prybar/red,
		/obj/item/clothing/glasses/goggles,
		/obj/item/clothing/mask/breath
	)

/obj/item/storage/box/survival/synth
	name = "synthetic supply box"
	desc = "A survival box issued to synthetic crew members for use in emergency situations."
	icon_state = "survival_synth"
	starts_with = list(
		/obj/item/tool/prybar/red,
		/obj/item/clothing/glasses/goggles
	)

/obj/item/storage/box/survival/comp
	name = "emergency supply box"
	desc = "A comprehensive survival box issued to crew members for use in emergency situations. Contains additional supplies."
	icon_state = "survival_comp"
	starts_with = list(
		/obj/item/tool/prybar/red,
		/obj/item/clothing/glasses/goggles,
		/obj/item/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/flashlight/glowstick,
		/obj/item/reagent_containers/food/snacks/candy/proteinbar,
		/obj/item/clothing/mask/breath
	)

/obj/item/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains white gloves."
	icon_state = "latex"
	starts_with = list(/obj/item/clothing/gloves/sterile/latex = 7)

/obj/item/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"
	starts_with = list(/obj/item/clothing/mask/surgical = 7)

/obj/item/storage/box/masks/white
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"
	starts_with = list(/obj/item/clothing/mask/surgical/white = 7)

/obj/item/storage/box/masks/dust
	name = "box of dust masks"
	desc = "This box contains dust masks. Breathe easy."
	icon_state = "sterile"
	starts_with = list(/obj/item/clothing/mask/surgical/dust = 7)

/obj/item/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	icon_state = "syringe"
	starts_with = list(/obj/item/reagent_containers/syringe = 7)

/obj/item/storage/box/old_syringes
	name = "box of syringes"
	desc = "A box full of syringes. They look old."
	icon_state = "syringe"
	starts_with = list(/obj/item/reagent_containers/syringe/old = 2) // Old syringes guaranteed in each box!

/obj/item/storage/box/old_syringes/Initialize(mapload)
	var/syringe
	for(var/i in 1 to 8)
		if(prob(25))
			continue
		syringe = pick(subtypesof(/obj/item/reagent_containers/syringe))
		new syringe(src)
	. = ..()

/obj/item/storage/box/syringegun
	name = "box of syringe gun cartridges"
	desc = "A box full of compressed gas cartridges."
	icon_state = "syringe2"
	starts_with = list(/obj/item/syringe_cartridge = 7)

/obj/item/storage/box/beakers
	name = "box of beakers"
	desc = "A box full of beakers."
	icon_state = "beaker"
	starts_with = list(/obj/item/reagent_containers/glass/beaker = 7)

/obj/item/storage/box/injectors
	name = "box of DNA injectors"
	desc = "This box contains injectors it seems."
	icon_state = "dna"
	// Traitgenes New injector loot
	starts_with = list(
		/obj/item/dnainjector/random_good_labeled = 2,
		/obj/item/dnainjector/random_neutral_labeled = 2,
		/obj/item/dnainjector/random_labeled = 2
	)

/obj/item/storage/box/flashbangs
	name = "box of flashbangs (WARNING)"
	desc = span_bold("WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use.")
	icon_state = "flashbang"
	starts_with = list(/obj/item/grenade/flashbang = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/emps
	name = "box of emp grenades"
	desc = "A box containing 5 military grade EMP grenades.<br> WARNING: Do not use near unshielded electronics or biomechanical augmentations, death or permanent paralysis may occur."
	icon_state = "emp"
	starts_with = list(/obj/item/grenade/empgrenade = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/empslite
	name = "box of low yield emp grenades"
	desc = "A box containing 5 low yield EMP grenades.<br> WARNING: Do not use near unshielded electronics or biomechanical augmentations, death or permanent paralysis may occur."
	icon_state = "emp"
	starts_with = list(/obj/item/grenade/empgrenade/low_yield = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/smokes
	name = "box of smoke bombs"
	desc = "A box containing 7 smoke bombs."
	icon_state = "flashbang"
	starts_with = list(/obj/item/grenade/smokebomb = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/anti_photons
	name = "box of anti-photon grenades"
	desc = "A box containing 7 experimental photon disruption grenades."
	icon_state = "flashbang"
	starts_with = list(/obj/item/grenade/anti_photon = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/frags
	name = "box of fragmentation grenades (WARNING)"
	desc = "A box containing 7 military grade fragmentation grenades.<br> WARNING: These devices are extremely dangerous and can cause limb loss or death in repeated use."
	icon_state = "frag"
	starts_with = list(/obj/item/grenade/explosive = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/frags_half_box
	name = "box of fragmentation grenades (WARNING)"
	desc = "A box containing 4 military grade fragmentation grenades.<br> WARNING: These devices are extremely dangerous and can cause limb loss or death in repeated use."
	icon_state = "frag"
	starts_with = list(/obj/item/grenade/explosive = 4)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/storage/box/metalfoam
	name = "box of metal foam grenades."
	desc = "A box containing 7 metal foam grenades."
	icon_state = "flashbang"
	starts_with = list(/obj/item/grenade/chem_grenade/metalfoam = 7)

/obj/item/storage/box/teargas
	name = "box of teargas grenades"
	desc = "A box containing 7 teargas grenades."
	icon_state = "flashbang"
	starts_with = list(/obj/item/grenade/chem_grenade/teargas = 7)

/obj/item/storage/box/flare
	name = "box of flares"
	desc = "A box containing 14 flares."
	starts_with = list(/obj/item/flashlight/flare = 14)

/obj/item/storage/box/trackimp
	name = "boxed tracking implant kit"
	desc = "Box full of scum-bag tracking utensils."
	icon_state = "implant"
	starts_with = list(
		/obj/item/implantcase/tracking = 4,
		/obj/item/implanter,
		/obj/item/implantpad,
		/obj/item/locator
	)

/obj/item/storage/box/chemimp
	name = "boxed chemical implant kit"
	desc = "Box of stuff used to implant chemicals."
	icon_state = "implant"
	starts_with = list(
		/obj/item/implantcase/chem = 5,
		/obj/item/implanter,
		/obj/item/implantpad
	)

/obj/item/storage/box/camerabug
	name = "mobile camera pod box"
	desc = "A box containing some mobile camera pods."
	icon_state = "pda"
	starts_with = list(
		/obj/item/camerabug = 6,
		/obj/item/bug_monitor
	)

/obj/item/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"
	starts_with = list(/obj/item/clothing/glasses/regular = 7)

/obj/item/storage/box/cdeathalarm_kit
	name = "death alarm kit"
	desc = "Box of stuff used to implant death alarms."
	icon_state = "implant"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(
		/obj/item/implantcase/death_alarm = 7,
		/obj/item/implanter
	)

/obj/item/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."
	icon_state = "condiment"
	starts_with = list(/obj/item/reagent_containers/food/condiment = 7)

/obj/item/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	icon_state = "cups"
	starts_with = list(/obj/item/reagent_containers/food/drinks/sillycup = 7)

/obj/item/storage/box/buns
	name = "box of bread buns"
	desc = "Freshly baked at some point in the past few months."
	icon_state = "bun_box"
	max_storage_space = ITEMSIZE_COST_NORMAL * 5
	starts_with = list(/obj/item/reagent_containers/food/snacks/bun = 12)

/obj/item/storage/box/monkeycubes
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	can_hold = list(/obj/item/reagent_containers/food/snacks/monkeycube)
	starts_with = list(/obj/item/reagent_containers/food/snacks/monkeycube/wrapped = 4)

// Outpost 21 edit begin - Soaking monkey cubes
/obj/item/storage/box/monkeycubes/proc/soaked()
	for(var/A in contents)
		var/obj/item/reagent_containers/food/snacks/monkeycube/C = A
		if(istype(A,/obj/item/reagent_containers/food/snacks/monkeycube/wrapped))
			C.soaked()
		else if(istype(A,/obj/item/reagent_containers/food/snacks/monkeycube))
			C.Expand()

/obj/item/storage/box/monkeycubes/Moved(atom/old_loc, direction, forced, movetime)
	. = ..()
	if(istype(loc,/turf/simulated/floor/water))
		soaked()
// Outpost 21 edit end

/obj/item/storage/box/monkeycubes/farwacubes
	name = "farwa cube box"
	desc = "Drymate brand farwa cubes, shipped from Meralar. Just add water!"
	starts_with = list(/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/farwacube = 4)

/obj/item/storage/box/monkeycubes/stokcubes
	name = "stok cube box"
	desc = "Drymate brand stok cubes, shipped from Moghes. Just add water!"
	starts_with = list(/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/stokcube = 4)

/obj/item/storage/box/monkeycubes/neaeracubes
	name = "neaera cube box"
	desc = "Drymate brand neaera cubes, shipped from Qerr'balak. Just add water!"
	starts_with = list(/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube = 4)

/obj/item/storage/box/ids
	name = "box of spare IDs"
	desc = "Has so many empty IDs."
	icon_state = "id"
	starts_with = list(/obj/item/card/id = 7)

/obj/item/storage/box/seccarts
	name = "box of spare R.O.B.U.S.T. Cartridges"
	desc = "A box full of R.O.B.U.S.T. Cartridges, used by Security."
	icon_state = "pda"
	starts_with = list(/obj/item/cartridge/security = 7)

/obj/item/storage/box/handcuffs
	name = "box of spare handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"
	starts_with = list(/obj/item/handcuffs = 7)

/obj/item/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = span_red(span_bold("WARNING:")) + " " + span_italics("Keep out of reach of children") + "."
	icon_state = "mousetraps"
	starts_with = list(/obj/item/assembly/mousetrap = 7)

/obj/item/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."
	icon_state = "pillbox"
	starts_with = list(/obj/item/storage/pill_bottle = 7)

/obj/item/storage/box/snappops
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"
	can_hold = list(/obj/item/toy/snappop)
	starts_with = list(/obj/item/toy/snappop = 8)

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_BELT
	can_hold = list(/obj/item/flame/match)
	starts_with = list(/obj/item/flame/match = 10)
	drop_sound = 'sound/items/drop/matchbox.ogg'
	pickup_sound =  'sound/items/pickup/matchbox.ogg'

/obj/item/storage/box/matches/attackby(var/obj/item/flame/match/W, var/mob/user)
	if(istype(W) && !W.lit && !W.burnt)
		if(prob(25))
			W.light(user)
			user.visible_message(span_notice("[user] manages to light the match on the matchbox."))
		else
			playsound(src, 'sound/items/cigs_lighters/matchstick_hit.ogg', 25, 0, -1)
	W.update_icon()
	return

/obj/item/storage/box/autoinjectors
	name = "box of injectors"
	desc = "Contains autoinjectors."
	icon_state = "auto"
	starts_with = list(/obj/item/reagent_containers/hypospray/autoinjector = 7)

/obj/item/storage/box/lights
	name = "box of replacement bulbs"
	icon = 'icons/obj/boxes.dmi'
	icon_state = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	storage_slots = 24
	can_hold = list(/obj/item/light/tube, /obj/item/light/bulb)
	max_storage_space = ITEMSIZE_COST_SMALL * 24 //holds 24 items of w_class 2
	use_to_pickup = TRUE // for picking up broken bulbs, not that most people will try

/obj/item/storage/box/lights/bulbs
	starts_with = list(/obj/item/light/bulb = 24)

/obj/item/storage/box/lights/tubes
	name = "box of replacement tubes"
	icon_state = "lighttube"
	starts_with = list(/obj/item/light/tube = 24)

/obj/item/storage/box/lights/mixed
	name = "box of replacement lights"
	icon_state = "lightmixed"
	starts_with = list(
		/obj/item/light/tube = 16,
		/obj/item/light/bulb = 8
	)

/obj/item/storage/box/freezer
	name = "portable freezer"
	desc = "This nifty shock-resistant device will keep your 'groceries' nice and non-spoiled."
	icon = 'icons/obj/storage.dmi'
	icon_state = "portafreezer"
	item_state_slots = list(slot_r_hand_str = "medicalpack", slot_l_hand_str = "medicalpack")
	foldable = null
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(/obj/item/organ)
	max_storage_space = ITEMSIZE_COST_NORMAL * 5 // Formally 21.  Odd numbers are bad.
	use_to_pickup = TRUE // for picking up broken bulbs, not that most people will try

/obj/item/storage/box/freezer/red
	icon_state = "portafreezer_red"

/obj/item/storage/box/freezer/Entered(var/atom/movable/AM)
	if(istype(AM, /obj/item/organ))
		var/obj/item/organ/O = AM
		O.preserved = 1
		for(var/obj/item/organ/organ in O)
			organ.preserved = 1
	..()

/obj/item/storage/box/freezer/Exited(var/atom/movable/AM)
	if(istype(AM, /obj/item/organ))
		var/obj/item/organ/O = AM
		O.preserved = 0
		for(var/obj/item/organ/organ in O)
			organ.preserved = 0
	..()

/obj/item/storage/box/ambrosia
	name = "ambrosia seeds box"
	desc = "Contains the seeds you need to get a little high."
	starts_with = list(/obj/item/seeds/ambrosiavulgarisseed = 7)

/obj/item/storage/box/ambrosiadeus
	name = "ambrosia deus seeds box"
	desc = "Contains the seeds you need to get a proper healthy high."
	starts_with = list(/obj/item/seeds/ambrosiadeusseed = 7)

/obj/item/storage/box/capguntoy
	name = "\improper AlliCo \"Zipper\" Cap Gun"
	icon = 'icons/obj/gun_toy.dmi'
	icon_state = "cap_gun_box"
	desc = "This box is shaped on the inside so that only the \"Zipper\" Capgun and extra caps can fit."
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	storage_slots = 2
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(/obj/item/gun/projectile/revolver/capgun, /obj/item/ammo_magazine/ammo_box/cap)
	starts_with = list(
		/obj/item/gun/projectile/revolver/capgun = 1,
		/obj/item/ammo_magazine/ammo_box/cap = 1
	)

//Donk-pockets
/obj/item/storage/box/donkpockets
	name = "box of donk-pockets"
	desc = span_bold("Instructions:") + " " + span_italics("Heat in microwave. Product will cool if not eaten within seven minutes.")
	icon_state = "donkpocketbox"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket = 7)

/obj/item/storage/box/donkpockets/spicy
	name = "box of spicy-flavoured donk-pockets"
	icon_state = "donkpocketboxspicy"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/spicy = 7)

/obj/item/storage/box/donkpockets/teriyaki
	name = "box of teriyaki-flavoured donk-pockets"
	icon_state = "donkpocketboxteriyaki"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/teriyaki = 7)

/obj/item/storage/box/donkpockets/pizza
	name = "box of pizza-flavoured donk-pockets"
	icon_state = "donkpocketboxpizza"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/pizza = 7)

/obj/item/storage/box/donkpockets/honk
	name = "box of banana-flavoured donk-pockets"
	icon_state = "donkpocketboxbanana"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/honk = 7)

/obj/item/storage/box/donkpockets/gondola
	name = "box of gondola-flavoured donk-pockets"
	icon_state = "donkpocketboxgondola"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/gondola = 7)

/obj/item/storage/box/donkpockets/berry
	name = "box of berry-flavoured donk-pockets"
	icon_state = "donkpocketboxberry"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/berry = 7)

/obj/item/storage/box/sinpockets
	name = "box of sin-pockets"
	desc = span_bold("Instructions:") + " " + span_italics("Crush bottom of package to initiate chemical heating. Wait for 20 seconds before consumption. Product will cool if not eaten within seven minutes.")
	icon_state = "donk_kit"
	starts_with = list(/obj/item/reagent_containers/food/snacks/donkpocket/sinpocket = 7)
