/datum/goal/engineering
	category = GOAL_ENGINEERING


// Export power by PTL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/goal/engineering/export_power
	name = "export PTL power"
	goal_text = null
	var/wattage = rand(25,100)

/datum/goal/engineering/export_power/New()
	. = ..()
	goal_text = "Export [wattage]GW of power via the power transmission laser."

/datum/goal/engineering/export_power/check_completion(has_completed)
	. = ..(SSsupply.watts_sold >= (wattage GIGAWATTS))
