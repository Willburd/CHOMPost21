/datum/job/hop/New()
	. = ..()
	alt_titles |= list(	JOB_ALT_COMMAND_LIAISON = /datum/alt_title/command_liaison,
						JOB_ALT_COMMAND_ASSISTANT = /datum/alt_title/command_assistant,
						JOB_ALT_COMMAND_INTERN = /datum/alt_title/command_intern,
						JOB_ALT_BRIDGE_SECRETARY = /datum/alt_title/bridge_secretary,
						JOB_ALT_BRIDGE_ASSISTANT = /datum/alt_title/bridge_assistant,
						JOB_ALT_BRIDGE_OFFICER = /datum/alt_title/bridge_officer,
						JOB_ALT_COMMAND_SECRETARY = /datum/alt_title/bridge_officer)


// Alt titles
/datum/alt_title/command_secretary
	title = JOB_ALT_COMMAND_SECRETARY
