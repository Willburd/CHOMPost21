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
	var/list/destinations = list()

/obj/structure/fixed_teleporter/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/fixed_teleporter/LateInitialize()
	// Link the teleporters AFTER we've got them all
	for(var/obj/structure/fixed_teleporter/TP in world)
		if(TP.my_tag == destination_tag)
			destinations.Add(get_turf(TP))

/obj/structure/fixed_teleporter/attack_hand(mob/user)
	if(!isobserver(user) && !Adjacent(user))
		return
	if(cooldown > world.time)
		return
	if(!destinations.len)
		return
	// Get the destination turf
	var/turf/cached_destination = pick(destinations)
	if(!isobserver(user))
		// vanish!
		visible_message("\The [user] vanishes into the swirling portal.")
		// Our side
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 0, src)
		sparks.attach(loc)
		sparks.start()
		qdel(sparks)
		flick(used_icon_state,src)
		// Other end
		sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 0, cached_destination)
		sparks.attach(cached_destination)
		sparks.start()
		qdel(sparks)
	cooldown = world.time + 1 SECOND // lets avoid abuse
	user.forceMove(cached_destination)

/obj/structure/fixed_teleporter/attack_robot(mob/living/user)
	if(isAI(user))
		return
	attack_hand(user)

/obj/structure/fixed_teleporter/attack_generic(mob/user, damage, attack_verb)
	attack_hand(user)

/obj/structure/fixed_teleporter/attack_ghost(mob/user, damage, attack_verb)
	attack_hand(user)




/obj/structure/fixed_teleporter/bloodstar
	name = "arena teleporter"
	desc = "Transports you to the game arena."
	my_tag = "bloodstar"
	destination_tag = "bloodstar"

/obj/structure/fixed_teleporter/bloodstar/LateInitialize()
	for(var/obj/effect/landmark/bloodstar/B in world)
		destinations.Add(get_turf(B))

/obj/effect/landmark/bloodstar
	name = "bloodstar random start"
	delete_me = FALSE
