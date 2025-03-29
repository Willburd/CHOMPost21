/datum/event/disposal_damage/announce()
	if(severity < EVENT_LEVEL_MAJOR)
		return
	command_announcement.Announce("A sudden drop in the disposal network's pressure has been detected. Verify all disposal units are functioning correctly.", "Structural Alert")

/datum/event/disposal_damage/start()
	if(!machines.len)
		return

	var/list/disposals = list()
	for(var/obj/machinery/M in machines)
		if(istype(M,/obj/machinery/disposal))
			var/obj/machinery/disposal/D = M
			var/turf/T = get_turf(D)
			if(!T || !(T.z in using_map.station_levels)) // Not centcom!
				continue
			if(!(D.stat & BROKEN) && D.mode != 3 && D.anchored)
				disposals.Add(M)
	if(!disposals.len)
		return

	// count to break
	var/severity_range = 0
	switch(severity)
		if(EVENT_LEVEL_MUNDANE)
			severity_range = 4
		if(EVENT_LEVEL_MODERATE)
			severity_range = 12
		if(EVENT_LEVEL_MAJOR)
			severity_range = 20

	// break amount of disposals based on severity
	while(disposals.len && severity_range-- > 0)
		var/obj/machinery/disposal/D = pick(disposals)
		if(D)
			// break em!
			D.malfunction()
			disposals.Remove(D)
