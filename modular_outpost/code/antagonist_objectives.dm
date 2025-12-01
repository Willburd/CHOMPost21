// TODO - Create custom objective system that replaced the old one for all antags
/datum/antagonist/proc/outpost_custom_antag_objectives(var/datum/mind/player)

	var/datum/objective/survive/survive = new
	survive.owner = player
	player.objectives |= survive

	return TRUE
