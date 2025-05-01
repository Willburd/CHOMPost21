/datum/unit_test/apc_area_test
	name = "MAP: Outpost 21 buildcode"

/datum/unit_test/apc_area_test/start_test()
	var/failures = 0

	var/list/exempt_areas = typesof(/area/space,
					/area/syndicate_station,
					/area/skipjack_station,
					/area/solar,
					/area/shuttle,
					/area/holodeck,
					/area/supply/station,
					/area/mine,
					/area/vacant/vacant_shop,
					/area/turbolift,
					/area/submap,
					/area/muriki/septic,
					/area/security/brig/isolate,
					/area/rnd/research/phoronics/bombrange,
					/area/muriki/crew/glass,
					/area/engineering/coreproctunnel,
					/area/medical/voxlab/airlock,
					/area/medical/voxlab/airgap,
					/area/rnd/research/isolation_a,
					/area/rnd/research/isolation_b,
					/area/rnd/research/isolation_c,
					/area/muriki/yard,
					/area/muriki/crystal,
					/area/muriki/station/trawler_dock,
					/area/security/eva,
					/area/engineering/eva,
					/area/engineering/engine_airlock,
					/area/medical/virologyaccess,
					/area/engineering/engine_room,
					/area/hydroponics/gibber,
					/area/rnd/research/roof_eva
					)

	var/list/forced_hallway = list(
			/area/security/prison,
			/area/crew_quarters/recreation_area_hallway,
			/area/bridge_hallway,
			/area/engineering/aft_hallway,
			/area/medical/medbay,
			/area/medical/surgery_hallway,
			/area/rnd/xenobiology/hallway,
			/area/muriki/crewstairwell,
			/area/hydroponics/hallway,
			/area/hallway/secondary/secmedbridge,
			/area/rnd/hallway,
			/area/rnd/hallway/main,
			/area/rnd/hallway/basementstairs,
			/area/rnd/hallway/upper,
			/area/rnd/hallway/lowmain,
			/area/rnd/hallway/xeno,
			/area/rnd/hallway/hazard,
			/area/rnd/hallway/staircase,
			/area/rnd/hallway/phoronicsbridge,
			/area/rnd/hallway/phoronicsmainhall
		)

	var/list/does_not_use_lightswitch = list(
			/area/security/brig,
			/area/engineering/trammaint,
			/area/security/surgery,
			/area/muriki/crew/dormaid,
			/area/muriki/crew/baraid,
			/area/muriki/crew/engyaid,
			/area/security/security_aid_station,
			/area/engineering/refinery/aid_station,
			/area/rnd/research/phoronics/med,
			/area/security/nuke_storage
		)

	var/list/zs_to_test = using_map.unit_test_z_levels || list(1) //Either you set it, or you just get z1

	for(var/area/A in world)
		if(!(A.z in zs_to_test) || (A.type in exempt_areas))
			continue
		// Includes subtypes of areas, unlike above which is path specific
		if(istype(A,/area/muriki/elevator))
			continue
		if(istype(A,/area/muriki/processor))
			continue
		if(istype(A,/area/muriki/grounds))
			continue
		if(istype(A,/area/muriki/rooftop))
			continue
		if(istype(A,/area/muriki/skyline))
			continue
		if(istype(A,/area/turbolift))
			continue
		if(istype(A,/area/maintenance))
			continue
		if(istype(A,/area/muriki/bathroom))
			continue
		// Validate various room requirements, ON STATION
		if(!(A.z in using_map.station_levels))
			continue
		// REQUIREMENTS:

		// fire alarm
		if(!(locate(/obj/machinery/firealarm) in A.contents))
			log_unit_test("[A] lacks a fire alarm")
			failures++
		// radio
		if(!(locate(/obj/item/radio/intercom) in A.contents))
			log_unit_test("[A] lacks an intercom")
			failures++
		// extinguishers
		if(!(locate(/obj/structure/extinguisher_cabinet) in A.contents))
			log_unit_test("[A] lacks a fire extinguisher")
			failures++

		// Hallways have some unique properties
		var/is_hallway = FALSE
		if(istype(A,/area/hallway))
			is_hallway = TRUE
		if(istype(A,/area/muriki/tramstation))
			is_hallway = TRUE
		if(A.type in forced_hallway)
			is_hallway = TRUE

		if(!is_hallway)
			// lightswitches required in rooms
			if(!(A.type in does_not_use_lightswitch))
				if(!(locate(/obj/machinery/light_switch) in A.contents))
					log_unit_test("[A] lacks an lightswitch")
					failures++
		else
			// lightswitches forbidden in hallways
			if((locate(/obj/machinery/light_switch) in A.contents))
				log_unit_test("[A] had a lightswitch, but is a hallway")
				failures++



	if(failures)
		fail("[failures] areas fail outpost 21 buildcode.")
	else
		pass("All areas pass outpost 21 buildcode.")

	return 1
