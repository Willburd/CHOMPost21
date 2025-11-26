/datum/goal/common
	category = GOAL_GENERAL


// Clean floors
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/clean_floors
	name = "clean dirty floors"
	goal_text = null
	var/total_floors_to_clean = 0
	var/cleaned_floors = 0

/datum/goal/common/clean_floors/New()
	. = ..()
	total_floors_to_clean = rand(400,1200)
	goal_text = "Clean up [total_floors_to_clean] dirty sections of floor, this station is filthy!"
	RegisterSignal(SSdcs,COMSIG_GLOB_MOPFLOOR,PROC_REF(handle_mopped_floor))

/datum/goal/common/clean_floors/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_MOPFLOOR)
	. = ..()

/datum/goal/common/clean_floors/check_completion(has_completed)
	. = ..(cleaned_floors >= total_floors_to_clean)

/datum/goal/common/clean_floors/proc/handle_mopped_floor(turf/source)
	SIGNAL_HANDLER
	cleaned_floors++


// Cardio
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/just_walk
	name = "cardio quota"
	goal_text = null
	var/total_steps_to_take = 0

/datum/goal/common/just_walk/New()
	. = ..()
	total_steps_to_take = rand(3000,8000)
	goal_text = "Crew should take at least [total_steps_to_take] steps to ensure their cardio quotas are met."

/datum/goal/common/just_walk/check_completion(has_completed)
	. = ..(GLOB.step_taken_shift_roundstat >= total_steps_to_take)


// Grow plants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/grow_plants
	name = "grow crops"
	goal_text = null
	var/total_crops_to_grow = 0

/datum/goal/common/grow_plants/New()
	. = ..()
	total_crops_to_grow = rand(200,1000)
	goal_text = "Crew should grow at least [total_crops_to_grow] plants of any type to encourage hydroponics and kitchen crew productivity."

/datum/goal/common/grow_plants/check_completion(has_completed)
	. = ..(GLOB.seed_planted_shift_roundstat >= total_crops_to_grow)
