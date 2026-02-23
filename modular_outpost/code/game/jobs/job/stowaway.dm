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
	total_positions = 6
	spawn_positions = 4
	economic_modifier = 1
	alt_titles = list("Gremlin" = /datum/alt_title/gremlin, "Hunter" = /datum/alt_title/hunter, "Scavenger" = /datum/alt_title/scavenger, "Moss Collector" = /datum/alt_title/moss_collector, "Penetration Tester" = /datum/alt_title/experiment)
	outfit_type = /datum/decl/hierarchy/outfit/job/stowaway
	access = list()
	minimal_access = list()
	forbid_department_account_access = TRUE

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

/datum/alt_title/experiment
	title = "Penetration Tester"
	title_blurb = "Unlike other stowaway roles, this title is for an authorized station penetration tester. Hired specifically to act like a stowaway as part of opposing force training with security. Your safety is not guarenteed however, as crew are not obligated to help you still."
	title_outfit = /datum/decl/hierarchy/outfit/job/stowaway/pentester
