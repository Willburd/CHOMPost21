/datum/unit_test/open_space_turf_shall_be_valid

/datum/unit_test/open_space_turf_shall_be_valid/Run()
	var/failed = FALSE

	var/list/shown_areas = list()
	for(var/turf/simulated/open/O in world)
		var/area/A = get_area(O)
		if(!A)
			continue
		if(A.type in shown_areas)
			continue
		// Make sure areas with open pits can legally have them, construction breaks if the base turf is wrong!
		if(!(A.base_turf in typesof(/turf/simulated/open)))
			TEST_NOTICE(src,"[O.x].[O.y].[O.z] [A]: Map - Openspace in an area without open space as the default turf")
			shown_areas.Add(A.type)
			failed = TRUE
		// Find mismatched atmos turfs in huge areas of openspace
		for(var/D in GLOB.cardinal)
			var/turf/T = get_step(O,D)
			if(istype(T,/turf/simulated/open))
				if(!SSair.has_same_air( O, T))
					TEST_NOTICE(src,"[O.x].[O.y].[O.z]: Map - A neighbouring openspace turf had mismatched default atmos.")
					failed = TRUE

	if(failed)
		TEST_FAIL("Open space turfs illegally placed. Open space in areas without openspace base turfs will have broken behavior")
