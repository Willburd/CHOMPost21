/datum/event/redspacefissure
	startWhen	= 0
	endWhen		= 120

/datum/event/redspacefissure/start()
	wormhole_event(redspace = TRUE)

/datum/event/redspacefissure/end()
	command_announcement.Announce("\The [location_name()] has cleared the ion storm.", "Anomaly Alert")
