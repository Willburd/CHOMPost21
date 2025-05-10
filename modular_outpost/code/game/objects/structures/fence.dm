
/obj/structure/fence
	var/electric = FALSE

/obj/structure/fence/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/electric_sign
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE
	icon_state = "straight_sign"

/obj/structure/fence/door/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/end/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/corner/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/post/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/cut/medium/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/cut/large/electric
	name = "electric fence"
	desc = "A chain link fence. This one is attached to a nearby power controller. Zap zap!"
	icon = 'modular_outpost/icons/obj/fence_electric.dmi'
	electric = TRUE

/obj/structure/fence/proc/electrocute(mob/living/M)
	if(electrocute_mob(M, get_area(src), src, 0.7))
		visible_message("\The [src] zaps [M]!")
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		return TRUE
	return FALSE

/obj/structure/fence/Bumped(AM)
	. = ..()
	if(electric && isliving(AM))
		var/mob/living/L = AM
		if(!L.is_incorporeal())
			electrocute(L)

/obj/structure/fence/attack_hand(mob/user)
	if(electric && isliving(user) && !user.is_incorporeal())
		if(electrocute(user))
			return
	. = ..()

/obj/structure/fence/attackby(obj/item/W, mob/user)
	if(electric && isliving(user) && !user.is_incorporeal() && !(W.flags & NOCONDUCT))
		if(electrocute(user))
			return
	. = ..()
