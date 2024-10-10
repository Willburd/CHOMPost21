/var/global/spacemoss_spawned = 0

/datum/event/spacemoss
	announceWhen	= 60

/datum/event/spacemoss/start()
	spacemoss_infestation()
	spacemoss_spawned = 1

/datum/event/spacemoss/announce()
	//level_seven_announcement() // Chomp Edit, this was stupid and vague and wrong.
	command_announcement.Announce("Plant infestation detected on \the [station_name()]. Sensors indicate slow growth, investigate plant species for possible botanical or medical uses.", "Unknown Flora")
