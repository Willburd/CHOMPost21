var/global/list/fixed_teleporters = list()

/obj/structure/fixed_teleporter
	name = "narrow-band teleporter"
	desc = "The short-range teleporter. It is targeted at a specific location."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "tele0"
	var/base_icon_state = "tele0"
	var/used_icon_state = "tele1"
	var/cooldown = 0
	// Teleports to another fixed_teleporter"
	var/my_tag = "MyTag"
	var/destination_tag = "SendToTag" // checks for the above tag and links to it. Does not auto-link back, technically allows for chaining multiple teleports together.
	var/obj/structure/fixed_teleporter/cached_destination

/obj/structure/fixed_teleporter/Initialize(mapload)
	. = ..()
	global.fixed_teleporters += src
	// Link the teleporters AFTER we've got them all
	if(destination_tag == null || my_tag == null)
		return .
	spawn(50)
		for(var/obj/structure/fixed_teleporter/TP in global.fixed_teleporters)
			if(TP.my_tag == null)
				continue
			if(TP.my_tag == destination_tag)
				cached_destination = TP
				break

/obj/structure/fixed_teleporter/Destroy()
	global.fixed_teleporters -= src
	. = ..()

/obj/structure/fixed_teleporter/attack_hand(mob/user)
	if(!isobserver(user) && !Adjacent(user))
		return
	if(cooldown > world.time)
		return
	if(cached_destination)
		if(!isobserver(user))
			// vanish!
			visible_message("\The [user] vanishes into the swirling portal.")
			var/turf/T = get_turf(cached_destination)
			// Our side
			var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
			sparks.set_up(3, 0, src)
			sparks.attach(loc)
			sparks.start()
			qdel(sparks)
			flick(used_icon_state,src)
			// Other end
			sparks = new /datum/effect/effect/system/spark_spread()
			sparks.set_up(3, 0, T)
			sparks.attach(T)
			sparks.start()
			qdel(sparks)
			flick(used_icon_state,cached_destination)
			// and time to make them appear!
			cached_destination.visible_message("The teleporter activates, and \The [user] appears in a flash of blue light.")
		cooldown = world.time + 1 SECOND // lets avoid abuse
		user.forceMove(cached_destination.loc)
		return
	. = ..()

/obj/structure/fixed_teleporter/attack_robot(mob/living/user)
	if(isAI(user))
		return
	attack_hand(user)

/obj/structure/fixed_teleporter/attack_generic(mob/user, damage, attack_verb)
	attack_hand(user)

/obj/structure/fixed_teleporter/attack_ghost(mob/user, damage, attack_verb)
	attack_hand(user)
