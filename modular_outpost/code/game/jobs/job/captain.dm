/datum/job/hop/New()
	. = ..()
	alt_titles |= list(	JOB_ALT_COMMAND_LIAISON = /datum/alt_title/command_liaison,
						JOB_ALT_BRIDGE_SECRETARY = /datum/alt_title/bridge_secretary,
						JOB_ALT_COMMAND_SECRETARY = /datum/alt_title/command_secretary)


// Alt titles
/datum/alt_title/command_secretary
	title = JOB_ALT_COMMAND_SECRETARY



// Command Officer
/datum/job/command_officer
	title = JOB_COMMAND_OFFICER
	flag = BRIDGE
	departments = list(DEPARTMENT_COMMAND)
	department_accounts = list(DEPARTMENT_COMMAND)
	department_flag = CIVILIAN
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 3
	supervisors = "command staff"
	selection_color = "#1D1D4F"
	minimal_player_age = 5
	economic_modifier = 7
	disallow_jobhop = TRUE
	pto_type = PTO_CIVILIAN
	alt_titles = list(
		JOB_ALT_CO_PETTY_OFFICER = /datum/alt_title/co_petty_officer,
		JOB_ALT_CO_PETTY_CADET = /datum/alt_title/co_cadet,
		JOB_ALT_CO_WARRANT_OFFICER = /datum/alt_title/co_warrant_officer,
		JOB_ALT_CO_ASSIST_MED_OFFICER = /datum/alt_title/co_med_officer,
		JOB_ALT_CO_ASSIST_SEC_OFFICER = /datum/alt_title/co_sec_officer,
		JOB_ALT_CO_ASSIST_ENG_OFFICER = /datum/alt_title/co_eng_officer,
		JOB_ALT_CO_ASSIST_SCI_OFFICER = /datum/alt_title/co_sci_officer
	)

	access = list(ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_EMERGENCY_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_TELEPORTER, ACCESS_BAR, ACCESS_GATEWAY, ACCESS_EVA, ACCESS_ALL_PERSONAL_LOCKERS)
	minimal_access = list(ACCESS_HEADS, ACCESS_RC_ANNOUNCE, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_EMERGENCY_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_TELEPORTER, ACCESS_BAR)

	outfit_type = /datum/decl/hierarchy/outfit/job/command_officer
	job_description = "A " + JOB_COMMAND_OFFICER + " is the introductory role to most officer positions. Tasked with learning from, and assisting heads of staff."

/datum/alt_title/co_cadet // jr officer, no expanded access
	title = JOB_ALT_CO_PETTY_CADET
	title_blurb = "A " + JOB_ALT_CO_PETTY_CADET + " is a junior command staff officer. Performing simple jobs for heads of staff and other command officers, like running faxes, signing papers, or getting coffee and donuts"

/datum/alt_title/co_warrant_officer
	title = JOB_ALT_CO_WARRANT_OFFICER
	title_blurb = "A " + JOB_ALT_CO_WARRANT_OFFICER + " is an expert in a specific technical field. Offering guidance and expertise to command staff. As well as training non-command staff."
	additional_access = list(ACCESS_TCOMSAT, ACCESS_AI_UPLOAD, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_ENGINE, ACCESS_MEDICAL, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_CARGO, ACCESS_RESEARCH, ACCESS_MINING)

/datum/alt_title/co_petty_officer
	title = JOB_ALT_CO_PETTY_OFFICER
	title_blurb = "A " + JOB_ALT_CO_PETTY_OFFICER + " is the introductory role to the " + JOB_QUARTERMASTER + " position. Tasked with training their department staff, and assisting the " + JOB_QUARTERMASTER + " directly."
	additional_access = list(ACCESS_QM, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_HYDROPONICS)

/datum/alt_title/co_med_officer
	title = JOB_ALT_CO_ASSIST_MED_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_MED_OFFICER + " is the introductory role to the " + JOB_CHIEF_MEDICAL_OFFICER + " position. Tasked with training their department staff, and assisting the " + JOB_CHIEF_MEDICAL_OFFICER + " directly."
	additional_access = list(ACCESS_CMO, ACCESS_MEDICAL, ACCESS_MEDICAL_EQUIP, ACCESS_MORGUE, ACCESS_GENETICS, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_SURGERY, ACCESS_PSYCHIATRIST)

/datum/alt_title/co_sec_officer
	title = JOB_ALT_CO_ASSIST_SEC_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_SEC_OFFICER + " is the introductory role to the " + JOB_HEAD_OF_SECURITY + " position. Tasked with training their department staff, and assisting the " + JOB_HEAD_OF_SECURITY + " directly."
	additional_access = list(ACCESS_HOS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE)

/datum/alt_title/co_eng_officer
	title = JOB_ALT_CO_ASSIST_ENG_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_ENG_OFFICER + " is the introductory role to the " + JOB_CHIEF_ENGINEER + " position. Tasked with training their department staff, and assisting the " + JOB_CHIEF_ENGINEER + " directly."
	additional_access = list(ACCESS_CE, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_AI_UPLOAD)

/datum/alt_title/co_sci_officer
	title = JOB_ALT_CO_ASSIST_SCI_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_SCI_OFFICER + " is the introductory role to the " + JOB_RESEARCH_DIRECTOR + " position. Tasked with training their department staff, and assisting the " + JOB_RESEARCH_DIRECTOR + " directly."
	additional_access = list(ACCESS_RD, ACCESS_TOX, ACCESS_MORGUE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_TECH_STORAGE, ACCESS_XENOARCH, ACCESS_EXPLORER, ACCESS_PATHFINDER, ACCESS_XENOBOTANY)
