/datum/antagonist/create_objectives(var/datum/mind/player)
	if(outpost_custom_antag_objectives(player)) // Just call the big custom list
		return 0
	. = ..()
