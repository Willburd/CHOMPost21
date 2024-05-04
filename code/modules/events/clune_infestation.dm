/datum/event/clune_infestation
	announceWhen	= 90
	var/spawncount = 1

/datum/event/clune_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 60)
	spawncount = rand(6 * severity, 9 * severity)

/datum/event/clune_infestation/announce()
	command_announcement.Announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", new_sound = 'sound/AI/aliens.ogg')
	sleep(15)
	command_announcement.Announce("Attention, all security staff. Hostile circumorph bio-signs detected in maintenance tunnels. Euthanize all infected individuals immediately.", "Circumorph Alert")


/datum/event/clune_infestation/start()
	var/list/possibleSpawnspots = list()
	for(var/obj/effect/landmark/L in landmarks_list)
		if(L.name == "maint_pred")
			possibleSpawnspots += L

	while((spawncount >= 1) && possibleSpawnspots.len)
		var/turf/spawnspot = get_turf(pick(possibleSpawnspots))

		// normal ones...
		var/subcount = pick(2,3)
		while((subcount >= 1))
			var/mob/living/simple_mob/clowns/normal/C = new /mob/living/simple_mob/clowns/normal()
			C.ai_holder.hostile = TRUE // OHNO
			C.loc = spawnspot.loc
			subcount--

		// what in gods name.
		subcount = pick(1,2)
		while((subcount >= 1))
			var/chosen_clown = pick(
			list(/mob/living/simple_mob/clowns/big/honkling
			, /mob/living/simple_mob/clowns/big/blob
			, /mob/living/simple_mob/clowns/big/mutant
			, /mob/living/simple_mob/clowns/big/flesh
			, /mob/living/simple_mob/clowns/big/scary
			, /mob/living/simple_mob/clowns/big/giggles
			, /mob/living/simple_mob/clowns/big/longface
			, /mob/living/simple_mob/clowns/big/hulk
			, /mob/living/simple_mob/clowns/big/thin
			, /mob/living/simple_mob/clowns/big/wide
			, /mob/living/simple_mob/clowns/big/perm
			, /mob/living/simple_mob/clowns/big/thicc
			, /mob/living/simple_mob/clowns/big/punished
			, /mob/living/simple_mob/clowns/big/cluwne
			, /mob/living/simple_mob/clowns/big/honkmunculus))

			var/mob/living/simple_mob/clowns/big/C = new chosen_clown()
			C.ai_holder.hostile = TRUE // OHNO
			C.ai_holder.violent_breakthrough = TRUE // OHNO
			C.loc = spawnspot.loc
			subcount--

		possibleSpawnspots -= spawnspot
		spawncount--
