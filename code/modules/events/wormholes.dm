/datum/event/wormholes
	startWhen	= 0
	endWhen		= 220 // Outpost 21 edit - much longer to end message

/datum/event/wormholes/start()
	wormhole_event()

/datum/event/wormholes/end()
	command_announcement.Announce("There are no more space-time anomalies detected on the [using_map.facility_type].", "Anomaly Alert")
