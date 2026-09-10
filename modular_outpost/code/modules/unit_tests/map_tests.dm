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




/datum/unit_test/micro_tunnel_test

/datum/unit_test/micro_tunnel_test/Run()
	var/failed = FALSE

	var/list/seen_areas = list()
	for(var/obj/structure/micro_tunnel/H in world)
		var/area/A = get_area(H)
		if(A.type in seen_areas)
			TEST_NOTICE(src,"[H.x].[H.y].[H.z]: Map - [A] had more than one micro tunnel") // Micro tunnels have a list of areas by name, only a single tunnel can show up in the list per area.
			failed = TRUE
			continue
		seen_areas.Add(A.type)

	if(failed)
		TEST_FAIL("Multiple micro tunnels detected in a single area.")




/datum/unit_test/build_test_outpost

/datum/unit_test/build_test_outpost/Run()
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
		/area/offworld/orbital/exterior,
		/area/ai_sat/power_control,
		/area/security/brig_hole,
		/area/specialty/stowaway_clubhouse,
		/area/specialty/stowaway_clubhouse/upper,
		/area/specialty/expie_clubhouse,
		/area/specialty/expie_clubhouse/archive,
		/area/offworld/orbital/exterior/engine_core_port,
		/area/offworld/orbital/exterior/engine_core_starboard,
		/area/offworld/orbital/station/storage_engine_core,
		/area/ai_sat/solar_airlock,
		/area/offworld/orbital/station/solar_control,
		/area/offworld/orbital/station/port_airlock,
		/area/offworld/orbital/station/starboard_airlock,
		/area/offworld/orbital/station/dockingarm,
		/area/offworld/orbital/station/access_shaft,
		/area/offworld/orbital/station/south_power_airlock,
		/area/offworld/orbital/station/south_engine_access_west,
		/area/offworld/orbital/station/south_engine_access_east,
		/area/muriki/lowerelev,
		/area/muriki/lowerevac,
		/area/offworld/orbital/phoronics/burn_chamber,
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
		/area/offworld/orbital/station/halls/lower/aft,
		/area/offworld/orbital/station/halls/lower/central,
		/area/offworld/orbital/station/halls/stairs_lower,
		/area/offworld/orbital/station/halls/lower/fore,
		/area/offworld/orbital/station/halls/rust_entry,
		/area/offworld/orbital/station/halls/rust_tool_storage,
		/area/offworld/orbital/station/halls/aft,
		/area/offworld/orbital/station/halls/stairs_upper,
		/area/offworld/orbital/station/halls/central,
		/area/offworld/orbital/station/halls/starboard,
		/area/offworld/orbital/station/halls/fore,
		/area/offworld/orbital/station/halls/lower/port
	)

	var/list/does_not_use_lightswitch = list(
		/area/muriki/arriveelev,
		/area/rnd/entry,
		/area/rnd/entry_aux,
		/area/rnd/research/roof_eva,
		/area/muriki/cybstorage,
		/area/muriki/crew/bunker,
		/area/offworld/orbital/station/ai_transit_hub,
		/area/muriki/crew/bunker_deep/eng,
		/area/muriki/crew/bunker_deep/main,
		/area/muriki/crew/bunker_deep/comm,
		/area/muriki/crew/bunker_deep/med,
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
		/area/muriki/crew/bunker_deep,
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
		/area/security/tactical/red,
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
		/area/ai_server_room,
		/area/quartermaster/mining/ore_silo,
		/area/medical/psych,
		/area/offworld/orbital/station/aux_equipment,
		/area/offworld/orbital/station/rust_backup_power,
		/area/offworld/orbital/station/rust_aux_tool_storage,
		/area/offworld/orbital/station/dockinghanger,
		/area/offworld/orbital/station/teleport,
		/area/offworld/orbital/station/telecomms,
		/area/offworld/orbital/station/security/holding_cell,
		/area/offworld/orbital/station/security/lockup,
		/area/offworld/orbital/station/security/armory,
		/area/offworld/orbital/station/halls/rust_tool_storage,
		/area/muriki/crew/bunker_deep/eng,
		/area/muriki/crew/bunker_deep/main,
		/area/muriki/crew/bunker_deep/comm,
		/area/muriki/crew/bunker_deep/med,
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
		/area/offworld/orbital/station/medical_treatment,
		/area/offworld/orbital/station/lower_medical_treatment,
		// Tcomms
		/area/comms,
		/area/tcommsat/computer,
		/area/tcomfoyer,
		/area/tcommsat/lounge,
		/area/tcommsat/powercontrol,
		/area/offworld/orbital/station/telecomms,
		// Armory
		/area/security/armoury,
		/area/security/tactical,
		/area/security/tactical/red,
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
		/area/wreck/bridge,
		/area/offworld/orbital/station/rust_core,
		/area/offworld/orbital/station/teleport,
		/area/offworld/orbital/station/security/armory,
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
			TEST_NOTICE(src,"[A.type] lacks a fire alarm")
			failures++
		// radio
		if(!(locate(/obj/item/radio/intercom) in A.contents))
			TEST_NOTICE(src,"[A.type] lacks an intercom")
			failures++
		// extinguishers
		if(!(locate(/obj/structure/extinguisher_cabinet) in A.contents))
			TEST_NOTICE(src,"[A.type] lacks a fire extinguisher")
			failures++
		// disposals
		if(!(locate(/obj/machinery/disposal) in A.contents))
			if(!(A.type in does_not_have_disposals))
				TEST_NOTICE(src,"[A.type] lacks a disposal bin")
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
				TEST_NOTICE(src,"[A.type] had a lightswitch, but is a priority work area")
				failures++
			else
				if(!A.lightswitch)
					TEST_NOTICE(src,"[A.type] is a priority work area, but had default lightswitch state as off. It can never be turned on!")
					failures++

		else if(!is_hallway)
			// lightswitches required in rooms
			if(!(A.type in does_not_use_lightswitch))
				if(!(locate(/obj/machinery/light_switch) in A.contents))
					TEST_NOTICE(src,"[A.type] lacks an lightswitch")
					failures++
		else
			// Area light must be on
			if(!A.lightswitch)
				TEST_NOTICE(src,"[A.type] is a hallway, but had default lightswitch state as off. It can never be turned on!")
				failures++
			// lightswitches forbidden in hallways
			if((locate(/obj/machinery/light_switch) in A.contents))
				TEST_NOTICE(src,"[A.type] had a lightswitch, but is a hallway")
				failures++
			// Hallways must have a geiger counter
			if(!(locate(/obj/item/geiger/wall) in A.contents))
				TEST_NOTICE(src,"[A.type] lacks an geiger counter")
				failures++
			// Hallways must status displays
			if(!(A.type in does_not_have_displays))
				if(!(locate(/obj/machinery/status_display) in A.contents))
					TEST_NOTICE(src,"[A.type] lacks an status display")
					failures++
				if(!(locate(/obj/machinery/ai_status_display) in A.contents))
					TEST_NOTICE(src,"[A.type] lacks an ai display")
					failures++

	if(failures)
		TEST_FAIL("areas fail outpost 21 buildcode.")


/datum/unit_test/pipes_and_wires_may_not_be_under_walls

/datum/unit_test/pipes_and_wires_may_not_be_under_walls/Run()
	set background=1

	var/failures = 0

	for(var/obj/structure/disposalpipe/P in world)
		var/area/A = get_area(P)
		if(!A)
			continue
		var/turf/T = get_turf(P)
		if(!istype(A,/area/shuttle) && iswall(T))
			TEST_NOTICE(src,"[T.x].[T.y].[T.z] - [A]: a disposal pipe runs under a wall.")
			failures++

	for(var/obj/machinery/atmospherics/pipe/P in world)
		var/area/A = get_area(P)
		if(!A)
			continue
		if(A.type == /area/maintenance/incinerator || A.type == /area/rnd/research/phoronics/burn || A.type == /area/offworld/orbital/phoronics/burn_chamber) // Exempt
			continue
		var/turf/T = get_turf(P)
		if(!istype(A,/area/shuttle) && iswall(T))
			TEST_NOTICE(src,"[T.x].[T.y].[T.z] - [A]: an atmos pipe runs under a wall.")
			failures++

	for(var/obj/structure/cable/C in world)
		var/area/A = get_area(C)
		if(!A)
			continue
		var/turf/T = get_turf(C)
		if(!istype(A,/area/shuttle) && iswall(T))
			TEST_NOTICE(src,"[T.x].[T.y].[T.z] - [A]: a wire runs under a wall.")
			failures++

	if(failures)
		TEST_FAIL("pipes or wires run under walls. Use maintenance panels.")




/datum/unit_test/all_cliffs_shall_be_placed_on_floors

/datum/unit_test/all_cliffs_shall_be_placed_on_floors/Run()
	var/failed = FALSE

	for(var/obj/structure/cliff/C in world)
		var/turf/T = get_turf(C)
		var/area/A = get_area(C)
		if(isopenspace(T))
			TEST_NOTICE(src,"[T.x].[T.y].[T.z] [A]: Cliff - Cliff placed on openspace")
			failed = TRUE
		if(iswall(T))
			TEST_NOTICE(src,"[T.x].[T.y].[T.z] [A]: Cliff - Cliff placed on wall")
			failed = TRUE

	if(failed)
		TEST_FAIL("Cliffs illegally placed. Cliffs may not be placed on walls, or open space")


/datum/unit_test/all_cameras_shall_respect_naming_conventions

/datum/unit_test/all_cameras_shall_respect_naming_conventions/Run()
	var/failed = FALSE
	var/list/used_cams = list()

	for(var/obj/machinery/camera/network/command/C in world)
		set background=1
		if(!validate_camera(C, "COM", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/ai_sat/C in world)
		set background=1
		if(!validate_camera(C, "AI", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/research/C in world)
		set background=1
		if(!validate_camera(C, "SCI", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/research_outpost/C in world)
		set background=1
		if(!validate_camera(C, "TOX", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/medbay/C in world)
		set background=1
		if(!validate_camera(C, "MED", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/security/C in world)
		set background=1
		if(!validate_camera(C, "SEC", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/prison/C in world)
		set background=1
		if(!validate_camera(C, "SEC", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/civilian/C in world)
		set background=1
		if(!validate_camera(C, "CIV", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/cargo/C in world)
		set background=1
		if(!validate_camera(C, "CRG", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/mining/C in world)
		set background=1
		if(!validate_camera(C, "MNE", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/engineering/C in world)
		set background=1
		if(!validate_camera(C, "ENG", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/engineering_outpost/C in world)
		set background=1
		if(!validate_camera(C, "REX", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/engine/C in world)
		set background=1
		if(!validate_camera(C, "ENG", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/substations/C in world)
		set background=1
		if(!validate_camera(C, "PWR", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/outside/C in world)
		set background=1
		if(!validate_camera(C, "EXT", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/bunker/C in world)
		set background=1
		if(!validate_camera(C, "BNK", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/foundations/C in world)
		set background=1
		if(!validate_camera(C, "BLK", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/telecom/C in world)
		set background=1
		if(!validate_camera(C, "TCM", used_cams))
			failed = TRUE

	for(var/obj/machinery/camera/network/waste/C in world)
		set background=1
		if(!validate_camera(C, "WST", used_cams))
			failed = TRUE

	if(failed)
		TEST_FAIL("Cameras had incorrect prefix for their network")

/datum/unit_test/all_cameras_shall_respect_naming_conventions/proc/validate_camera(obj/machinery/camera/C, req_suffix, list/used_cams)
	var/turf/T = get_turf(C)
	var/area/A = get_area(C)
	if(!C.c_tag)
		TEST_NOTICE(src, "Camera had null c_tag. Located at [T.x].[T.y].[T.z] : [A]")
		return FALSE
	if(C.c_tag in used_cams)
		TEST_NOTICE(src, "Camera had already existing c_tag [C.c_tag]. Located at [T.x].[T.y].[T.z] : [A]")
		for(var/obj/machinery/camera/X in world)
			if(X == C)
				continue
			if(C.c_tag == X.c_tag)
				T = get_turf(X)
				A = get_area(X)
				TEST_NOTICE(src, "Other Camera(s) located at [T.x].[T.y].[T.z] : [A]")
		return FALSE
	if(copytext(C.c_tag,1,length(req_suffix) + 4) != "[req_suffix] - ")
		TEST_NOTICE(src, "Camera had incorrect c_tag for [req_suffix] prefix area. was tagged [C.c_tag]. Located at [T.x].[T.y].[T.z] : [A]")
		return FALSE
	used_cams += list(C.c_tag)
	return TRUE


/datum/unit_test/all_airlock_controllers_shall_have_unique_ids

/datum/unit_test/all_airlock_controllers_shall_have_unique_ids/Run()
	var/failed = FALSE

	var/list/used_tags = list()
	for(var/obj/machinery/embedded_controller/radio/airlock/controller in world)
		var/turf/T = get_turf(controller)
		var/area/A = get_area(controller)
		if(!controller.id_tag)
			failed = TRUE
			TEST_NOTICE(src, "Airlock controller was missing an id_tag. Located at [T.x].[T.y].[T.z] : [A]")
			continue
		if(controller.id_tag in used_tags)
			failed = TRUE
			TEST_NOTICE(src, "Airlock controller id_tag \"[controller.id_tag]\" was already in use. Located at [T.x].[T.y].[T.z] : [A]")
			continue
		used_tags += controller.id_tag

	if(failed)
		TEST_FAIL("One or more airlock controllers had an incorrect id_tag set")




/datum/unit_test/all_tele_beacons_must_be_unique

/datum/unit_test/all_tele_beacons_must_be_unique/Run()
	var/failed = FALSE

	var/list/used_tags = list()
	for(var/obj/item/perfect_tele_beacon/beacon in world)
		var/turf/T = get_turf(beacon)
		var/area/A = get_area(beacon)
		if(!beacon.tele_name)
			failed = TRUE
			TEST_NOTICE(src, "Telebeacon not assigned a tele_name. Located at [T.x].[T.y].[T.z] : [A]")
			continue
		if(beacon.tele_name in used_tags)
			failed = TRUE
			TEST_NOTICE(src, "Telebeacon already in use [beacon.tele_name]. Located at [T.x].[T.y].[T.z] : [A]")
			continue
		used_tags += beacon.tele_name

	for(var/obj/item/perfect_tele_beacon/stationary/beacon in world)
		var/turf/T = get_turf(beacon)
		var/area/A = get_area(beacon)
		if(beacon.tele_network == null)
			failed = TRUE
			TEST_NOTICE(src, "Telebeacon has no assigned tele_network. Located at [T.x].[T.y].[T.z] : [A]")
			continue

	if(failed)
		TEST_FAIL("One or more tele_beacon objects are incorrectly setup or are duplicates")




/datum/unit_test/things_should_not_be_in_walls

/datum/unit_test/things_should_not_be_in_walls/Run()
	set background=1

	var/failed = FALSE

	for(var/obj/machinery/light/L in world)
		if(is_in_wall(L))
			failed = TRUE
	for(var/obj/machinery/door/D in world)
		if(is_in_wall(D))
			failed = TRUE
		if(is_in_space(D))
			failed = TRUE
	for(var/obj/structure/railing/R in world)
		if(is_in_wall(R))
			failed = TRUE

	if(failed)
		TEST_FAIL("One or more objects are inside a dense turf wall.")

/datum/unit_test/things_should_not_be_in_walls/proc/is_in_wall(obj/structure/thing)
	var/turf/T = get_turf(thing)
	if(!T)
		return FALSE; // What?
	if(!T.density)
		return
	TEST_NOTICE(src, "[thing] was inside a dense wall. Located at [T.x].[T.y].[T.z] : [get_area(thing)]")
	return TRUE;

/datum/unit_test/things_should_not_be_in_walls/proc/is_in_space(obj/structure/thing)
	var/turf/T = get_turf(thing)
	if(!isspace(T))
		return FALSE;
	TEST_NOTICE(src, "[thing] was placed on space turf. Located at [T.x].[T.y].[T.z] : [get_area(thing)]")
	return TRUE



/datum/unit_test/wall_lights_must_have_supports

/datum/unit_test/wall_lights_must_have_supports/Run()
	set background=1

	var/failed = FALSE

	for(var/obj/machinery/light/L in world)
		// Ignore elevators
		var/area/ar = get_area(L)
		if(istype(ar,/area/turbolift))
			continue

		// Lights that don't need support
		if(istype(L,/obj/machinery/light/flamp))
			continue
		if(istype(L,/obj/machinery/light/bigfloorlamp))
			continue
		if(istype(L,/obj/machinery/light/floortube))
			continue
		if(istype(L,/obj/machinery/light/small/fairylights))
			continue
		if(istype(L,/obj/machinery/light/lamppost))
			continue
		if(istype(L,/obj/machinery/light/spot))
			continue

		// Check for a dense wall first
		var/turf/get_wall = get_step(L, L.dir)
		if(get_wall.density)
			continue

		// Fallback and see if other things are supporting it
		var/had_other_support = FALSE
		for(var/obj/structure/window/find_win in get_wall.contents) // windows
			if(find_win.fulltile) // Allows on full windows too
				had_other_support = TRUE
				break
			if(find_win.dir == reverse_direction(L.dir)) // Allowed on windows and maint panels too
				had_other_support = TRUE
				break

		if(!had_other_support)
			TEST_NOTICE(src, "[L] was placed without a support wall. Located on \the [get_turf(L)] [L.x].[L.y].[L.z] : [ar]")
			failed = TRUE

	if(failed)
		TEST_FAIL("One or more lights is floating without a wall.")
