/datum/event/mouse_assualt
	announceWhen	= 90
	var/spawncount = 1

/datum/event/mouse_assualt/setup()
	announceWhen = rand(announceWhen, announceWhen + 60)
	spawncount = rand(8 * severity, 12 * severity)

/datum/event/mouse_assualt/announce()
	command_announcement.Announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", new_sound = 'sound/AI/aliens.ogg')

/datum/event/mouse_assualt/start()
	var/list/possibleSpawnspots = list()
	for(var/obj/effect/landmark/L in GLOB.landmarks_list)
		if(L.name == "maint_pred")
			possibleSpawnspots += L

	while(spawncount > 0 && possibleSpawnspots.len)
		var/turf/spawnspot = get_turf(pick(possibleSpawnspots))

		if(prob(10))
			var/chosen_tank = pick(
			list(
				/mob/living/simple_mob/mechanical/mecha/mouse_tank/eraticator/manned,
				/mob/living/simple_mob/mechanical/mecha/mouse_tank/livewire/manned,
				/mob/living/simple_mob/mechanical/mecha/mouse_tank/manned
			))
			var/mob/living/simple_mob/mechanical/mecha/mouse_tank/C = new chosen_tank(spawnspot.loc)
			C.ai_holder.hostile = TRUE // OHNO
			C.ai_holder.violent_breakthrough = TRUE // OHNO

		var/subcount = pick(2,3,4)
		while(subcount > 0)
			var/chosen_rat = pick(
			list(
				/mob/living/simple_mob/animal/space/mouse_army/ammo,
				/mob/living/simple_mob/animal/space/mouse_army/operative,
				/mob/living/simple_mob/animal/space/mouse_army/pyro,
				/mob/living/simple_mob/animal/space/mouse_army/stealth
			))

			var/mob/living/simple_mob/animal/space/mouse_army/C = new chosen_rat(spawnspot.loc)
			C.ai_holder.hostile = TRUE // OHNO
			C.ai_holder.violent_breakthrough = TRUE // OHNO
			subcount--

		possibleSpawnspots -= spawnspot
		spawncount--
