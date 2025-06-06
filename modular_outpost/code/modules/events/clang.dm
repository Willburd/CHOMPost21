/datum/event/clang
	announceWhen 	= 1
	startWhen		= 10
	endWhen			= 35

/datum/event/clang/announce()
	command_announcement.Announce("Attention [station_name()]. Unknown ultra-dense high-velocity object entering stratosphere!", "General Alert")
	if(seclevel2num(get_security_level()) < SEC_LEVEL_BLUE)
		set_security_level(SEC_LEVEL_BLUE) // OHNO

/datum/event/clang/end()
	command_announcement.Announce("What the fuck was that?!", "General Alert")

/datum/event/clang/start()
	affecting_z = global.using_map.event_levels

	var/startz = pick(affecting_z)
	var/startx = 0
	var/starty = 0
	var/endy = 0
	var/endx = 0
	var/startside = pick(GLOB.cardinal)
	if(prob(50))
		startside = pick(list(EAST,WEST)) // Outpost 21 edit - our station is wide

	// Random pos along an edge with a percent buffer to prevent corner spawns
	var/wid = world.maxx * 0.05
	var/hig = world.maxy * 0.05
	var/map_l = wid
	var/map_r = world.maxx - wid
	var/map_b = hig
	var/map_t = world.maxy - hig

	var/deviance = 2
	switch(startside)
		if(NORTH)
			starty = world.maxy - 2
			startx = rand(map_l, map_r)
			endy = 1
			endx = startx + rand(-deviance,deviance)
		if(EAST)
			starty = rand(map_b, map_t)
			startx = world.maxx - 2
			endy = starty + rand(-deviance,deviance)
			endx = 1
		if(SOUTH)
			starty = 2
			startx = rand(map_l, map_r)
			endy = world.maxy - 2
			endx = startx + rand(-deviance,deviance)
		if(WEST)
			starty = rand(map_b, map_t)
			startx = 2
			endy = starty + rand(-deviance,deviance)
			endx = world.maxx - 2

	//rod time!
	var/turf/start = locate(startx, starty, startz)
	var/obj/effect/immovablerod/immrod = new /obj/effect/immovablerod(start)
	immrod.TakeFlight(locate(endx, endy, startz))

/obj/effect/immovablerod
	name = "Immovable Rod"
	desc = "What the fuck is that?"
	icon = 'icons/obj/objects.dmi'
	icon_state = "immrod"
	throwforce = 100
	density = TRUE
	anchored = TRUE
	movement_type = UNSTOPPABLE
	var/turf/despawn_loc = null

/obj/effect/immovablerod/proc/TakeFlight(var/turf/end)
	//to_world("Rod in play, starting at [loc.x],[loc.y],[loc.z] and going to [end.loc.x],[end.loc.y],[end.loc.z]")
	despawn_loc = end
	walk_towards(src, despawn_loc, 1)
	explosion(loc, 2, 3, 5) // start out with a bang

	// Get steps needed and then await that to despawn
	var/despawn_time = sqrt(((end.x - loc.x)**2) + ((end.y - loc.y)**2)) // distance of a line...
	spawn(despawn_time)
		//to_world("ROD DESPAWN")
		qdel(src)

/obj/effect/immovablerod/Bump(atom/clong)
	//to_world("Rod CLANG [clong] : [clong.x].[clong.y].[clong.z]")

	if(!istype(clong, /turf/simulated/shuttle)) //Skip shuttles without actually deleting the rod
		if (istype(clong, /turf) && !istype(clong, /turf/unsimulated))
			if(clong.density)
				clong.ex_act(2)
				for (var/mob/O in hearers(src, null))
					O.show_message("CLANG", 2)
				if(prob(25))
					//to_world("Rod BOOM")
					explosion(clong, 1, 2, 4) // really spice it up

		else if (istype(clong, /obj))
			if(clong.density)
				clong.ex_act(2)
				for (var/mob/O in hearers(src, null))
					O.show_message("CLANG", 2)

		else if (istype(clong, /mob))
			if(clong.density || prob(10))
				clong.ex_act(2)

		else
			qdel(src)

	if(despawn_loc != null && (src.x == despawn_loc.x && src.y == despawn_loc.y))
		//to_world("ENDED ROD PATH")
		qdel(src)

/obj/effect/immovablerod/Destroy()
	walk(src, 0) // Because we might have called walk_towards, we must stop the walk loop or BYOND keeps an internal reference to us forever.
	return ..()
