/datum/spawnpoint/elevator
	display_name = "Elevator"
	msg = "has arrived from the residential district"

/datum/spawnpoint/elevator/New()
	..()
	turfs = latejoin_elevator

/datum/spawnpoint/cyborg
	display_name = "Cyborg Storage"
	msg = "has been activated from storage" // Outpost 21 edit - wording
	allowed_mob_types = JOB_SILICON // Outpost 21 edit - restrictions fixed

/datum/spawnpoint/cyborg/New()
	..()
	turfs = latejoin_cyborg

/datum/spawnpoint/cryo
	display_name = "Cryogenic Storage"
	msg = "has completed cryogenic revival"
	allowed_mob_types = JOB_CARBON
	// disallow_job = list(JOB_OUTSIDER) // Outpost 21 edit - Job removal

/datum/spawnpoint/cryo/New()
	..()
	turfs = latejoin_cryo


/datum/spawnpoint/vore
	display_name = "Vorespawn - Prey"
	msg = "has arrived on the station"
	allow_offmap_spawn = TRUE

/datum/spawnpoint/vore/pred
	display_name = "Vorespawn - Pred"
	msg = "has arrived on the station"

/datum/spawnpoint/vore/itemtf
	display_name = "Item TF spawn"
	msg = "has arrived on the station"

/datum/spawnpoint/vore/New()
	..()
	turfs = latejoin
