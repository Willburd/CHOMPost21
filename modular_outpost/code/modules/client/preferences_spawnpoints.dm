/datum/spawnpoint/elevator
	display_name = "Elevator"
	msg = "has arrived from the residential district"

/datum/spawnpoint/elevator/New()
	..()
	turfs = GLOB.latejoin_elevator

/datum/spawnpoint/cyborg
	display_name = "Cyborg Storage"
	msg = "has been activated from storage"
	allowed_mob_types = JOB_SILICON

/datum/spawnpoint/cyborg/New()
	..()
	turfs = GLOB.latejoin_cyborg

/datum/spawnpoint/cryo
	display_name = "Cryogenic Storage"
	msg = "has completed cryogenic revival"
	allowed_mob_types = JOB_CARBON

/datum/spawnpoint/cryo/New()
	..()
	turfs = GLOB.latejoin_cryo

/datum/spawnpoint/dorm
	display_name = "On-Site Dorms"
	msg = "has clocked in from the on-site dorms"
	allowed_mob_types = JOB_CARBON
	disallow_job = list(JOB_STOWAWAY)

/datum/spawnpoint/dorm/New()
	..()
	turfs = GLOB.latejoin_dorm

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
	turfs = GLOB.latejoin
