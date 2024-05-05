/datum/event/psychic_screach
	announceWhen = -1 // Never (setup may override)

/datum/event/psychic_screach/setup()
	endWhen = rand(5, 10)
	announceWhen = endWhen + rand( 20, 30)

/datum/event/psychic_screach/announce()
	command_announcement.Announce("We just received readings that an unknown energy emission just passed through \the [location_name()]. Electrical systems appear to have been affected. Is anyone reading this?", "Anomaly Alert")

/datum/event/psychic_screach/start()
	// SCARY
	Sound( 'sound/goonstation/spooky/Meatzone_Howl.ogg', affecting_z)
	Sound( 'sound/goonstation/spooky/Station_SpookyAtmosphere2.ogg', affecting_z)

	// Break telecoms for a bit
	for(var/obj/machinery/telecomms/T in telecomms_list)
		T.emp_act(1)
	for(var/obj/machinery/exonet_node/N in machines)
		N.emp_act(1)

	// Vibe lights
	for(var/obj/machinery/light/L in machines)
		if(prob(10))
			L.broken()
		else
			L.flicker(9)

	// Scare the crew a bit
	var/list/borglist = list()
	for(var/mob/living/L in living_mob_list)
		if(!(L.z in affecting_z))
			continue
		if(isAI(L)) // AI is fine
			continue
		/* Outpost 21 - TODO add autodoc again
		if(istype(L,/mob/living/carbon/human/monkey/auto_doc))
			continue
		*/
		if(ishuman(L))
			// MMIs
			var/mob/living/carbon/human/H = L
			if (H.isSynthetic())
				// fwump
				to_chat(H, "<span class='warning'>Your integrated sensors detect an anomaly. Your systems will be impacted as you begin a partial restart.</span>")
				var/ionbug = rand(3, 9)
				H.confused += ionbug
				H.eye_blurry += (ionbug - 1)
			else
				// nosebleed
				to_chat(H, "<span class='warning'>Your nose begins to bleed...</span>")
				H.drip(1)
				H.Confuse(2)
				H.adjustHalLoss(30)
		else if(issilicon(L))
			// BORGS
			var/mob/living/silicon/S = L
			to_chat(S, "<span class='warning'>Your integrated sensors detect an anomaly. Your systems will be impacted as you begin a partial restart.</span>")
			var/ionbug = rand(3, 9)
			S.confused += ionbug
			S.eye_blurry += (ionbug - 1)
			if(isAI(L)) // not an AI event
				continue
			// extremely boring if a shell or empty gets it
			if(!L.client)
				continue
			if(isrobot(L))
				var/mob/living/silicon/robot/R = L
				if(R.shell)
					continue
			// BORGS LOCATED
			borglist.Add(L)
	// NOW SWIGGTY SWOOTY FOR THEIR BOOTY
	if(borglist.len)
		var/mob/living/silicon/S = pick(borglist)
		// funni laws!
		to_chat(S, "<span class='danger'>You have detected a change in your laws information:</span>")
		var/law = S.generate_screech_law()
		S.add_ion_law(law)
		//to_chat(S, law)
		S.show_laws()

/datum/event/psychic_screach/end()
	..()
	// finally a powerout
	Sound( 'sound/goonstation/spooky/Station_SpookyAtmosphere1.ogg', affecting_z)

	if(severity == EVENT_LEVEL_MAJOR)
		power_kill_quick() // OHNO
	else
		// This sets off a chain of events that lead to the actual grid check (or perhaps worse).
		// First, the Supermatter engine makes a power spike.
		for(var/obj/machinery/power/generator/engine in machines)
			engine.power_spike(80,TRUE,TRUE)
			break // Just one engine, please.

/datum/event/psychic_screach/proc/Sound(var/sound, var/list/zlevels)
	if(!sound)
		return

	for(var/mob/M in player_list)
		if(zlevels && !(M.z in zlevels))
			continue
		if(!isnewplayer(M) && !isdeaf(M))
			M << sound
