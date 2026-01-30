#define SPIDERS 1
#define TROIDS 2
#define SLIMES 3

/datum/event/horde_infestation
	announceWhen	= 30
	endWhen		= 200
	var/spawncount = 1
	var/spawning = 0
	var/list/alive_metroids = list()

/datum/event/horde_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 60)

	spawning = rand(SPIDERS,SLIMES)
	switch(spawning)
		if(SPIDERS)
			log_world("## DEBUG: Hord event, spiders selected.")
			spawncount = rand(4 * severity, 10 * severity)
			GLOB.sent_spiders_to_station = FALSE

		if(TROIDS)
			log_world("## DEBUG: Horde event, metroids selected.")
			spawncount = rand(2 * severity, 4 * severity)

		if(SLIMES)
			log_world("## DEBUG: Horde event, slimes selected.")
			spawncount = rand(4 * severity, 10 * severity)

/datum/event/horde_infestation/announce()
	if(spawning == SPIDERS || spawning == SLIMES)
		command_announcement.Announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", new_sound = 'sound/AI/aliens.ogg')
	if(spawning == TROIDS)
		command_announcement.Announce("High-energy lifeforms detected coming aboard [station_name()]. All crew members, stay alert, and listen to security instructions.", "Lifesign Alert", new_sound = 'sound/misc/alarm1.ogg')

/datum/event/horde_infestation/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in GLOB.machines) //Gathering together all possible areas to spawn mobs.
		var/in_area = get_area(temp_vent)
		if(istype(in_area, /area/crew_quarters/sleep) || istype(in_area, /area/hallway/secondary/entry))
			continue
		if(!temp_vent.welded && temp_vent.network && (temp_vent.loc.z in using_map.event_levels)) //No spawns on welded vents
			if(temp_vent.network.normal_members.len > 10)
				vents += temp_vent

	switch(spawning)
		if(SPIDERS)
			while((spawncount >= 1) && vents.len)
				var/obj/vent = pick(vents)
				var/spawn_spiderlings = pickweight(list(
					/obj/effect/spider/spiderling/space = 95,
					/obj/effect/spider/eggcluster/space = 4,
					/obj/effect/spider/eggcluster/royal/space = 1
					))
				new spawn_spiderlings(vent.loc)
				vents -= vent
				spawncount--
		if(TROIDS)
			while((spawncount >= 1) && vents.len)
				var/obj/vent = pick(vents)
				var/spawn_metroids = pickweight(list(
					/mob/living/simple_mob/metroid/juvenile/baby = 60,
					/mob/living/simple_mob/metroid/juvenile/super = 30,
					/mob/living/simple_mob/metroid/juvenile/alpha = 10,
					/mob/living/simple_mob/metroid/juvenile/gamma = 3,
					/mob/living/simple_mob/metroid/juvenile/zeta = 2,
					/mob/living/simple_mob/metroid/juvenile/omega = 1,
					))
				alive_metroids.Add(new spawn_metroids(get_turf(vent)))
				vents -= vent
				spawncount--
		if(SLIMES)
			while((spawncount >= 1) && vents.len)
				var/obj/vent = pick(vents)
				var/spawn_slimes = pickweight(list(
					/mob/living/simple_mob/slime/xenobio = 30,
					/mob/living/simple_mob/slime/xenobio/amber = 5,
					/mob/living/simple_mob/slime/xenobio/blue = 5,
					/mob/living/simple_mob/slime/xenobio/cerulean = 5,
					/mob/living/simple_mob/slime/xenobio/dark = 5,
					/mob/living/simple_mob/slime/xenobio/emerald = 10,
					/mob/living/simple_mob/slime/xenobio/gold = 10,
					/mob/living/simple_mob/slime/xenobio/nuclear = 5,
					/mob/living/simple_mob/slime/xenobio/metal = 5,
					/mob/living/simple_mob/slime/xenobio/ruby = 10,
					/mob/living/simple_mob/slime/xenobio/sapphire = 10
					))
				new spawn_slimes(get_turf(vent))
				vents -= vent
				spawncount--
	// Cleanup
	vents.Cut()

/datum/event/horde_infestation/end()
	if(spawning == SPIDERS)
		return
	if(spawning == SLIMES)
		return
	if(spawning == TROIDS)
		var/list/area_names = list()
		for(var/mob/living/M in alive_metroids)
			if(!M || M.stat == DEAD)
				continue
			var/area/metroid_area = get_area(M)
			if(!metroid_area) //Huh, really?
				if(!get_turf(M)) //No turf either?
					qdel(M) //Must have been nullspaced
					continue
			area_names |= metroid_area.name
		if(area_names.len)
			var/english_list = english_list(area_names)
			command_announcement.Announce("Sensors have narrowed down remaining lifeforms to the following areas: [english_list]", "Lifesign Alert")

#undef SPIDERS
#undef TROIDS
#undef SLIMES
