/datum/job/rd/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS,ACCESS_AI_UPLOAD)
	access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS,ACCESS_ELECTROPHYS)
	minimal_access -= list(ACCESS_ROBOTICS,ACCESS_AI_UPLOAD)
	minimal_access |= list(ACCESS_MAINT_TUNNELS, ACCESS_CHANGE_IDS,ACCESS_ELECTROPHYS)


/datum/job/scientist/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS, ACCESS_XENOBOTANY)
	alt_titles -= list(JOB_ALT_CIRCUIT_DESIGNER, JOB_ALT_CIRCUIT_PROGRAMMER)
	alt_titles[JOB_ALT_TELEPORT_OPERATOR] = /datum/alt_title/teleport_operation


// Particle physicist job
/datum/job/electro_physicist
	title = JOB_ELECTROPHYSICIST
	job_description = "A " + JOB_SCIENTIST + " with a specialty in micro-electronics and particle interactions. Using particle accelerators to convert one form of matter into another, or designing complex nano-circuitry. Experts in the field of electromagnetic radiation."
	flag = ELECTROPHYSICIST
	department_flag = MEDSCI
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = "the " + JOB_CHIEF_ENGINEER + " and " + JOB_RESEARCH_DIRECTOR
	departments = list(DEPARTMENT_RESEARCH, DEPARTMENT_ENGINEERING)
	selection_color = "#633D63"
	economic_modifier = 7
	pto_type = PTO_SCIENCE
	outfit_type = /datum/decl/hierarchy/outfit/job/science/electrophysicist
	access = list(ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_ELECTROPHYS)
	minimal_access = list(ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_ELECTROPHYS)
	alt_titles = list(
		JOB_ALT_CIRCUIT_DESIGNER = /datum/alt_title/circuit_designer,
		JOB_ALT_CIRCUIT_PROGRAMMER = /datum/alt_title/circuit_programmer,
		JOB_ALT_SOFTWARE_ENGINEER = /datum/alt_title/software_engi)
	mail_goodies = list(
		/obj/item/stack/material/steel{amount = 10} = 250,
		/obj/item/stack/material/glass{amount = 10} = 200,
		/obj/item/cell/super = 100,
		/obj/item/cell/hyper = 100,
		/obj/item/stack/material/plasteel{amount = 10} = 70,
		/obj/item/stock_parts/matter_bin/adv = 45,
		/obj/item/stock_parts/manipulator/nano = 45,
		/obj/item/stock_parts/capacitor/adv = 45,
		/obj/item/stock_parts/scanning_module/adv = 45,
		/obj/item/stock_parts/micro_laser/high = 45,
		/obj/item/stack/nanopaste/advanced = 30,
		/obj/item/stock_parts/matter_bin/super = 5,
		/obj/item/stock_parts/manipulator/pico = 5,
		/obj/item/stock_parts/capacitor/super = 5,
		/obj/item/stock_parts/scanning_module/phasic = 5,
		/obj/item/stock_parts/micro_laser/ultra = 5
	)
	mail_color = COMMS_COLOR_SCIENCE


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
		JOB_ALT_JUNIOR_ROBOTICIST = /datum/alt_title/junior_roboticist)


/datum/alt_title/junior_roboticist
	title = JOB_ALT_JUNIOR_ROBOTICIST
	title_blurb = "A " + JOB_ALT_JUNIOR_ROBOTICIST + " focuses on the construction and maintenance of Exosuits. While not being as well versed in their use, they should have some knowledge behind them during their training period. \
					They may also be called upon to work on synthetics and prosthetics, if needed."

/datum/job/xenobiologist/New()
	access -= list(ACCESS_ROBOTICS)
	minimal_access -= list(ACCESS_ROBOTICS)


/datum/job/xenobotanist
	supervisors = "the " + JOB_QUARTERMASTER + " and " + JOB_RESEARCH_DIRECTOR
	departments = list(DEPARTMENT_RESEARCH, DEPARTMENT_CIVILIAN)
	outfit_type = /datum/decl/hierarchy/outfit/job/science/xenobotanist

/datum/job/xenobotanist/New()
	. = ..()
	access -= list(ACCESS_ROBOTICS)
	access |= list(ACCESS_HYDROPONICS, ACCESS_KITCHEN)
	minimal_access -= list(ACCESS_ROBOTICS)
	minimal_access |= list(ACCESS_HYDROPONICS, ACCESS_KITCHEN)


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
