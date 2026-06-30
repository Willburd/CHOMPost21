/datum/job/rd/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS,ACCESS_AI_UPLOAD)
	access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS)
	minimal_access -= list(ACCESS_ROBOTICS,ACCESS_AI_UPLOAD)
	minimal_access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS)


/datum/job/scientist/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS, ACCESS_XENOBOTANY)
	alt_titles -= list(JOB_ALT_CIRCUIT_DESIGNER, JOB_ALT_CIRCUIT_PROGRAMMER)
	alt_titles[JOB_ALT_TELEPORT_OPERATOR] = /datum/alt_title/teleport_operation


// Massive edit, so just redefined entirely to be engineering now
/datum/job/roboticist
	departments = list(DEPARTMENT_ENGINEERING)
	department_flag = ENGSEC
	supervisors = "the " + JOB_CHIEF_ENGINEER
	selection_color = "#5B4D20"
	pto_type = PTO_ENGINEERING
	outfit_type = /datum/decl/hierarchy/outfit/job/engineering/roboticist
	access = list(ACCESS_ROBOTICS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_EMERGENCY_STORAGE, ACCESS_CONSTRUCTION, ACCESS_EXTERNAL_AIRLOCKS)
	alt_titles = list(
		JOB_ALT_ASSEMBLY_TECHNICIAN = /datum/alt_title/assembly_tech,
		JOB_ALT_BIOMECHANICAL_ENGINEER = /datum/alt_title/biomech,
		JOB_ALT_MECHATRONIC_ENGINEER = /datum/alt_title/mech_tech,
		JOB_ALT_JUNIOR_ROBOTICIST = /datum/alt_title/junior_roboticist,
		JOB_ALT_CIRCUIT_DESIGNER = /datum/alt_title/circuit_designer,
		JOB_ALT_CIRCUIT_PROGRAMMER = /datum/alt_title/circuit_programmer,
		JOB_ALT_SOFTWARE_ENGINEER = /datum/alt_title/software_engi)


/datum/alt_title/junior_roboticist
	title = JOB_ALT_JUNIOR_ROBOTICIST
	title_blurb = "A " + JOB_ALT_JUNIOR_ROBOTICIST + " focuses on the construction and maintenance of Exosuits. While not being as well versed in their use, they should have some knowledge behind them during their training period. \
					They may also be called upon to work on synthetics and prosthetics, if needed."


// Alt titles
/datum/alt_title/circuit_designer
	title_blurb = "A " + JOB_ALT_CIRCUIT_DESIGNER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here

/datum/alt_title/circuit_programmer
	title_blurb = "A " + JOB_ALT_CIRCUIT_PROGRAMMER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here

/datum/alt_title/teleport_operation
	title = JOB_ALT_TELEPORT_OPERATOR
	title_blurb = "A " + JOB_ALT_TELEPORT_OPERATOR + " is a " + JOB_SCIENTIST + " who operates the public teleporter using telescience expertise to get crew to remote locations safely."


// Xenobotanist alt-title edits
/datum/alt_title/xenoflorist
	title = JOB_ALT_XENOFLORIST
	title_blurb = "A " + JOB_ALT_XENOFLORIST + " grows and cares for a variety of abnormal, custom made, and frequently dangerous plant life. When the products of these plants \
					are both safe and beneficial to the station, they may choose to introduce it to the rest of the crew."
	title_outfit = /datum/decl/hierarchy/outfit/job/science/xenobotanist

/datum/alt_title/xenohydroponicist
	title = JOB_ALT_XENOHYDROPONICIST
	title_blurb = "A " + JOB_ALT_XENOHYDROPONICIST + " grows and cares for a variety of abnormal, custom made, and frequently dangerous plant life. When the products of these plants \
					are both safe and beneficial to the station, they may choose to introduce it to the rest of the crew."
	title_outfit = /datum/decl/hierarchy/outfit/job/science/xenobotanist
