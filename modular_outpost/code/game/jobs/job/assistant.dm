/datum/job/intern
	selection_color = "#515151"


/datum/job/assistant
	supervisors = "nobody! You don't work here, but station rank and laws still apply to you."
	alt_titles = list(
		JOB_ALT_TECHNICAL_ASSISTANT,
		JOB_ALT_MEDICAL_INTERN,
		JOB_ALT_RESEARCH_ASSISTANT,
		JOB_ALT_RESIDENT = /datum/alt_title/outpost_resident,
		JOB_ALT_SPACER = /datum/alt_title/spacer
	)


// Alt titles
/datum/alt_title/outpost_resident
	title = JOB_ALT_RESIDENT
	title_blurb = "A " + JOB_ALT_RESIDENT + " is a resident of central command. They may be a vacationing member of another department, or a new hire not yet assigned to a department. They are part of the crew, but are not authorized weapons, and have no real authority."
	title_outfit = /decl/hierarchy/outfit/job/assistant/visitor

/datum/alt_title/spacer
	title = JOB_ALT_SPACER
	title_blurb = "A " + JOB_ALT_SPACER + " is a resident of the local solar system. They could have many possible jobs; trader, bounty hunter, or part of a crew that travels space without settling on a planet. While on station they are treated as part of the crew as visitors, they are not authorized weapons, and have no real authority."
	title_outfit = /decl/hierarchy/outfit/job/assistant/visitor
