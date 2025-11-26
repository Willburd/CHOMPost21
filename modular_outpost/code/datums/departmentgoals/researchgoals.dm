/datum/goal/research
	category = GOAL_RESEARCH


// Extract artifacts
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/research/extract_artifacts
	name = "Extract Artifact Powers"
	goal_text = null
	var/artifact_count = 0
	var/extraction_count = 0

/datum/goal/research/extract_artifacts/New()
	. = ..()
	artifact_count = rand(35,50)
	goal_text = "Extract the powers of [artifact_count] artifacts to prove RnD's overblown budget is needed."
	RegisterSignal(SSdcs,COMSIG_GLOB_HARVEST_ARTIFACT,PROC_REF(handle_artifact_harvest))

/datum/goal/research/extract_artifacts/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_HARVEST_ARTIFACT)
	. = ..()

/datum/goal/research/extract_artifacts/check_completion(has_completed)
	. = ..(extraction_count >= artifact_count)

/datum/goal/research/extract_artifacts/proc/handle_artifact_harvest(atom/source, obj/item/anobattery/inserted_battery, mob/user)
	SIGNAL_HANDLER
	extraction_count++


// Extract slimes
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/research/extract_slime_cores
	name = "Extract Slime Cores"
	goal_text = null
	var/slime_count = 0
	var/extraction_count = 0

/datum/goal/research/extract_slime_cores/New()
	. = ..()
	slime_count = rand(50,100)
	goal_text = "Extract the cores of [slime_count] slimes, regardless of type."
	RegisterSignal(SSdcs,COMSIG_GLOB_HARVEST_SLIME_CORE,PROC_REF(handle_slime_harvest))

/datum/goal/research/extract_slime_cores/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_HARVEST_SLIME_CORE)
	. = ..()

/datum/goal/research/extract_slime_cores/check_completion(has_completed)
	. = ..(extraction_count >= slime_count)

/datum/goal/research/extract_slime_cores/proc/handle_slime_harvest(atom/source)
	SIGNAL_HANDLER
	extraction_count++


// Build Mechs
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/research/build_mechs
	name = "Extract Slime Cores"
	goal_text = null
	var/mech_count = 0
	var/build_mech_goal_count = 0

/datum/goal/research/build_mechs/New()
	. = ..()
	build_mech_goal_count = rand(10,20)
	goal_text = "Flex the RnD budget and produce [build_mech_goal_count] mechs of any type."
	RegisterSignal(SSdcs,COMSIG_GLOB_MECH_CONSTRUCTED,PROC_REF(handle_mech_construction))

/datum/goal/research/build_mechs/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_MECH_CONSTRUCTED)
	. = ..()

/datum/goal/research/build_mechs/check_completion(has_completed)
	. = ..(mech_count >= build_mech_goal_count)

/datum/goal/research/build_mechs/proc/handle_mech_construction(atom/source)
	SIGNAL_HANDLER
	mech_count++
