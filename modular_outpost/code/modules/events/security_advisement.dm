/datum/event/security_drill
	announceWhen	= 1

/datum/event/security_drill/announce()
	if(GLOB.security_level != SEC_LEVEL_GREEN) // If during peace
		command_announcement.Announce("A command issued drill scheduled at this hour has been cancelled due to a heightened alert level on station.", "Security Advisement")
		return

	// Basic security drill
	var/str = "[pick("An E-Shui security director", "A Sol-Gov correspondant", "A central command authority")] has"
	if(prob(20))
		str += " advised the enactment of [pick("a rampant wildlife", "a fire", "a hostile boarding", \
		"a bomb", "an emergent intelligence")] drill with the personnel onboard \the [location_name()]."
		GLOB.global_announcer.autosay(str, "Security Advisement", "Command")
		GLOB.global_announcer.autosay(str, "Security Advisement", "Security")
		return

	// Get all players that are not afk lurking
	var/list/players = list()
	for(var/mob/living/L in GLOB.player_list)
		if(L.client.is_afk(15 MINUTES))
			continue
		if(isnewplayer(L))
			continue
		if(isobserver(L))
			continue
		if(isanimal(L))
			continue
		if(isAI(L))
			continue
		players.Add(L)

	// If there are any players to pick at all
	var/mob/living/scan = pick(players)
	if(isnull(scan))
		return
	switch(scan.job)
		if(JOB_STOWAWAY)
			str += " ordered the detainment of an intruder detected aboard \the [location_name()]."

		if(JOB_CYBORG)
			str += " ordered the temporary detainment and inspection of \the [scan], due to "
			str += pick(
				"a possible hardware vulnerability.",
				"a possible syndicate hacking attempt.",
				"possible illegal modification by hostile actors.",
			)

		else
			if(prob(30))
				str += " ordered security staff to detain and search \the [scan], for potential suspicious activity."

			else if(scan.isSynthetic())
				str += " ordered the temporary detainment and questioning of \the [scan], due to "
				str += pick(
					"confiscated blackmarket components traced back to their frame.",
					"possible syndicate hardware tampering.",
					"access of secure company accounts using their user key.")

			else
				var/can_fork = TRUE
				if(ishuman(scan))
					var/mob/living/carbon/human/HU = scan
					if(HU.species && HU.species.flags & NO_SLEEVE)
						can_fork = FALSE
				str += " ordered the temporary detainment and questioning of \the [scan], due to "
				if(can_fork)
					str += pick(
						"a syndicate aligned fork of their mind and body record in another sector being apprehended.",
						"their body records being confiscated from a busted black market trading operation.",
						"intercepted syndicate communications identifying them as a possible infiltration vector.",
						"suspitious bank transfers, traced back to syndicate operations.",
						"purchase of illegal goods traced back to their name in a smuggling operation.",
						"the existance of a body trafficked fork of their body and mind record currently in protective custody.",
						"possible compliance implanting by hostile outside actors.",
					)
				else
					str += pick(
						"an ordered security review of their records.",
						"an ordered physical review of their treat assessment to the company.",
						"an ordered assessment of their use as a emergency asset recovery operative.",
						"possible compliance implanting by hostile outside actors.",
					)
	str += " Ensure to thoroughly interview the suspect about their activities and whereabouts over the past 48 hours, and fax a report containing interview contents and all identified contraband on their person, before releasing them if no offences were noted."

	GLOB.global_announcer.autosay(str, "Security Advisement", "Command")
	GLOB.global_announcer.autosay(str, "Security Advisement", "Security")
