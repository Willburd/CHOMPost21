/var/global/sent_chus_to_station = 0

/datum/event/chu_infestation
	announceWhen	= 90
	var/spawncount = 1


/datum/event/chu_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + rand(60,100))
	spawncount = rand(2 * severity, 5 * severity)
	sent_chus_to_station = 1

/datum/event/chu_infestation/announce()
	command_announcement.Announce("Massive migration of unknown biological entities has been detected near [location_name()], please stand-by.", "Lifesign Alert")

/datum/event/chu_infestation/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in machines)
		if(!temp_vent.welded && temp_vent.network && (temp_vent.loc.z in using_map.event_levels))
			if(temp_vent.network.normal_members.len > 20)
				for(var/mob/living/L in range(12,temp_vent))
					if((ishuman(L) || issilicon(L)) && L.stat != DEAD)
						continue // skip... Too close to player
				var/area/A = get_area(temp_vent)
				if(!(A.forbid_events))
					vents += temp_vent

	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)
		var/mob/living/simple_mob/vore/alienanimals/chu/C = new /mob/living/simple_mob/vore/alienanimals/chu()
		C.loc = vent.loc
		spawncount--
