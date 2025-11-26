/datum/goal/common
	category = GOAL_GENERAL


// Clean floors
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/clean_floors
	name = "Clean Dirty Floors"
	goal_text = null

/datum/goal/common/clean_floors/New()
	. = ..()
	goal_count = rand(1000,2000)
	goal_text = "Clean up [goal_count] dirty sections of floor, this station gets filthy!"
	RegisterSignal(SSdcs,COMSIG_GLOB_MOPFLOOR,PROC_REF(handle_mopped_floor))

/datum/goal/common/clean_floors/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_MOPFLOOR)
	. = ..()

/datum/goal/common/clean_floors/check_completion(has_completed)
	. = ..(current_count >= goal_count)

/datum/goal/common/clean_floors/proc/handle_mopped_floor(turf/source)
	SIGNAL_HANDLER
	current_count++


// Cardio
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/just_walk
	name = "Cardio Quota"
	goal_text = null

/datum/goal/common/just_walk/New()
	. = ..()
	goal_count = rand(3000,8000)
	goal_text = "Crew should take at least [goal_count] steps to ensure their cardio quotas are met."

/datum/goal/common/just_walk/check_completion(has_completed)
	current_count = GLOB.step_taken_shift_roundstat
	. = ..(GLOB.step_taken_shift_roundstat >= goal_count)


// Grow plants
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/grow_plants
	name = "Grow Crops"
	goal_text = null

/datum/goal/common/grow_plants/New()
	. = ..()
	goal_count = rand(200,1000)
	goal_text = "Crew should grow at least [goal_count] plants of any type to encourage hydroponics and kitchen crew productivity."

/datum/goal/common/grow_plants/check_completion(has_completed)
	current_count = GLOB.seed_planted_shift_roundstat
	. = ..(current_count >= goal_count)


// Prey eaten
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/prey_eaten
	name = "Crew \"Morale\" Booster"
	goal_text = null

/datum/goal/common/prey_eaten/New()
	. = ..()
	goal_count = rand(10,30)
	goal_text = "Crew should engage in more \"Recreational\" activities, with and even inside each other! Have at least [goal_count] \"breaks\" together and find out just how close you can be as a crew!"

/datum/goal/common/prey_eaten/check_completion(has_completed)
	current_count = GLOB.prey_eaten_roundstat
	. = ..(current_count >= goal_count)


// Food cooked
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/food_prepared
	name = "Cook Food"
	goal_text = null

/datum/goal/common/food_prepared/New()
	. = ..()
	goal_count = rand(50,100)
	goal_text = "Get those friers ready, and cook up at least [goal_count] meals of any type for the crew!"
	RegisterSignal(SSdcs,COMSIG_GLOB_FOOD_PREPARED,PROC_REF(handle_food_prepared))

/datum/goal/common/food_prepared/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_FOOD_PREPARED)
	. = ..()

/datum/goal/common/food_prepared/check_completion(has_completed)
	. = ..(current_count >= goal_count)

/datum/goal/common/food_prepared/proc/handle_food_prepared(datum/recipe/source, obj/container, list/results)
	SIGNAL_HANDLER
	current_count++
