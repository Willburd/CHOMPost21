/datum/event/security_drill
	announceWhen	= 1

/datum/event/security_drill/announce()
	if(security_level == SEC_LEVEL_GREEN) // If during peace
		command_announcement.Announce("[pick("An E-Shui security director", "A Sol-Gov correspondant", "A central command authority")] \
		has advised the enactment of [pick("a rampant wildlife", "a fire", "a hostile boarding", \
		"a bomb", "an emergent intelligence")] drill with the personnel onboard \the [location_name()].", "Security Advisement")
	else
		command_announcement.Announce("A command issued drill schedualed at this hour has been cancelled due to a highened alert level on station.", "Security Advisement")
