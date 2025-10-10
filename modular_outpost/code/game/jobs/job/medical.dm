/datum/job/doctor/New()
	. = ..()
	alt_titles |= list(JOB_ALT_XENOSPECIALIST = /datum/alt_title/xenoanatomyspecialist)


/datum/job/geneticist
	departments = list(DEPARTMENT_MEDICAL)
	supervisors = "the " + JOB_CHIEF_MEDICAL_OFFICER

/datum/job/geneticist/New()
	. = ..()
	access -= list(ACCESS_RESEARCH)
	access |= list(ACCESS_MEDICAL_EQUIP)
	minimal_access -= list(ACCESS_RESEARCH)
	minimal_access |= list(ACCESS_MEDICAL_EQUIP)
	alt_titles = list(JOB_ALT_GENE_THERAPIST = /datum/alt_title/genetherapy, JOB_ALT_SLEEVE_ENGINEER = /datum/alt_title/sleeveengineer) // TODO if geneticist gets alt titles change to |=


/datum/job/psychiatrist/New()
	. = ..()
	access |= list(ACCESS_MEDICAL_EQUIP)
	minimal_access |= list(ACCESS_MEDICAL_EQUIP)


// Alt titles
/datum/alt_title/genetherapy
	title = JOB_ALT_GENE_THERAPIST

/datum/alt_title/sleeveengineer
	title = JOB_ALT_SLEEVE_ENGINEER

/datum/alt_title/xenoanatomyspecialist
	title = JOB_ALT_XENOSPECIALIST
	title_blurb = "A " + JOB_ALT_XENOSPECIALIST + " specializes in providing surgery for crewmembers with exotic anatomy, up to and including amputation and limb reattachement. They are expected \
					to know the ins and outs of anesthesia and surgery."
	title_outfit = /decl/hierarchy/outfit/job/medical/doctor/surgeon
