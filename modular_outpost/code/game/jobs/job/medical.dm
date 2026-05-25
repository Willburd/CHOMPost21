/datum/job/cmo/New()
	. = ..()
	access |= list(ACCESS_CHANGE_IDS)
	minimal_access |= list(ACCESS_CHANGE_IDS)

/datum/job/doctor/New()
	. = ..()
	alt_titles |= list(JOB_ALT_XENOSPECIALIST = /datum/alt_title/xenoanatomyspecialist)


/datum/job/geneticist
	supervisors = "the " + JOB_CHIEF_MEDICAL_OFFICER + " and " + JOB_RESEARCH_DIRECTOR
	pto_type = PTO_SCIENCE
	selection_color = "#633D63"
	departments = list(DEPARTMENT_RESEARCH, DEPARTMENT_MEDICAL)

/datum/job/geneticist/New()
	. = ..()
	access |= list(ACCESS_MEDICAL_EQUIP)
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
	title_outfit = /datum/decl/hierarchy/outfit/job/medical/doctor/surgeon
