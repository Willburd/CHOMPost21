/datum/job/hydro
	supervisors = "the " + JOB_QUARTERMASTER
	selection_color = "#aaaaaa"
	sorting_order = 2


/datum/job/bartender
	supervisors = "the " + JOB_QUARTERMASTER
	selection_color = "#aaaaaa"
	sorting_order = 1


/datum/job/chef
	supervisors = "the " + JOB_QUARTERMASTER
	selection_color = "#aaaaaa"
	sorting_order = 1


/datum/job/janitor
	departments = list(DEPARTMENT_CARGO)
	supervisors = "the " + JOB_QUARTERMASTER
	selection_color = "#7a4f33"

/datum/job/janitor/New()
	. = ..()
	access |= list(ACCESS_CARGO, ACCESS_MAILSORTING)
	minimal_access |= list(ACCESS_CARGO, ACCESS_MAILSORTING)


/datum/job/lawyer
	departments = list(DEPARTMENT_COMMAND)
	selection_color = "#1D1D4F"


/datum/job/entertainer/New()
	. = ..()
	alt_titles |= list(JOB_ALT_RADIOHOST = /datum/alt_title/radiohost)


// Alt titles
/datum/alt_title/radiohost
	title = JOB_ALT_RADIOHOST
	title_blurb = "A " + JOB_ALT_RADIOHOST + "'s job includes playing music, singing songs, tell stories, or reading your favorite fanfic. You are the radiowave gremlin of the station make sure everyone else knows that!"
