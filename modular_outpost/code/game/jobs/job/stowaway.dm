//////////////////////////////////
//		Maintenance Gremlin
//////////////////////////////////

/datum/job/stowaway
	title = JOB_STOWAWAY
	supervisors = "nobody! You don't work here"
	faction = "Station"
	flag = STOWAWAY
	sorting_order = -2
	departments = list(DEPARTMENT_NONCREW)
	department_flag = OTHER
	job_description = "Escaped clone, social outcast, ex-employee, or sentient wildlife; The maintenance tunnels of the station are your home. While you have no real authority or responsibility, your survival requires you to cooperate with the crew. This is not an antag role, but you may still defend yourself."
	timeoff_factor = 0
	account_allowed = FALSE
	requestable = FALSE
	offmap_spawn = TRUE // spawns in unique spots only, and doesn't show up on regular datacore
	has_headset = FALSE
	selection_color = "#353535"
	total_positions = 3
	spawn_positions = 2
	economic_modifier = 1
	alt_titles = list("Gremlin" = /datum/alt_title/gremlin, "Hunter" = /datum/alt_title/hunter, "Scavenger" = /datum/alt_title/scavenger, "Moss Collector" = /datum/alt_title/moss_collector)
	outfit_type = /decl/hierarchy/outfit/job/stowaway
	access = list()
	minimal_access = list()
	forbid_department_account_access = TRUE

/datum/job/stowaway/New()
	..()

/datum/job/stowaway/get_access()
	return list()

/datum/alt_title/gremlin
	title = "Gremlin"

/datum/alt_title/hunter
	title = "Hunter"

/datum/alt_title/scavenger
	title = "Scavenger"

/datum/alt_title/moss_collector
	title = "Moss Collector"
