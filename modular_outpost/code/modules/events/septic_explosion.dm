/datum/event/septic_explosion
	announceWhen = 20

/datum/event/septic_explosion/announce()
	GLOB.command_announcement.Announce("A sudden rise in the septic system's pressure has been detected. A potential hazardous gas explosion may have occurred in maintenance. Ensure the station's systems are not damaged.", "Structural Alert", new_sound = ANNOUNCER_MSG_SEPTIC_EXPLOSION)

/datum/event/septic_explosion/start()
	var/obj/effect/landmark/teleplumb_exit/exit = locate(/obj/effect/landmark/teleplumb_exit)
	if(!exit)
		return
	if(severity == EVENT_LEVEL_MAJOR)
		explosion(get_turf(exit),10,12,16,20)
	// toilet-splosion
	for(var/obj/structure/toilet/T in world)
		if(!(T.z in using_map.station_levels))
			continue
		var/datum/component/disposal_system_connection/connection = T.GetComponent(/datum/component/disposal_system_connection)
		if(!connection)
			continue
		var/datum/gas_mixture/gas = new(800)
		gas.adjust_gas(GAS_CH4, 10, TRUE)
		T.open = TRUE
		T.cistern = TRUE
		T.update_icon()
		T.toilet_reflux(T, list(), gas)
