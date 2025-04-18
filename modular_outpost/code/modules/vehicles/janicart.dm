/datum/category_item/catalogue/technology/janicart
	name = "Cargo Train Tug"
	desc = "A standard issue cargo tug, meant for hauling obscene amounts of crates when the mail system won't suffice. Note: only licensed cargo crew are authorized to drive this vehicle."
	value = CATALOGUER_REWARD_TRIVIAL

/obj/vehicle/train/engine/janicart
	name = "janicart"
	icon = 'modular_outpost/icons/obj/vehicles.dmi'
	icon_state = "pussywagon"
	on = 0
	powered = 1
	locked = 0

	load_item_visible = 1
	load_offset_x = 0
	mob_offset_y = 7
	flags = OPENCONTAINER

	var/scrubbing = FALSE //Floor cleaning enabled
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/storage/bag/trash/mybag	= null
	var/callme = "pimpin' ride"	//how do people refer to it?

	key_type = /obj/item/key/janicart

	catalogue_data = list(/datum/category_item/catalogue/technology/janicart)

/obj/item/key/janicart
	name = "key"
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = ITEMSIZE_TINY

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/train/engine/janicart/Initialize(mapload)
	. = ..()
	// apply speed
	move_delay = 0.5
	cell = new /obj/item/cell/high(src)
	key = new key_type(src)
	turn_off()	//so engine verbs are correctly set
	create_reagents(600)

	var/image/I = new(icon = 'modular_outpost/icons/obj/vehicles.dmi', icon_state = "pussywagon_overlay", layer = src.layer + 0.2) //over mobs
	add_overlay(I)

/obj/vehicle/train/engine/janicart/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/mop))
		if(reagents.total_volume > 1)
			reagents.trans_to_obj(W, 2)
			to_chat(user, "<span class='notice'>You wet [W] in the [callme].</span>")
			playsound(src, 'sound/effects/slosh.ogg', 25, 1)
		else
			to_chat(user, "<span class='notice'>This [callme] is out of water!</span>")
	else if(istype(W, /obj/item/storage/bag/trash))
		to_chat(user, "<span class='notice'>You hook the trashbag onto the [callme].</span>")
		user.drop_item()
		W.loc = src
		mybag = W
	..()

/obj/vehicle/train/engine/janicart/attack_hand(mob/user)
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null
	else
		..()

/obj/vehicle/train/engine/janicart/insert_cell(var/obj/item/cell/C, var/mob/living/carbon/human/H)
	..()
	update_stats()

/obj/vehicle/train/engine/janicart/remove_cell(var/mob/living/carbon/human/H)
	..()
	update_stats()

/obj/vehicle/train/engine/janicart/Bump(atom/Obstacle)
	var/obj/machinery/door/D = Obstacle
	var/mob/living/carbon/human/H = load
	if(istype(D) && istype(H))
		D.Bumped(H)		//a little hacky, but hey, it works, and respects access rights

	..()

//-------------------------------------------
// Interaction procs
//-------------------------------------------
/obj/vehicle/train/engine/janicart/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		. += "The power light is [on ? "on" : "off"].\nThere are[key ? "" : " no"] keys in the ignition."
		. += "The charge meter reads [cell? round(cell.percent(), 0.01) : 0]%"
		. += "This [callme] contains [reagents.total_volume] unit\s of water!"
		if(mybag)
			. += "\A [mybag] is hanging on the [callme]."

/obj/vehicle/train/engine/janicart/verb/toggle_brush()
	set name = "Toggle brushes"
	set category = "Object.Vehicle"
	set src in view(0)

	if(!ishuman(usr))
		return

	scrubbing = !scrubbing
	if (scrubbing)
		to_chat(usr, "You turn \the [callme]'s brushes on.")
	else
		to_chat(usr, "You turn \the [callme]'s brushes off.")

/obj/vehicle/train/engine/janicart/latch(obj/vehicle/train/T, mob/user)
	// nothing latchs to this!
	return 0

// VOREStation Edit Start - Overlay stuff for the chair-like effect
/obj/vehicle/train/engine/janicart/update_icon()
	..()
	cut_overlays()
	if(!open)
		var/image/O = image(icon = 'modular_outpost/icons/obj/vehicles.dmi', icon_state = "pussywagon_overlay", dir = src.dir)
		O.layer = FLY_LAYER
		O.plane = MOB_PLANE
		add_overlay(O)

/obj/vehicle/train/engine/janicart/set_dir()
	..()
	update_icon()
// VOREStation Edit End - Overlay stuff for the chair-like effect

/obj/vehicle/train/engine/janicart/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	if(scrubbing)
		if(reagents.has_reagent(REAGENT_ID_WATER, 1) || reagents.has_reagent(REAGENT_ID_CLEANER, 1))
			var/turf/tile = loc
			tile.clean_blood()
			if(istype(tile, /turf/simulated))
				var/turf/simulated/T = tile
				T.dirt = 0
			for(var/A in tile)
				if(istype(A,/obj/effect/rune) || istype(A,/obj/effect/decal/cleanable) || istype(A,/obj/effect/overlay))
					qdel(A)
				else if(ishuman(A))
					var/mob/living/carbon/human/cleaned_human = A
					if(cleaned_human.lying)
						if(cleaned_human.head)
							cleaned_human.head.clean_blood()
							cleaned_human.update_inv_head(0)
						if(cleaned_human.wear_suit)
							cleaned_human.wear_suit.clean_blood()
							cleaned_human.update_inv_wear_suit(0)
						else if(cleaned_human.w_uniform)
							cleaned_human.w_uniform.clean_blood()
							cleaned_human.update_inv_w_uniform(0)
						if(cleaned_human.shoes)
							cleaned_human.shoes.clean_blood()
							cleaned_human.update_inv_shoes(0)
						cleaned_human.clean_blood(1)
						to_chat(cleaned_human, "<span class='warning'>\The [callme] cleans your face!</span>")
			reagents.trans_to_turf(tile, 1, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.
		else
			scrubbing = FALSE
			if(ishuman(load))
				var/mob/living/carbon/human/D = load
				to_chat(D, "\The [callme]'s brushes turn off, as it runs out of cleaner.")
