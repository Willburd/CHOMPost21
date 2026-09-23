// RD is disabled
/datum/job/rd
	faction = FACTION_NONE
	assignable = FALSE
	requestable = FALSE
	total_positions = 0
	spawn_positions = 0

/datum/job/rd/New()
	. = ..()
	access = list()
	minimal_access = list()


// Scientist is command
/datum/job/scientist
	supervisors = "command staff"
	selection_color = "#1D1D4F"
	departments = list(DEPARTMENT_COMMAND)
	department_accounts = list(DEPARTMENT_COMMAND)
	access = list(ACCESS_RESEARCH, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE)
	minimal_access = list(ACCESS_RESEARCH, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE)
	job_description = "A " + JOB_SCIENTIST + " is a researcher working in the Command department, with general knowledge of the scientific process, as well as the principles and requirements of Research and Development. Often assists with command paperwork."
	alt_titles = list(JOB_ALT_RESEARCHER = /datum/alt_title/researcher, JOB_ALT_LAB_ASSISTANT = /datum/alt_title/lab_assistant, JOB_ALT_TELEPORT_OPERATOR = /datum/alt_title/teleport_operation)


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
		JOB_ALT_SOFTWARE_ENGINEER = /datum/alt_title/software_engi,
		JOB_ALT_ELECTROPHYSICIST = /datum/alt_title/electro_physicist)


// Alt titles
/datum/alt_title/junior_roboticist
	title = JOB_ALT_JUNIOR_ROBOTICIST
	title_blurb = "A " + JOB_ALT_JUNIOR_ROBOTICIST + " focuses on the construction and maintenance of Exosuits. While not being as well versed in their use, they should have some knowledge behind them during their training period. \
					They may also be called upon to work on synthetics and prosthetics, if needed."

/datum/alt_title/circuit_designer
	title_blurb = "A " + JOB_ALT_CIRCUIT_DESIGNER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here

/datum/alt_title/circuit_programmer
	title_blurb = "A " + JOB_ALT_CIRCUIT_PROGRAMMER + " is a " + JOB_ENGINEER + " whose expertise is working with integrated circuits. They are familar with the workings and programming of those devices. \
				   They work to create various useful devices using the capabilities of integrated circuitry." // engineering here

/datum/alt_title/teleport_operation
	title = JOB_ALT_TELEPORT_OPERATOR
	title_blurb = "A " + JOB_ALT_TELEPORT_OPERATOR + " is a " + JOB_SCIENTIST + " who operates the public teleporter using telescience expertise to get crew to remote locations safely."

/datum/alt_title/phoron_research
	title_outfit = /datum/decl/hierarchy/outfit/job/engineering/atmos/phoronics

/datum/alt_title/gas_physicist
	title_outfit = /datum/decl/hierarchy/outfit/job/engineering/atmos/phoronics



// Moving to cargo
/datum/job/xenobiologist
	departments = list(DEPARTMENT_CARGO)
	pto_type = PTO_CARGO
	supervisors = "the " + JOB_QUARTERMASTER
	selection_color = "#7a4f33"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_XENOBIOLOGY)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MAILSORTING, ACCESS_XENOBIOLOGY)
	banned_job_species = list(FBP_DIGITAL)
	mail_color = COMMS_COLOR_SUPPLY

/datum/job/xenobiologist/New()
	. = ..()
	alt_titles |= list(
		JOB_ALT_XENOHUSBANDRY = /datum/alt_title/xenohusbandry
	)

/datum/alt_title/xenohusbandry
	title = JOB_ALT_XENOHUSBANDRY
