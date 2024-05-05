/datum/event/disposal_damage/announce()
	if(severity < EVENT_LEVEL_MAJOR)
		return
	command_announcement.Announce("A sudden drop in the disposal network's pressure has been detected. Verify all disposal units are functioning correctly.", "Structural Alert")

/datum/event/disposal_damage/start()
	if(!machines.len)
		return

	var/obj/machinery/disposal/D
	var/list/disposals = list()
	var/remaining_attempts = 50
	while(remaining_attempts-- > 0)
		D = acquire_random_disposal()
		if(D)
			disposals.Add(D)
	if(!disposals.len)
		return

	// count to break
	var/severity_range = 0
	switch(severity)
		if(EVENT_LEVEL_MUNDANE)
			severity_range = 4
		if(EVENT_LEVEL_MODERATE)
			severity_range = 11
		if(EVENT_LEVEL_MAJOR)
			severity_range = 30

	// break amount of disposals based on severity
	while(disposals.len && severity_range-- > 0)
		D = pick(disposals)
		disposals.Remove(D)

		// break em!
		D.malfunction()

/datum/event/disposal_damage/proc/acquire_random_disposal()
	var/obj/machinery/disposal/D = pick(machines)
	if(istype(D,/obj/machinery/disposal/) && !(D.stat & BROKEN) && D.mode != 3)
		return D
	return null
