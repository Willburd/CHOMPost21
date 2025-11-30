/datum/job/rd/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS)
	access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS)
	minimal_access -= list(ACCESS_ROBOTICS)
	minimal_access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS)


/datum/job/scientist/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS)
	alt_titles -= list(JOB_ALT_CIRCUIT_DESIGNER, JOB_ALT_CIRCUIT_PROGRAMMER)


// Massive edit, so just redefined entirely to be engineering now
/datum/job/roboticist
	departments = list(DEPARTMENT_ENGINEERING)
	department_flag = ENGSEC
	supervisors = "the " + JOB_CHIEF_ENGINEER
	selection_color = "#5B4D20"
	pto_type = PTO_ENGINEERING
	outfit_type = /decl/hierarchy/outfit/job/engineering/roboticist
	access = list(ACCESS_ROBOTICS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_EXTERNAL_AIRLOCKS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_EMERGENCY_STORAGE, ACCESS_CONSTRUCTION, ACCESS_EXTERNAL_AIRLOCKS)
	alt_titles = list(
		JOB_ALT_ASSEMBLY_TECHNICIAN = /datum/alt_title/assembly_tech,
		JOB_ALT_BIOMECHANICAL_ENGINEER = /datum/alt_title/biomech,
		JOB_ALT_MECHATRONIC_ENGINEER = /datum/alt_title/mech_tech,
		JOB_ALT_CIRCUIT_DESIGNER = /datum/alt_title/circuit_designer,
		JOB_ALT_CIRCUIT_PROGRAMMER = /datum/alt_title/circuit_programmer,
		JOB_ALT_SOFTWARE_ENGINEER = /datum/alt_title/software_engi)


/datum/job/xenobotanist/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS)


// Alt titles
/datum/alt_title/circuit_designer
	title_blurb = "A " + JOB_ALT_CIRCUIT_DESIGNER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here

/datum/alt_title/circuit_programmer
	title_blurb = "A " + JOB_ALT_CIRCUIT_PROGRAMMER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here
