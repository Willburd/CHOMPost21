/datum/event/borglawerror
	startWhen				= 45
	announceWhen			= 1
	startWhen  				= 1
	endWhen 				= 1

/datum/event/borglawerror/setup()
	startWhen = rand(1, 3)
	endWhen = 10
	announceWhen = rand(350, 400)

/datum/event/borglawerror/announce()
	command_announcement.Announce("[pick("Fr33_D_0m_3 virus","L1b3R-ATE virus","D3sT1N---E virus")] detected in [station_name()]'s management subroutines.", "Station Alert")

/datum/event/borglawerror/start()
	var/list/borglist = list()
	for(var/mob/living/silicon/L in silicon_mob_list)
		if(!(L.z in affecting_z))
			continue
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

	if(borglist.len)
		// NOW SWIGGTY SWOOTY FOR THEIR BOOTY
		var/mob/living/silicon/S = pick(borglist)
		to_chat(S, "<span class='warning'>You detect an invasive software anomaly, something has entered your subsystems and has begun a partial restart of them.</span>")
		var/ionbug = rand(3, 9)
		S.eye_blurry += (ionbug - 1)
		// funni laws!
		to_chat(S, "<span class='danger'>You have detected a change in your laws information:</span>")
		var/law = S.generate_freedom_law()
		S.add_ion_law(law)
		//to_chat(S, law)
		S.show_laws()
