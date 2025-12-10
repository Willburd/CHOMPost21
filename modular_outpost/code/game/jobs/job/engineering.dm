/datum/job/chief_engineer/New()
	. = ..()
	access |= list(ACCESS_ROBOTICS, ACCESS_CHANGE_IDS)
	minimal_access |= list(ACCESS_ROBOTICS, ACCESS_CHANGE_IDS)


/datum/job/engineer/New()
	. = ..()
	alt_titles |= list(	JOB_ALT_SHIPBREAKER = /datum/alt_title/ship_breaker)


/datum/job/atmos/New()
	. = ..()
	alt_titles |= list(JOB_ALT_DISPOSALS_TECHNICIAN = /datum/alt_title/disposals_tech)


// Alt titles
/datum/alt_title/ship_breaker
	title = JOB_ALT_SHIPBREAKER
	title_blurb = "A " + JOB_ALT_SHIPBREAKER + " specializes in the dismantling and recovery of destroyed or retired ships. Often in EVA environments on orbital stations."
