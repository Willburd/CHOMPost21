/datum/job/chief_engineer/New()
	. = ..()
	access |= list(ACCESS_ROBOTICS)
	minimal_access |= list(ACCESS_ROBOTICS)


/datum/job/engineer/New()
	. = ..()
	alt_titles |= list(	JOB_ALT_SHIPBREAKER = /datum/alt_title/ship_breaker,
						JOB_ALT_CHEMENGINEER = /datum/alt_title/chem_tech)


/datum/job/atmos/New()
	. = ..()
	alt_titles |= list(JOB_ALT_DISPOSALS_TECHNICIAN = /datum/alt_title/disposals_tech)


// Alt titles
/datum/alt_title/ship_breaker
	title = JOB_ALT_SHIPBREAKER
	title_blurb = "A " + JOB_ALT_SHIPBREAKER + " specializes in the dismantling and recovery of destroyed or retired ships. Often in EVA environments on orbital stations."

/datum/alt_title/chem_tech
	title = JOB_ALT_CHEMENGINEER
	title_blurb = "A " + JOB_ALT_CHEMENGINEER + " specializes in industrial scale chemical production and export."
	title_outfit = /decl/hierarchy/outfit/job/engineering/chems
