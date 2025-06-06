var/list/spawntypes = list()

/proc/populate_spawn_points()
	spawntypes = list()
	for(var/type in subtypesof(/datum/spawnpoint))
		var/datum/spawnpoint/S = new type()
		spawntypes[S.display_name] = S

/proc/get_spawn_points()
	if(!LAZYLEN(spawntypes))
		populate_spawn_points()
	return spawntypes

/datum/spawnpoint
	var/msg          //Message to display on the arrivals computer.
	var/list/turfs   //List of turfs to spawn on.
	var/display_name //Name used in preference setup.
	var/list/restrict_job = null
	var/list/disallow_job = null
	var/announce_channel = "Common"
	var/allow_offmap_spawn = FALSE // add option to allow offmap spawns to a spawnpoint without entirely restricting that spawnpoint
	var/allowed_mob_types = JOB_SILICON|JOB_CARBON

/datum/spawnpoint/proc/check_job_spawning(job)
	if(restrict_job && !(job in restrict_job))
		return 0

	if(disallow_job && (job in disallow_job))
		return 0

	var/datum/job/J = SSjob.get_job(job)
	if(!J) // Couldn't find, admin shenanigans? Allow it
		return 1

	if(J.offmap_spawn && !allow_offmap_spawn && !(job in restrict_job)) // add option to allow offmap spawns to a spawnpoint without entirely restricting that spawnpoint
		return 0

	if(!(J.mob_type & allowed_mob_types))
		return 0

	return 1

/datum/spawnpoint/proc/get_spawn_position()
	return get_turf(pick(turfs))

/datum/spawnpoint/arrivals
	display_name = "Arrivals Shuttle"
	// msg = "will arrive to the station shortly by shuttle"
	msg = "has arrived on station by shuttle" // Outpost 21 edit
	disallow_job = list(JOB_STOWAWAY) //CHOMPEdit add // Outpost 21 edit

/datum/spawnpoint/arrivals/New()
	..()
	turfs = GLOB.latejoin

/* Outpost 21 edit - Only use ours
/datum/spawnpoint/gateway
	display_name = "Gateway"
	msg = "has completed translation from offsite gateway"

/datum/spawnpoint/gateway/New()
	..()
	turfs = GLOB.latejoin_gateway
*/

/* VOREStation Edit
/datum/spawnpoint/elevator
	display_name = "Elevator"
	msg = "has arrived from the residential district"

/datum/spawnpoint/elevator/New()
	..()
	turfs = latejoin_elevator
*/
/* Outpost 21 edit - Only use ours
/datum/spawnpoint/cryo
	display_name = "Cryogenic Storage"
	msg = "has completed cryogenic revival"
	allowed_mob_types = JOB_CARBON
	disallow_job = list(JOB_OUTSIDER) //CHOMPEdit add

/datum/spawnpoint/cryo/New()
	..()
	turfs = GLOB.latejoin_cryo

/datum/spawnpoint/cyborg
	display_name = "Cyborg Storage"
	msg = "has been activated from storage"
	allowed_mob_types = JOB_SILICON
	disallow_job = list(JOB_OUTSIDER) //CHOMPEdit add

/datum/spawnpoint/cyborg/New()
	..()
	turfs = GLOB.latejoin_cyborg

/obj/effect/landmark/arrivals
	name = "JoinLateShuttle"
	delete_me = 1

/obj/effect/landmark/arrivals/Initialize(mapload)
	GLOB.latejoin += loc
	. = ..()

GLOBAL_LIST_EMPTY(latejoin_tram)

/obj/effect/landmark/tram
	name = "JoinLateTram"
	delete_me = 1

/obj/effect/landmark/tram/Initialize(mapload)
	GLOB.latejoin_tram += loc // There's no tram but you know whatever man!
	. = ..()

/datum/spawnpoint/tram
	display_name = "Tram Station"
	msg = "will arrive to the station shortly by shuttle"
	disallow_job = list(JOB_OUTSIDER) //CHOMPEdit add

/datum/spawnpoint/tram/New()
	..()
	turfs = GLOB.latejoin_tram
*/

/datum/spawnpoint/vore
	display_name = "Vorespawn - Prey"
	msg = "has arrived on the station"
	allow_offmap_spawn = TRUE

/datum/spawnpoint/vore/pred
	display_name = "Vorespawn - Pred"
	msg = "has arrived on the station"

// CHOMPEnable Start
/datum/spawnpoint/vore/itemtf
	display_name = "Item TF spawn"
	msg = "has arrived on the station"
// CHOMPEnable End

/datum/spawnpoint/vore/New()
	..()
	turfs = GLOB.latejoin
