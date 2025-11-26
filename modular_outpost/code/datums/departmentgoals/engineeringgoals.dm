/datum/goal/engineering
	category = GOAL_ENGINEERING


// Export power by PTL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/engineering/export_power
	name = "Export PTL Power"
	goal_text = null

/datum/goal/engineering/export_power/New()
	. = ..()
	goal_count = rand(25,100)
	goal_text = "Export [goal_count]GW of power via the power transmission laser."

/datum/goal/engineering/export_power/check_completion(has_completed)
	current_count = SSsupply.watts_sold
	. = ..(current_count >= (goal_count GIGAWATTS))
