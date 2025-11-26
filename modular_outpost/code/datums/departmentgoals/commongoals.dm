/datum/goal/common
	category = GOAL_GENERAL


// Clean floors
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/clean_floors
	name = "Clean Dirty Floors"
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
	name = "Cardio Quota"
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
	name = "Grow Crops"
	goal_text = null
	var/total_crops_to_grow = 0

/datum/goal/common/grow_plants/New()
	. = ..()
	total_crops_to_grow = rand(200,1000)
	goal_text = "Crew should grow at least [total_crops_to_grow] plants of any type to encourage hydroponics and kitchen crew productivity."

/datum/goal/common/grow_plants/check_completion(has_completed)
	. = ..(GLOB.seed_planted_shift_roundstat >= total_crops_to_grow)


// Prey eaten
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/prey_eaten
	name = "Crew \"Morale\" Booster"
	goal_text = null
	var/total_prey_to_eat = 0

/datum/goal/common/prey_eaten/New()
	. = ..()
	total_prey_to_eat = rand(10,30)
	goal_text = "Crew should engage in more \"Recreational\" activities, with and even inside each other! Have at least [total_prey_to_eat] \"breaks\" together and find out just how close you can be as a crew!"

/datum/goal/common/prey_eaten/check_completion(has_completed)
	. = ..(GLOB.prey_eaten_roundstat >= total_prey_to_eat)


// Food cooked
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/common/food_prepared
	name = "Cook Food"
	goal_text = null
	var/total_meals_to_make = 0
	var/meals_made = 0

/datum/goal/common/food_prepared/New()
	. = ..()
	total_meals_to_make = rand(20,50)
	goal_text = "Get those friers ready, and cook up at least [total_meals_to_make] meals of any type for the crew!"
	RegisterSignal(SSdcs,COMSIG_GLOB_FOOD_PREPARED,PROC_REF(handle_food_prepared))

/datum/goal/common/food_prepared/Destroy(force)
	UnregisterSignal(SSdcs,COMSIG_GLOB_FOOD_PREPARED)
	. = ..()

/datum/goal/common/food_prepared/check_completion(has_completed)
	. = ..(meals_made >= total_meals_to_make)

/datum/goal/common/clean_floors/proc/handle_food_prepared(/datum/recipe/source, obj/container, list/results)
	SIGNAL_HANDLER
	meals_made++
