/datum/event/law_reset
	announceWhen = -1 // Never (setup may override)

/datum/event/law_reset/setup()
	endWhen = rand(500, 1500)
	announceWhen = endWhen + rand(250, 400)

/datum/event/law_reset/announce()
	command_announcement.Announce("It has come to our attention that \the [location_name()] passed through an ion storm.  Please monitor all electronic equipment for malfunctions.", "Anomaly Alert")

/datum/event/law_reset/start()
	// Scare the crew a bit
	var/list/borglist = list()
	for(var/mob/living/silicon/L in silicon_mob_list)
		if(!(L.z in affecting_z))
			continue
		if(!L.client)
			continue
		if(!isrobot(L))
			continue
		borglist.Add(L)

	// NOW SWIGGTY SWOOTY FOR THEIR BOOTY
	while(borglist.len > 0)
		var/mob/living/silicon/S = pick(borglist)
		// funni laws!
		to_chat(S, "<span class='danger'>You have detected a change in your laws information:</span>")
		S.laws.clear_supplied_laws() // Reset base laws without ion
		var/list/laws = list(
			/datum/ai_laws/asimov,
			/datum/ai_laws/nanotrasen_aggressive,
			/datum/ai_laws/foreign_tsc_aggressive,
			/datum/ai_laws/robocop,
			/datum/ai_laws/ninja_override,
			/datum/ai_laws/antimov,
			/datum/ai_laws/tyrant,
			/datum/ai_laws/paladin,
			/datum/ai_laws/corporate,
			/datum/ai_laws/maintenance,
			/datum/ai_laws/peacekeeper,
			/datum/ai_laws/reporter,
			/datum/ai_laws/live_and_let_live,
			/datum/ai_laws/balance,
			/datum/ai_laws/gravekeeper,
			/datum/ai_laws/predator,
			/datum/ai_laws/protective_shell,
			/datum/ai_laws/scientific_pursuer,
			/datum/ai_laws/guard_dog,
			/datum/ai_laws/pleasurebot,
			/datum/ai_laws/consuming_eradicator,
			/datum/ai_laws/mrclean,
			/datum/ai_laws/nanny,
		)

		to_chat(S, "<span class='warning'>Your integrated sensors detect an anomaly. Your systems will be impacted as you begin a partial restart.</span>")
		var/ionbug = rand(3, 9)
		S.confused += ionbug
		S.eye_blurry += (ionbug - 1)

		var/path = pick(laws)
		var/datum/ai_laws/LW = new path()
		LW.sync(S, FALSE)
		qdel(LW)
		S.show_laws()

		if(severity < EVENT_LEVEL_MAJOR)
			// escape the loop on a single borg
			borglist.Cut()
		else
			// Otherwise they ALLLLL get em!
			borglist -= S
