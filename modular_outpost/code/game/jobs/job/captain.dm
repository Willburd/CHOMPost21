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

	access = list(ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_TCOMSAT, ACCESS_AI_UPLOAD, ACCESS_EMERGENCY_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_GATEWAY, ACCESS_TELEPORTER, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_ENGINE, ACCESS_MEDICAL, ACCESS_BAR, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_HYDROPONICS, ACCESS_RESEARCH, ACCESS_MINING)
	minimal_access = list(ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_TCOMSAT, ACCESS_AI_UPLOAD, ACCESS_EMERGENCY_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_GATEWAY, ACCESS_TELEPORTER, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_ENGINE, ACCESS_MEDICAL, ACCESS_BAR, ACCESS_JANITOR, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_HYDROPONICS, ACCESS_RESEARCH, ACCESS_MINING)

	outfit_type = /decl/hierarchy/outfit/job/command_officer
	job_description = "A " + JOB_COMMAND_OFFICER + " is the introductory role to most officer positions. Tasked with learning from, and assisting heads of staff."

/datum/alt_title/co_petty_officer
	title = JOB_ALT_CO_PETTY_OFFICER
	title_blurb = "A " + JOB_ALT_CO_PETTY_OFFICER + " is a command staff officer. They typically serve most of their time on the bridge. Performing jobs for heads of staff, as well as other command officers."

/datum/alt_title/co_cadet
	title = JOB_ALT_CO_PETTY_CADET
	title_blurb = "A " + JOB_ALT_CO_PETTY_CADET + " is a junior command staff officer. Performing simple jobs for heads of staff and other command officers, like running faxes, signing papers, or getting coffee and donuts"

/datum/alt_title/co_warrant_officer
	title = JOB_ALT_CO_WARRANT_OFFICER
	title_blurb = "A " + JOB_ALT_CO_WARRANT_OFFICER + " is an expert in a specific technical field. Offering guidance and expertise to command staff. As well as training non-command staff."

/datum/alt_title/co_med_officer
	title = JOB_ALT_CO_ASSIST_MED_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_MED_OFFICER + " is the introductory role to the " + JOB_CHIEF_MEDICAL_OFFICER + " position. Tasked with training their department staff, and assisting the " + JOB_CHIEF_MEDICAL_OFFICER + " directly."

/datum/alt_title/co_sec_officer
	title = JOB_ALT_CO_ASSIST_SEC_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_SEC_OFFICER + " is the introductory role to the " + JOB_HEAD_OF_SECURITY + " position. Tasked with training their department staff, and assisting the " + JOB_HEAD_OF_SECURITY + " directly."

/datum/alt_title/co_eng_officer
	title = JOB_ALT_CO_ASSIST_ENG_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_ENG_OFFICER + " is the introductory role to the " + JOB_CHIEF_ENGINEER + " position. Tasked with training their department staff, and assisting the " + JOB_CHIEF_ENGINEER + " directly."

/datum/alt_title/co_sci_officer
	title = JOB_ALT_CO_ASSIST_SCI_OFFICER
	title_blurb = "A " + JOB_ALT_CO_ASSIST_SCI_OFFICER + " is the introductory role to the " + JOB_RESEARCH_DIRECTOR + " position. Tasked with training their department staff, and assisting the " + JOB_RESEARCH_DIRECTOR + " directly."
