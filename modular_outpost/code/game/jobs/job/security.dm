/datum/job/hos/New()
	. = ..()
	access |= list(ACCESS_CHANGE_IDS)
	minimal_access |= list(ACCESS_CHANGE_IDS)


/datum/job/warden/New()
	. = ..()
	access |= list(ACCESS_FORENSICS_LOCKERS)
	minimal_access |= list(ACCESS_FORENSICS_LOCKERS)


/datum/job/officer/New()
	. = ..()
	access |= list(ACCESS_FORENSICS_LOCKERS)
	minimal_access |= list(ACCESS_FORENSICS_LOCKERS)
	alt_titles |= list(	JOB_ALT_DETECTIVE = /datum/alt_title/detective,
						JOB_ALT_INVESTIGATOR = /datum/alt_title/investigator,
						JOB_ALT_SECURITY_INSPECTOR = /datum/alt_title/security_inspector,
						JOB_ALT_FORENSIC_TECHNICIAN = /datum/alt_title/forensic_tech)

// Alt titles
/datum/alt_title/detective
	title_blurb = "A " + JOB_ALT_DETECTIVE + " works to help Security find criminals who have not properly been identified, through interviews and forensic work. \
						For crimes only witnessed after the fact, or those with no survivors, they attempt to piece together what they can from pure evidence."

/datum/alt_title/forensic_tech
	title_blurb = "A " + JOB_ALT_FORENSIC_TECHNICIAN + " works more with hard evidence and labwork than a " + JOB_ALT_DETECTIVE + ", but they share the purpose of solving crimes."
