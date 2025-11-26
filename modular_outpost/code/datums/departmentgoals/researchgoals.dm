/datum/goal/research
	category = GOAL_RESEARCH


// Extract artifacts
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/research/extract_artifacts
	name = "extract artifact powers"
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


// Breed slimes
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Explode TTVs
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Build Mechs
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
