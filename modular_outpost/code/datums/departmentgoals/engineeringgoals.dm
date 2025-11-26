/datum/goal/engineering
	category = GOAL_ENGINEERING


// Export power by PTL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/engineering/export_power
	name = "Export PTL Power"
	goal_text = null
	var/wattage = 0

/datum/goal/engineering/export_power/New()
	. = ..()
	wattage = rand(25,100)
	goal_text = "Export [wattage]GW of power via the power transmission laser."

/datum/goal/engineering/export_power/check_completion(has_completed)
	. = ..(SSsupply.watts_sold >= (wattage GIGAWATTS))
