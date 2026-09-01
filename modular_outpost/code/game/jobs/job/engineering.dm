/datum/job/chief_engineer/New()
	. = ..()
	access |= list(ACCESS_ROBOTICS, ACCESS_CHANGE_IDS)
	minimal_access |= list(ACCESS_ROBOTICS, ACCESS_CHANGE_IDS)


/datum/job/engineer/New()
	. = ..()
	access |= list(ACCESS_ROBOTICS, ACCESS_ATMOSPHERICS)
	alt_titles |= list(	JOB_ALT_SHIPBREAKER = /datum/alt_title/ship_breaker)


/datum/job/atmos/New()
	. = ..()
	access |= list(ACCESS_ROBOTICS)
	alt_titles |= list(JOB_ALT_DISPOSALS_TECHNICIAN = /datum/alt_title/disposals_tech)


// Alt titles
/datum/alt_title/ship_breaker
	title = JOB_ALT_SHIPBREAKER
	title_blurb = "A " + JOB_ALT_SHIPBREAKER + " specializes in the dismantling and recovery of destroyed or retired ships. Often in EVA environments on orbital stations."

/datum/alt_title/electro_physicist
	title = JOB_ALT_ELECTROPHYSICIST
	title_blurb = "A " + JOB_ROBOTICIST + " with a specialty in micro-electronics and particle interactions. Using particle accelerators to convert one form of matter into another, or designing complex nano-circuitry. Experts in the field of electromagnetic radiation."
