
////////////// MDSE Invincible Submarine //////////////

// art by whooshboom
/obj/mecha/combat/fighter/submarine
	name = "MDSE Invincible"
	desc = "A submarine."
	icon = 'modular_outpost/icons/mecha/submarine64x64.dmi'
	icon_state = "sub_clean"
	initial_icon = "sub_clean"

	catalogue_data = list(/datum/category_item/catalogue/technology/submarine)
	wreckage = /obj/effect/decal/mecha_wreckage/submarine

	step_in = 5 // Water is slow
	ground_capable = FALSE // See get_gravity() for water restrictions

	stomp_sound = 'sound/mecha/fighter/engine_mid_fighter_move.ogg'
	stomp_sound_2 = 'sound/mecha/fighter/engine_mid_fighter_move.ogg'
	swivel_sound = 'sound/mecha/fighter/engine_mid_boost_01.ogg'

/obj/mecha/combat/fighter/submarine/get_gravity(turf/T)
	// Returns gravity being true for everything unless we are underwater
	if(istype(T,/turf/simulated/floor/water))
		var/turf/simulated/floor/water/W = T
		return W.depth < 2 // Must be minimum deep depth
	return TRUE

/obj/effect/decal/mecha_wreckage/submarine
	name = "MDSE Invincible wreckage"
	desc = "A submarine, it looks like it has seen better days."
	icon = 'modular_outpost/icons/mecha/submarine64x64.dmi'
	icon_state = "sub_dirty"
	bound_width = 64
	bound_height = 64

/obj/effect/decal/mecha_wreckage/submarine/old
	icon_state = "sub_dirty" // Uses the overgrown style of broken

/datum/category_item/catalogue/technology/submarine
	name = "Voidcraft - Submarine"
	desc = "TEMP."
	value = CATALOGUER_REWARD_EASY
