/datum/event/bluespace_shelling
	announceWhen   	= 0
	startWhen 		= 30
	endWhen 		= 500

	// Exclude these types and sub-types from targeting eligibilty
	var/list/area/excluded = list(
		/area/shuttle,
		/area/crew_quarters,
		/area/holodeck,
		/area/engineering/gravgen,
		/area/maintenance/incinerator,
		/area/engineering/coreproctunnel,
		/area/muriki/crew/bunker
	)

	var/spawncount = 0
	var/department = -1 // this is a really dumb way to do it, but it works nice, uses HOLOMAP_AREACOLOR_
	var/department_name = "surface facility"
	var/list/area/grand_list_of_areas = list()
	var/list/area/finalareas = list()
	var/shotdelaytime = 0
	var/seclevel = SEC_LEVEL_DELTA // it's the entire facility by default, all others give red alert

	// regional impact limits. AKA only hit inside the box
	var/left_x = 0
	var/bottom_y = 0
	var/right_x = 400
	var/top_y = 200


/datum/event/bluespace_shelling/setup()
	spawncount = rand(15,25)
	if(department == -1)
		spawncount = rand(30,45)

	grand_list_of_areas = get_station_areas(excluded)
	for(var/area/A in grand_list_of_areas)
		if(istype(src,/datum/event/bluespace_shelling/civilian))
			if(A.holomap_color == HOLOMAP_AREACOLOR_CIV || A.holomap_color == HOLOMAP_AREACOLOR_HALLWAYS ||  A.holomap_color == HOLOMAP_AREACOLOR_DORMS || A.holomap_color == HOLOMAP_AREACOLOR_COMMAND || A.holomap_color == HOLOMAP_AREACOLOR_HYDROPONICS || A.holomap_color == HOLOMAP_AREACOLOR_ENGINEERING || A.holomap_color == HOLOMAP_AREACOLOR_CARGO || A.holomap_color == HOLOMAP_AREACOLOR_MEDICAL)
				finalareas += A
		else
			if(department == -1 || A.holomap_color == department || A.holomap_color == HOLOMAP_AREACOLOR_MEDICAL || A.holomap_color == HOLOMAP_AREACOLOR_COMMAND || A.holomap_color == HOLOMAP_AREACOLOR_CARGO)
				finalareas += A

/datum/event/bluespace_shelling/announce()
	command_announcement.Announce("Attention [station_name()]. Bluespace shelling confirmed for [department_name]. Fire for Effect. All crew must retreat to a safe distance, seek shelter, and remain in place until the all clear is given. ETA 30 seconds.", "Bluespace Shelling")
	set_security_level(seclevel)

/datum/event/bluespace_shelling/tick()
	if(finalareas.len == 0)
		return

	if(world.time > shotdelaytime && spawncount >= 0)
		if(spawncount > 0)
			boom(2)
			boom(2)
			if(prob(20))
				boom(2)
			if(prob(20))
				boom(1)
			if(prob(20))
				boom(1)

			if(spawncount == 1)
				command_announcement.Announce("Attention [station_name()]. Commencing final volley, brace for impact.", "Bluespace Shelling")
		else
			// end it
			boom(3)
			boom(2)
			boom(2)
			boom(1)
			boom(1)
			boom(1)
			endWhen = 0 // Now
			command_announcement.Announce("Cease Fire. Cease Fire. Bluespace artillery shelling has finalized. All clear. Assess damage, and begin repair operations.", "Bluespace Shelling")
		spawncount--

/datum/event/bluespace_shelling/proc/boom(var/mult)
	var/hitsize = rand(1,3) * mult
	if(spawncount <= 0)
		hitsize = rand(3,7) * mult // final shots

	var/escape = 20
	while(escape > 0) // reattempt
		var/area/bombarea = pick(finalareas)
		var/turf/picked = pick(get_area_turfs(bombarea))
		if(picked.x >= left_x && picked.x < right_x && picked.y >= bottom_y && picked.y < top_y)
			explosion(picked, 2, hitsize,hitsize * 1.5)
			break
		escape--

	shotdelaytime = world.time + (rand(hitsize,hitsize * 3) SECONDS)


/datum/event/bluespace_shelling/engineering
	department = HOLOMAP_AREACOLOR_ENGINEERING
	department_name = "engineering facility"
	seclevel = SEC_LEVEL_RED
	left_x = 100
	bottom_y = 75
	right_x = 175
	top_y = 200

/datum/event/bluespace_shelling/science
	department = HOLOMAP_AREACOLOR_SCIENCE
	department_name = "research and development department"
	seclevel = SEC_LEVEL_RED
	left_x = 220
	bottom_y = 100
	right_x = 400
	top_y = 200

/datum/event/bluespace_shelling/security
	department = HOLOMAP_AREACOLOR_SECURITY
	department_name = "security facility"
	seclevel = SEC_LEVEL_RED
	left_x = 175
	bottom_y = 0
	right_x = 280
	top_y = 75

/datum/event/bluespace_shelling/medical
	department = HOLOMAP_AREACOLOR_SECURITY
	department_name = "medical facility"
	seclevel = SEC_LEVEL_RED
	left_x = 175
	bottom_y = 75
	right_x = 280
	top_y = 400

/datum/event/bluespace_shelling/cargo
	department = HOLOMAP_AREACOLOR_CARGO
	department_name = "cargo facility"
	seclevel = SEC_LEVEL_RED
	left_x = 100
	bottom_y = 0
	right_x = 175
	top_y = 75

/datum/event/bluespace_shelling/civilian
	department = HOLOMAP_AREACOLOR_CIV
	department_name = "civilian facility"
	seclevel = SEC_LEVEL_RED
	left_x = 270
	bottom_y = 0
	right_x = 400
	top_y = 100


/datum/event/bluespace_shelling/waste
	department = -1
	department_name = "waste processing facility"
	seclevel = SEC_LEVEL_RED
	left_x = 0
	bottom_y = 15
	right_x = 80
	top_y = 70
