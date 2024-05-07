//Outpost map defs
#define Z_LEVEL_OUTPOST_BASEMENT					1
#define Z_LEVEL_OUTPOST_SURFACE						2
#define Z_LEVEL_OUTPOST_UPPER						3
#define Z_LEVEL_OUTPOST_CENTCOM						4
#define Z_LEVEL_OUTPOST_MISC 						5
#define Z_LEVEL_OUTPOST_ASTEROID 					6
#define Z_LEVEL_OUTPOST_VR		 					7
//Ensure these stay updated with map and z-level changes - Ignus
/datum/map/outpost
	name = "Outpost 21"
	full_name = "ESHUI Atmospheric Terraforming Outpost 21"
	path = "outpost"

	lobby_icon = 'icons/misc/title_op.dmi'
	lobby_screens = list()

	zlevel_datum_type = /datum/map_z_level/outpost

	use_overmap = TRUE
	overmap_z = Z_LEVEL_OUTPOST_MISC
	overmap_size = 25
	overmap_event_areas = 9

	holomap_smoosh = list(list(
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER))

	station_name  = "ESHUI Atmospheric Terraforming Outpost 21"
	station_short = "Outpost 21"
	dock_name     = "Central Command Bunker"
	boss_name     = "Central Command"
	boss_short    = "CentCom"
	company_name  = "ESHUI"
	company_short = "ES"
	starsys_name  = "SL-340"

	shuttle_docked_message = "The scheduled elevator to the %dock_name% has arrived at the station. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The crew transfer elevator has left the station. Estimate %ETA% until the elevator arrives at the %dock_name%."
	shuttle_called_message = "A crew transfer to the %dock_name% has been scheduled. The elevator has been called. Those leaving should proceed to departure bay in approximately %ETA%."
	shuttle_recall_message = "The scheduled crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The emergency bunker elevator has arrived at the station. You have approximately %ETD% to board the bunker elevator."
	emergency_shuttle_leaving_dock = "The emergency elevator has left the station. Estimate %ETA% until it arrives at the %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation elevator has been called. It will arrive at the departure bay in approximately %ETA%."
	emergency_shuttle_recall_message = "The emergency elevator has been recalled."

	unit_test_z_levels = list(Z_LEVEL_OUTPOST_BASEMENT,Z_LEVEL_OUTPOST_SURFACE,Z_LEVEL_OUTPOST_UPPER,Z_LEVEL_OUTPOST_ASTEROID)

	station_networks = list(
							NETWORK_CARGO,
							NETWORK_CIVILIAN,
							NETWORK_COMMAND,
							NETWORK_ENGINE,
							NETWORK_ENGINEERING,
							NETWORK_DEFAULT,
							NETWORK_MEDICAL,
							NETWORK_RESEARCH,
							NETWORK_RESEARCH_OUTPOST,
							NETWORK_ROBOTS,
							NETWORK_PRISON,
							NETWORK_SECURITY,
							NETWORK_INTERROGATION
							)

	secondary_networks = list(
							NETWORK_ERT,
							NETWORK_MERCENARY,
							NETWORK_THUNDER,
							NETWORK_COMMUNICATORS,
							NETWORK_ALARM_ATMOS,
							NETWORK_ALARM_POWER,
							NETWORK_ALARM_FIRE
							)

	allowed_spawns = list("Elevator", "Cyborg Storage")

	ai_shell_restricted = TRUE
	ai_shell_allowed_levels = list(
		Z_LEVEL_OUTPOST_CENTCOM,
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER
		)

	planet_datums_to_make = list(/datum/planet/muriki)

/datum/map/outpost/perform_map_generation()
	seed_submaps(list(Z_LEVEL_OUTPOST_ASTEROID), 180, /area/offworld/asteroidyard/external/yardzone, /datum/map_template/outpost21/space/orbitalyard_huge, 100, 20, 370, 150)
	seed_submaps(list(Z_LEVEL_OUTPOST_ASTEROID), 90, /area/offworld/asteroidyard/external/yardzone, /datum/map_template/outpost21/space/orbitalyard, 100, 20, 370, 150)

	seed_submaps(list(Z_LEVEL_OUTPOST_SURFACE), 150, /area/muriki/yard, /datum/map_template/outpost21/muriki/cargoyard_huge, 60, 15, 150, 60)
	seed_submaps(list(Z_LEVEL_OUTPOST_SURFACE), 200, /area/muriki/yard, /datum/map_template/outpost21/muriki/cargoyard, 60, 15, 150, 60)

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_BASEMENT) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_BASEMENT, 64, 64)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_SURFACE) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_SURFACE, 64, 64)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_UPPER) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_UPPER, 64, 64)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1,  Z_LEVEL_OUTPOST_ASTEROID) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_ASTEROID, 64, 64)         // Create the mining ore distribution map.
	return 1

/datum/planet/muriki
	expected_z_levels = list(
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER
	)


// Overmap represetation of muriki
/obj/effect/overmap/visitable/sector/muriki
	name = "Muriki"
	desc = "What a terrible place to call home."
	scanner_desc = @{"[i]Registration[/i]: ES Outpost 21-00
[i]Class[/i]: Planetary Installation
[i]Transponder[/i]: Transmitting (CIV), ESHUI IFF
[b]Notice[/b]: ESHUI Terraforming Outpost, authorized personnel only"}

	base = TRUE
	icon_state = "globe"
	color = "#7be313"
	initial_generic_waypoints = list("outpost_landing_pad","outpost_engineering_pad")
	initial_restricted_waypoints = list( "Mining Trawler" = list("outpost_trawler_pad"), "Security Carrier" = list("outpost_security_hangar"), "Medical Rescue" = list("outpost_medical_hangar"))
	//Despite not being in the multi-z complex, these levels are part of the overmap sector
	extra_z_levels = list()

/obj/effect/overmap/visitable/sector/muriki/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/muriki/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/muriki/proc/announce_atc(var/atom/movable/AM, var/going = FALSE)
	var/message = "Sensor contact for vessel '[AM.name]' has [going ? "left" : "entered"] ATC control area."
	//For landables, we need to see if their shuttle is cloaked
	if(istype(AM, /obj/effect/overmap/visitable/ship/landable))
		var/obj/effect/overmap/visitable/ship/landable/SL = AM //Phew
		var/datum/shuttle/autodock/multi/shuttle = SSshuttles.shuttles[SL.shuttle]
		if(!istype(shuttle) || !shuttle.cloaked) //Not a multishuttle (the only kind that can cloak) or not cloaked
			atc.msg(message)

	//For ships, it's safe to assume they're big enough to not be sneaky
	else if(istype(AM, /obj/effect/overmap/visitable/ship))
		atc.msg(message)

/obj/effect/overmap/visitable/sector/muriki/get_space_zlevels()
	return list() //None!



/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard
	initial_generic_waypoints = list("orbitalyard_civ","orbitalyard_north","orbitalyard_south","orbitalyard_east","orbitalyard_west")
	initial_restricted_waypoints = list("Mining Trawler" = list("trawler_yard"))
	name = "Orbital Reclamation Yard"
	scanner_desc = @{"[i]Registration[/i]: ES Orbital 21-03
[i]Class[/i]: Installation
[i]Transponder[/i]: Transmitting (CIV), ESHUI IFF
[b]Notice[/b]: ESHUI Base, authorized personnel only"}
	map_z = list(Z_LEVEL_OUTPOST_ASTEROID)
	extra_z_levels = list()

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/proc/announce_atc(var/atom/movable/AM, var/going = FALSE)
	var/message = "Sensor contact for vessel '[AM.name]' has [going ? "left" : "entered"] ATC control area."
	//For landables, we need to see if their shuttle is cloaked
	if(istype(AM, /obj/effect/overmap/visitable/ship/landable))
		var/obj/effect/overmap/visitable/ship/landable/SL = AM //Phew
		var/datum/shuttle/autodock/multi/shuttle = SSshuttles.shuttles[SL.shuttle]
		if(!istype(shuttle) || !shuttle.cloaked) //Not a multishuttle (the only kind that can cloak) or not cloaked
			atc.msg(message)

	//For ships, it's safe to assume they're big enough to not be sneaky
	else if(istype(AM, /obj/effect/overmap/visitable/ship))
		atc.msg(message)

/obj/effect/overmap/visitable/sector/murkiki_space/orbital_yard/get_space_zlevels()
	return list(Z_LEVEL_OUTPOST_ASTEROID)









// For making the 6-in-1 holomap, we calculate some offsets
#define OUTPOST21_MAP_SIZEX 400
#define OUTPOST21_MAP_SIZEY 160
#define OUTPOST21_HOLOMAP_MARGIN_X (HOLOMAP_ICON_SIZE - (2*OUTPOST21_MAP_SIZEX))
#define OUTPOST21_HOLOMAP_MARGIN_Y (HOLOMAP_ICON_SIZE - (2*OUTPOST21_MAP_SIZEY))

/datum/map_z_level/outpost/centcom
	z = Z_LEVEL_OUTPOST_CENTCOM
	name = "CentCom"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED
	base_turf = /turf/simulated/open //TODO: Set to lava when I remember the damn object path

/datum/map_z_level/outpost/basement
	z = Z_LEVEL_OUTPOST_BASEMENT
	name = "Basement"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_BELOW_BLOCKED|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * 20) - 32 // hidden
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/main
	z = Z_LEVEL_OUTPOST_SURFACE
	name = "Main"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * -0.55)
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/upper
	z = Z_LEVEL_OUTPOST_UPPER
	name = "Upper"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * 0.88)
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/misc
	z = Z_LEVEL_OUTPOST_MISC
	name = "Misc"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED

/datum/map_z_level/outpost/asteroid_mine
	z = Z_LEVEL_OUTPOST_ASTEROID
	name = "Asteroid"
	transit_chance = 100 // temp just loop through space
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_PERSIST|MAP_LEVEL_BELOW_BLOCKED|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS

/datum/map_z_level/outpost/misc
	z = Z_LEVEL_OUTPOST_VR
	name = "Virtual"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED


//Unit test stuff.

/datum/unit_test/zas_area_test/supply_centcomm
	name = "ZAS: Supply Shuttle (CentCom)"
	area_path = /area/supply/dock

/datum/unit_test/zas_area_test/emergency_shuttle
	name = "ZAS: Emergency Elevator"
	area_path = /area/shuttle/escape/centcom

/datum/unit_test/zas_area_test/ai_chamber
	name = "ZAS: AI Chamber"
	area_path = /area/ai

/datum/unit_test/zas_area_test/cargo_maint
	name = "ZAS: Cargo Maintenance"
	area_path = /area/maintenance/cargo

/datum/unit_test/zas_area_test/virology
	name = "ZAS: Virology"
	area_path = /area/medical/virology

/datum/unit_test/zas_area_test/xenobio
	name = "ZAS: Xenobiology"
	area_path = /area/rnd/xenobiology
/*
/datum/unit_test/zas_area_test/mining_area
	name = "ZAS: Mining Area (Vacuum)"
	area_path = /area/mine/explored
	expectation = UT_VACUUM
*/
/datum/unit_test/zas_area_test/cargo_bay
	name = "ZAS: Cargo Bay"
	area_path = /area/quartermaster/storage
