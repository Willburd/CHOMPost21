/obj/item/latexballon/whoopee
	name = "whoopee cushion"
	icon = 'modular_outpost/icons/obj/items.dmi'
	desc = "A joke as old as time."
	icon_state = "whoopee"
	item_icons = list(
			slot_l_hand_str = 'modular_outpost/icons/mob/items/lefthand_gloves.dmi',
			slot_r_hand_str = 'modular_outpost/icons/mob/items/righthand_gloves.dmi',
			)
	item_state = "whoopee"
	layer = HIDING_LAYER

/obj/item/latexballon/whoopee/blow(obj/item/tank/tank)
	if(icon_state == "whoopee_bursted")
		return
	if(!tank.air_contents || tank.air_contents.return_pressure() <= 0)
		return
	src.air_contents = tank.remove_air_volume(3)
	icon_state = "whoopee_blow"
	item_state = "whoopee"

/obj/item/latexballon/whoopee/proc/poot()
	playsound(src, 'modular_outpost/sound/effects/poot.ogg', 100, 1)
	loc.assume_air(air_contents)
	air_contents = null
	icon_state = "whoopee"
	item_state = "whoopee"

/obj/item/latexballon/whoopee/burst()
	if (!air_contents)
		return
	poot()
	// break it
	icon_state = "whoopee_bursted"

/obj/item/latexballon/whoopee/Crossed(atom/movable/AM as mob|obj)
	// poot
	if (!air_contents)
		return
	if(istype(loc,/turf/))
		poot()


/obj/item/latexballon/whoopee/attackby(obj/item/W as obj, mob/user as mob)
	if(can_puncture(W))
		burst()

/obj/item/latexballon/whoopee/attack_self(mob/user as mob)
	src.add_fingerprint(user)
	if(icon_state == "whoopee_bursted")
		return
	if(air_contents)
		poot()
		return
	if(do_after(user, 2 SECONDS, src))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(istype(H.internal,/obj/item/tank))
				blow(H.internal)
				return
		if(isturf(user.loc))
			var/turf/T = user.loc
			var/datum/gas_mixture/my_air = T.return_air()
			if(my_air.return_pressure() > 0)
				// inflate by environment
				src.air_contents = T.remove_air(3)
				icon_state = "whoopee_blow"
				item_state = "whoopee"
				return
