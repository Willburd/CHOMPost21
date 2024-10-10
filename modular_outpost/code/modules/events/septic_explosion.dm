/datum/event/septic_explosion
	announceWhen = 20

/datum/event/septic_explosion/announce()
	command_announcement.Announce("A sudden rise in the septic system's pressure has been detected. A potential hazardous gas explosion may have occurred in maintenance. Ensure the station's systems are not damaged.", "Structural Alert")

/datum/event/septic_explosion/start()
	var/obj/effect/landmark/teleplumb_exit/exit = locate(/obj/effect/landmark/teleplumb_exit)
	if(!exit)
		return
	explosion(get_turf(exit),10,12,16,20)
