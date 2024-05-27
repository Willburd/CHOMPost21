/var/global/sent_jils_to_station = 0

/datum/event/jil_infestation
	announceWhen	= 90
	var/spawncount = 1


/datum/event/jil_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 60)
	spawncount = rand(4 * severity, 6 * severity)
	sent_jils_to_station = 1

/datum/event/jil_infestation/announce()
	command_announcement.Announce("A Jil hoard has been detected in [station_name()]'s vent system. Ensure station property is not stolen.", "Jil Alert", new_sound = 'sound/AI/aliens.ogg')

/datum/event/jil_infestation/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in machines)
		if(!temp_vent.welded && temp_vent.network && (temp_vent.loc.z in using_map.station_levels))
			if(temp_vent.network.normal_members.len > 20)
				for(var/mob/living/L in range(12,temp_vent))
					if((ishuman(L) || issilicon(L)) && L.stat != DEAD)
						continue // skip... Too close to player
				var/area/A = get_area(temp_vent)
				if(!(A.forbid_events))
					vents += temp_vent

	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)

		// jils
		var/subcount = pick(0,1,2,3,4,5)
		while((subcount >= 1))
			var/mob/living/simple_mob/vore/alienanimals/jil/J = new /mob/living/simple_mob/vore/alienanimals/jil()
			J.loc = vent.loc
			subcount--

		// jillioths
		subcount = pick(0,0,1,2)
		while((subcount >= 1))
			var/mob/living/simple_mob/vore/alienanimals/jil/jillioth/Jl = new /mob/living/simple_mob/vore/alienanimals/jil/jillioth()
			Jl.loc = vent.loc
			subcount--

		vents -= vent
		spawncount--
