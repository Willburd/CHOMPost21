/datum/goal
	var/name = "goal"
	var/category = null
	var/goal_text = "Do nothing! Congratulations."
	VAR_PRIVATE/completed = FALSE

/// Handles midround announcement, the override should pass TRUE to the parent call if the goal completes during the round!
/datum/goal/proc/check_completion(has_completed = TRUE)
	SHOULD_CALL_PARENT(TRUE)
	if(has_completed && !completed)
		command_announcement.Announce("The [category] \"[name]\" has been completed, congratulations!", "Central Command")
		completed = TRUE
	return completed

/datum/goal/proc/get_completed() // Faster, does not recalculate
	return completed
