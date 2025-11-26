/datum/goal
	var/name = "goal"
	var/goal_text = "Do nothing! Congratulations."
	var/fail_text = "How did you fail to do nothing!?"
	var/active_goal = FALSE
	var/category = null
	var/completed = FALSE

/datum/goal/proc/check_completion(has_completed)
	SHOULD_CALL_PARENT(TRUE)
	if(has_completed && !completed) // Midround announcement
		command_announcement.Announce(span_boldannounce("The [category] \"[name]\" has been completed, congratulations!"), "Central Command")
	return completed

/datum/goal/common
	category = GOAL_GENERAL

/datum/goal/medical
	category = GOAL_MEDICAL

/datum/goal/security
	category = GOAL_SECURITY

/datum/goal/engineering
	category = GOAL_ENGINEERING

/datum/goal/cargo
	category = GOAL_CARGO

/datum/goal/research
	category = GOAL_RESEARCH
