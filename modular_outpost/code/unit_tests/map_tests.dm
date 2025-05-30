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
		/area/rnd/research/roof_eva,
		/area/ai_sat/core_external,
		/area/offworld/confinementbeam/exterior,
		/area/ai_sat/power_control
		)

	var/list/forced_hallway = list(
		/area/security/prison,
		/area/crew_quarters/recreation_area_hallway,
		/area/bridge_hallway,
		/area/bridge/hallway,
		/area/engineering/aft_hallway,
		/area/medical/medbay,
		/area/medical/medbay2,
		/area/medical/medbay3,
		/area/medical/medbay4,
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
		/area/rnd/hallway/phoronicsmainhall,
		/area/engineering/atmoshall,
		/area/engineering/refinery/tugstorage,
		/area/rnd/stairwell,
		/area/quartermaster/foyer,
		/area/muriki/research/isolation_hall,
		/area/medical/stairwell,
		/area/medical/patient_wing,
		/area/rnd/research/phoronics,
		/area/ai_sat/fore_airlock,
		/area/ai_sat/access_shaft,
		/area/ai_sat/docking_wing,
		/area/offworld/confinementbeam/station/trawler_airlock,
		/area/offworld/confinementbeam/station/access_shaft,
		/area/offworld/confinementbeam/station/starboard_airlock,
		/area/offworld/confinementbeam/station/port_airlock,
		/area/offworld/confinementbeam/station/hallway,
		/area/offworld/confinementbeam/station/hallway_alt
	)

	var/list/does_not_use_lightswitch = list(
		/area/muriki/arriveelev,
		/area/rnd/entry,
		/area/rnd/entry_aux,
		/area/rnd/research/roof_eva,
		/area/muriki/cybstorage,
	)

	var/list/does_not_have_disposals = list(
		/area/security/tankstore,
		/area/security/brig,
		/area/engineering/trammaint,
		/area/security/prison,
		/area/security/riot_control,
		/area/muriki/crew/dormaid,
		/area/muriki/crew/baraid,
		/area/muriki/crew/engyaid,
		/area/security/security_aid_station,
		/area/engineering/refinery/aid_station,
		/area/medical/first_aid_station_starboard,
		/area/medical/first_aid_station,
		/area/quartermaster/mining/firstaid,
		/area/rnd/research/phoronics/med,
		/area/rnd/research/medical,
		/area/rnd/research/medical_roof,
		/area/medical/hangar,
		/area/security/hangar,
		/area/medical/resleeving,
		/area/medical/patient_a,
		/area/medical/patient_b,
		/area/medical/patient_c,
		/area/hallway/secondary/secmedbridge,
		/area/hallway/secondary/chapel_hallway,
		/area/quartermaster/cargrecycle,
		/area/muriki/crew/arcade/lasertagstore,
		/area/medical/tankstore,
		/area/muriki/crew/bunker,
		/area/engineering/refinery/pump_station,
		/area/hallway/muriki/bunkerhall,
		/area/medical/autosleever,
		/area/medical/medbay4,
		/area/muriki/atmos/voxdump,
		/area/rnd/research/atmosia,
		/area/engineering/atmos/tank_storage,
		/area/medical/voxlab/lobby,
		/area/medical/voxlab/main,
		/area/medical/voxlab/storage,
		/area/medical/voxlab/breakroom,
		/area/medical/voxlab/chem,
		/area/medical/voxlab/surgery,
		/area/medical/voxlab/recov,
		/area/muriki/research/isolation_hall,
		/area/rnd/research/xenobio_storage,
		/area/rnd/xenobiology/burn,
		/area/server,
		/area/rnd/xenobiology/xenobiohstore,
		/area/comms,
		/area/tcomfoyer,
		/area/tcommsat/computer,
		/area/tcommsat/powercontrol,
		/area/medical/surgery,
		/area/medical/surgery2,
		/area/medical/medbay,
		/area/muriki/crew/kitchenfreezer,
		/area/security/tactical,
		/area/security/armoury,
		/area/muriki/cybstorage,
		/area/muriki/arriveelev,
		/area/rnd/entry,
		/area/rnd/entry_aux,
		/area/medical/sleevecheck,
		/area/rnd/stairwell,
		/area/muriki/crewstairwell,
		/area/rnd/hallway/phoronicsbridge,
		/area/teleporter/engineering,
		/area/security/nuke_storage,
		/area/muriki/tramstation/waste,
		/area/security/mechent,
		/area/engineering/engine_smes,
		/area/engineering/gravgen,
		/area/quartermaster/warehouse,
		/area/quartermaster/delivery,
		/area/quartermaster/mining,
		/area/quartermaster/mining/prep,
		/area/quartermaster/mining/expl,
		/area/quartermaster/mining/secpi,
		/area/ai_sat/atmos,
		/area/ai_sat/fore_airlock,
		/area/ai_sat/access_shaft,
		/area/ai_sat/docking_wing,
		/area/ai,
		/area/ai_upload,
		/area/ai_cyborg_station,
		/area/ai_upload_foyer,
		/area/ai_sat/fore_airlock,
		/area/ai_server_room
	)

	var/list/does_not_have_displays = list(
		/area/rnd/entry,
		/area/rnd/entry_aux,
		/area/rnd/research/phoronics,
		/area/engineering/refinery/tugstorage,
		/area/medical/medbay4,
		/area/muriki/research/isolation_hall,
		/area/rnd/hallway/hazard,
		/area/muriki/crewstairwell,
		/area/medical/medbay,
		/area/medical/stairwell,
		/area/rnd/stairwell,
		/area/hallway/secondary/chapel_hallway,
		/area/hallway/secondary/secmedbridge,
		/area/rnd/hallway/phoronicsbridge,
		/area/ai_sat/fore_airlock,
		/area/ai_sat/access_shaft,
		/area/ai_sat/docking_wing
	)

	// Lights always on, but not a hallway
	var/list/priority_work_area = list(
		// Medical stations
		/area/quartermaster/mining/firstaid,
		/area/rnd/research/phoronics/med,
		/area/rnd/research/medical,
		/area/rnd/research/medical_roof,
		/area/muriki/crew/dormaid,
		/area/muriki/crew/baraid,
		/area/muriki/crew/engyaid,
		/area/security/security_aid_station,
		/area/engineering/refinery/aid_station,
		/area/medical/first_aid_station_starboard,
		/area/medical/first_aid_station,
		// Tcomms
		/area/comms,
		/area/tcommsat/computer,
		/area/tcomfoyer,
		/area/tcommsat/lounge,
		/area/tcommsat/powercontrol,
		// Armory
		/area/security/armoury,
		/area/security/tactical,
		/area/security/nuke_storage,
		/area/security/brig,
		/area/security/surgery,
		// Medical
		/area/medical/sleeper,
		/area/medical/autosleever,
		/area/medical/reception,
		/area/muriki/tramstation,
		// Others
		/area/muriki/tramstation/civ,
		/area/muriki/tramstation/cargeng,
		/area/engineering/trammaint,
		/area/muriki/tramstation/waste,
		/area/engineering/gravgen,
		/area/wreck/bridge
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
			log_unit_test("[A.type] lacks a fire alarm")
			failures++
		// radio
		if(!(locate(/obj/item/radio/intercom) in A.contents))
			log_unit_test("[A.type] lacks an intercom")
			failures++
		// extinguishers
		if(!(locate(/obj/structure/extinguisher_cabinet) in A.contents))
			log_unit_test("[A.type] lacks a fire extinguisher")
			failures++
		// disposals
		if(!(locate(/obj/machinery/disposal) in A.contents))
			if(!(A.type in does_not_have_disposals))
				log_unit_test("[A.type] lacks a disposal bin")
				failures++

		// Hallways have some unique properties
		var/is_hallway = FALSE
		if(istype(A,/area/hallway))
			is_hallway = TRUE
		if(A.type in forced_hallway)
			is_hallway = TRUE
		// Some dumb exclusions
		if(A.type == /area/hallway/secondary/entry/docking_lounge)
			is_hallway = FALSE

		if(A.type in priority_work_area)
			// lightswitches forbidden in priority work areas
			if((locate(/obj/machinery/light_switch) in A.contents))
				log_unit_test("[A.type] had a lightswitch, but is a priority work area")
				failures++

		else if(!is_hallway)
			// lightswitches required in rooms
			if(!(A.type in does_not_use_lightswitch))
				if(!(locate(/obj/machinery/light_switch) in A.contents))
					log_unit_test("[A.type] lacks an lightswitch")
					failures++
		else
			// lightswitches forbidden in hallways
			if((locate(/obj/machinery/light_switch) in A.contents))
				log_unit_test("[A.type] had a lightswitch, but is a hallway")
				failures++
			// Hallways must have a geiger counter
			if(!(locate(/obj/item/geiger/wall) in A.contents))
				log_unit_test("[A.type] lacks an geiger counter")
				failures++
			// Hallways must status displays
			if(!(A.type in does_not_have_displays))
				if(!(locate(/obj/machinery/status_display) in A.contents))
					log_unit_test("[A.type] lacks an status display")
					failures++
				if(!(locate(/obj/machinery/ai_status_display) in A.contents))
					log_unit_test("[A.type] lacks an ai display")
					failures++

	if(failures)
		fail("[failures] areas fail outpost 21 buildcode.")
	else
		pass("All areas pass outpost 21 buildcode.")

	return 1
