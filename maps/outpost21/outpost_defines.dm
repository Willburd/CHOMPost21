//Outpost map defs
#define Z_LEVEL_OUTPOST_DEEPDARK					1
#define Z_LEVEL_OUTPOST_BASEMENT					2
#define Z_LEVEL_OUTPOST_SURFACE						3
#define Z_LEVEL_OUTPOST_UPPER						4
#define Z_LEVEL_OUTPOST_CENTCOM						5
#define Z_LEVEL_OUTPOST_MISC 						6
#define Z_LEVEL_OUTPOST_ASTEROID 					7
//efine Z_LEVEL_OUTPOST_PROSPECTOR 					8
//efine Z_LEVEL_OUTPOST_SURVEY	 					9
#define Z_LEVEL_OUTPOST_VR		 					8
#define Z_LEVEL_OUTPOST_CONFINEMENTBEAM				9
//Ensure these stay updated with map and z-level changes - Ignus
/datum/map/outpost
	name = "Outpost 21"
	full_name = "ESHUI Atmospheric Terraforming Outpost 21"
	path = "outpost"

	lobby_icon = 'icons/misc/OUTPOST21.gif'
	lobby_screens = list()
	id_hud_icons = 'icons/mob/hud_jobs_vr.dmi'

	default_law_type = /datum/ai_laws/eshui_standard

	holomap_smoosh = list(list(
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER))

	zlevel_datum_type = /datum/map_z_level/outpost

	station_name  = "ESHUI Atmospheric Terraforming Outpost 21"
	station_short = "Outpost 21"
	dock_name     = "Central Command Bunker"
	boss_name     = "Central Command"
	boss_short    = "CentCom"
	company_name  = "ESHUI"
	company_short = "ES"
	starsys_name  = "SL-340"
	use_overmap = TRUE
	overmap_size = 25
	overmap_event_areas = 9

	shuttle_docked_message = "The scheduled elevator to the %dock_name% has arrived at the station. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The crew transfer elevator has left the station. Estimate %ETA% until the elevator arrives at the %dock_name%."
	shuttle_called_message = "A crew transfer to the %dock_name% has been scheduled. The elevator has been called. Those leaving should proceed to departure bay in approximately %ETA%."
	shuttle_recall_message = "The scheduled crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The emergency bunker elevator has arrived at the station. You have approximately %ETD% to board the bunker elevator."
	emergency_shuttle_leaving_dock = "The emergency elevator has left the station. Estimate %ETA% until it arrives at the %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation elevator has been called. It will arrive at the departure bay in approximately %ETA%."
	emergency_shuttle_recall_message = "The emergency elevator has been recalled."

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
							NETWORK_INTERROGATION,
							NETWORK_OUTSIDE
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
	usable_email_tlds = list("internalmail.es")
	allowed_spawns = list("Elevator", "Cryogenic Storage", "Cyborg Storage", "On-Site Dorms")
	default_skybox = /datum/skybox_settings/outpost21
	unit_test_z_levels = list(Z_LEVEL_OUTPOST_DEEPDARK,Z_LEVEL_OUTPOST_BASEMENT,Z_LEVEL_OUTPOST_SURFACE,Z_LEVEL_OUTPOST_UPPER,Z_LEVEL_OUTPOST_ASTEROID,Z_LEVEL_OUTPOST_CONFINEMENTBEAM)
	unit_test_exempt_areas = list()
	unit_test_exempt_from_atmos = list(	/area/muriki/processor,
										/area/muriki/processor/hall,
										/area/muriki/processor/gland/airmix,
										/area/muriki/processor/gland/space,
										/area/muriki/processor/hall/waterway_low,
										/area/muriki/processor/pools/gizzard,
										/area/muriki/processor/pools/eastfund,
										/area/muriki/processor/euth,
										/area/muriki/processor/gland/phoron,
										/area/muriki/processor/pools/cropbig,
										/area/muriki/processor/pools/crop,
										/area/muriki/processor/hall/waterway_upper,
										/area/muriki/processor/gland/co2,
										/area/muriki/processor/pools/antrum,
										/area/muriki/processor/hall/waterway_other,
										/area/muriki/processor/pools/pylorus,
										/area/muriki/processor/gland/nitrogen,
										// Skylines don't need scrubbers and vents
										/area/muriki/skyline/east,
										/area/muriki/skyline/south,
										/area/muriki/skyline/west,
										/area/muriki/skyline/cent,
										/area/muriki/skyline/north,
										// Generator rooms are maint areas
										/area/muriki/rooftop/medgen,
										/area/muriki/rooftop/secgen,
										/area/muriki/rooftop/comgen,
										/area/muriki/rooftop/cargen,
										/area/muriki/rooftop/scigen,
										/area/muriki/rooftop/civgen,
										// The outside areas don't need scrubbers and vents
										/area/muriki/grounds,
										/area/muriki/grounds/shutt,
										/area/muriki/grounds/sec,
										/area/muriki/grounds/waste,
										/area/muriki/grounds/engi,
										/area/muriki/grounds/civ,
										/area/muriki/grounds/med,
										/area/muriki/grounds/sci,
										/area/muriki/grounds/graveyard,
										/area/muriki/grounds/terraform,
										/area/muriki/grounds/tramborder,
										/area/muriki/grounds/tramlinewest,
										/area/muriki/grounds/tramlineeast,
										/area/muriki/yard,
										/area/muriki/station/trawler_dock,
										// The roof areas don't need scrubbers and vents
										/area/muriki/rooftop,
										/area/muriki/rooftop/disposal,
										/area/muriki/rooftop/cargo,
										/area/muriki/rooftop/civilian,
										/area/muriki/rooftop/medical,
										/area/muriki/rooftop/science,
										// The elevators don't need scrubbers and vents
										/area/muriki/elevator,
										/area/muriki/elevator/secbase,
										/area/muriki/elevator/medibasement,
										/area/muriki/elevator/civbase,
										/area/muriki/elevator/scibase,
										/area/muriki/elevator/secmain,
										/area/muriki/elevator/medical,
										/area/muriki/elevator/civmain,
										/area/muriki/elevator/scimain,
										/area/muriki/elevator/secupper,
										/area/muriki/elevator/mediupper,
										/area/muriki/elevator/civupper,
										/area/muriki/elevator/sciupper,
										// The asteroid yard's exterior does not need scrubbers and vents
										/area/offworld/asteroidyard/external,
										/area/offworld/asteroidyard/external/yardzone,
										/area/offworld/confinementbeam/exterior,
										// Actual unit test exceptions
										/area/comms,
										/area/muriki/tramstation/waste,
										/area/engineering/engine_airlock,
										/area/engineering/engine_room,
										/area/muriki/lowerelev,
										/area/muriki/lowerevac,
										/area/muriki/crystal,
										/area/engineering/gravgen,
										/area/muriki/septic,
										/area/medical/voxlab/airgap,
										/area/rnd/xenobiology/lost,
										/area/maintenance/damaged_resleeverA,
										/area/maintenance/damaged_resleeverB)
	unit_test_exempt_from_apc = list(	/area/muriki/processor,
										/area/muriki/processor/hall,
										/area/muriki/processor/gland/airmix,
										/area/muriki/processor/gland/space,
										/area/muriki/processor/hall/waterway_low,
										/area/muriki/processor/pools/gizzard,
										/area/muriki/processor/pools/eastfund,
										/area/muriki/processor/euth,
										/area/muriki/processor/gland/phoron,
										/area/muriki/processor/pools/cropbig,
										/area/muriki/processor/pools/crop,
										/area/muriki/processor/hall/waterway_upper,
										/area/muriki/processor/gland/co2,
										/area/muriki/processor/pools/antrum,
										/area/muriki/processor/hall/waterway_other,
										/area/muriki/processor/pools/pylorus,
										/area/muriki/processor/gland/nitrogen,
										// Skylines don't need apcs
										/area/muriki/skyline/east,
										/area/muriki/skyline/south,
										/area/muriki/skyline/west,
										/area/muriki/skyline/cent,
										/area/muriki/skyline/north,
										// The outside areas don't need apcs
										/area/muriki/grounds,
										/area/muriki/grounds/shutt,
										/area/muriki/grounds/sec,
										/area/muriki/grounds/waste,
										/area/muriki/grounds/engi,
										/area/muriki/grounds/civ,
										/area/muriki/grounds/med,
										/area/muriki/grounds/sci,
										/area/muriki/grounds/graveyard,
										/area/muriki/grounds/terraform,
										/area/muriki/grounds/tramborder,
										/area/muriki/grounds/tramlinewest,
										/area/muriki/grounds/tramlineeast,
										/area/muriki/yard,
										/area/muriki/station/trawler_dock,
										// The elevators don't need apcs
										/area/muriki/elevator,
										/area/muriki/elevator/secbase,
										/area/muriki/elevator/medibasement,
										// The asteroid yard's exterior does not need apcs
										/area/offworld/asteroidyard/external,
										/area/offworld/asteroidyard/external/yardzone,
										// Actual unit test exceptions
										/area/muriki/lowerelev,
										/area/muriki/lowerevac,
										/area/muriki/crystal,
										/area/maintenance/damaged_resleeverA,
										/area/maintenance/damaged_resleeverB)

	planet_datums_to_make = list(/datum/planet/muriki)

	overmap_z = Z_LEVEL_OUTPOST_MISC
	map_levels = list(
			Z_LEVEL_OUTPOST_DEEPDARK,
			Z_LEVEL_OUTPOST_BASEMENT,
			Z_LEVEL_OUTPOST_SURFACE,
			Z_LEVEL_OUTPOST_UPPER,
			Z_LEVEL_OUTPOST_ASTEROID,
			Z_LEVEL_OUTPOST_CONFINEMENTBEAM
		)

	ai_shell_restricted = TRUE
	ai_shell_allowed_levels = list(
		Z_LEVEL_OUTPOST_CENTCOM,
		Z_LEVEL_OUTPOST_DEEPDARK,
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER,
		Z_LEVEL_OUTPOST_CONFINEMENTBEAM
		)

	confinement_beam_z_levels = list(
		Z_LEVEL_OUTPOST_DEEPDARK,
		Z_LEVEL_OUTPOST_BASEMENT,
		Z_LEVEL_OUTPOST_SURFACE,
		Z_LEVEL_OUTPOST_UPPER
	)

	station_uses_common_ore_only = TRUE
	common_ores = list(ORE_MARBLE = 8, ORE_QUARTZ = 10, ORE_COPPER = 20, ORE_TIN = 15, ORE_BAUXITE = 15, ORE_URANIUM = 5, ORE_PLATINUM = 6, ORE_HEMATITE = 70, ORE_RUTILE = 15, ORE_CARBON = 70, ORE_DIAMOND = 1, ORE_GOLD = 6, ORE_SILVER = 5, ORE_PHORON = 1, ORE_LEAD = 35, ORE_VOPAL = 1, ORE_VERDANTIUM = 1, ORE_PAINITE = 1)
	rare_ores = list(ORE_MARBLE = 5, ORE_QUARTZ = 15, ORE_COPPER = 10, ORE_TIN = 5, ORE_BAUXITE = 5, ORE_URANIUM = 25, ORE_PLATINUM = 25, ORE_HEMATITE = 15, ORE_RUTILE = 20, ORE_CARBON = 25, ORE_DIAMOND = 8, ORE_GOLD = 25, ORE_SILVER = 10, ORE_PHORON = 25, ORE_LEAD = 15, ORE_VOPAL = 1, ORE_VERDANTIUM = 3, ORE_PAINITE = 1)

/datum/map/outpost/perform_map_generation()
	seed_submaps(list(Z_LEVEL_OUTPOST_ASTEROID), 220, /area/offworld/asteroidyard/external/yardzone, /datum/map_template/outpost21/space/orbitalyard_huge)
	seed_submaps(list(Z_LEVEL_OUTPOST_ASTEROID), 120, /area/offworld/asteroidyard/external/yardzone, /datum/map_template/outpost21/space/orbitalyard)

	seed_submaps(list(Z_LEVEL_OUTPOST_SURFACE), 150, /area/muriki/yard, /datum/map_template/outpost21/muriki/cargoyard_huge)
	seed_submaps(list(Z_LEVEL_OUTPOST_SURFACE), 200, /area/muriki/yard, /datum/map_template/outpost21/muriki/cargoyard)

	seed_submaps(list(Z_LEVEL_OUTPOST_DEEPDARK), 400, /area/mine/unexplored/muriki/cave/deepdark, /datum/map_template/outpost21/muriki/caves_deepdark_huge)
	seed_submaps(list(Z_LEVEL_OUTPOST_DEEPDARK), 450, /area/mine/unexplored/muriki/cave/deepdark, /datum/map_template/outpost21/muriki/caves_deepdark)

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_DEEPDARK, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_DEEPDARK, world.maxx, world.maxy)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_BASEMENT, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_BASEMENT, world.maxx, world.maxy)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_SURFACE, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_SURFACE, world.maxx, world.maxy)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 1, 1, Z_LEVEL_OUTPOST_UPPER, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_UPPER, world.maxx, world.maxy)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system(null, 128, 1,  Z_LEVEL_OUTPOST_ASTEROID, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_OUTPOST_ASTEROID, world.maxx, world.maxy)         // Create the mining ore distribution map.
	return 1

/datum/planet/muriki
	expected_z_levels = list(
		Z_LEVEL_OUTPOST_DEEPDARK,
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






/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam
	initial_generic_waypoints = list("confinementbeam_civ")
	name = "Confinement Beam Platform"
	scanner_desc = @{"[i]Registration[/i]: ES Orbital 21-04
[i]Class[/i]: Confinement Beam
[i]Transponder[/i]: Transmitting (ENG), ESHUI IFF
[b]Notice[/b]: ESHUI Base, authorized personnel only"}
	map_z = list(Z_LEVEL_OUTPOST_CONFINEMENTBEAM)
	extra_z_levels = list()

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/Crossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = FALSE)

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/Uncrossed(var/atom/movable/AM)
	. = ..()
	announce_atc(AM,going = TRUE)

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/proc/announce_atc(var/atom/movable/AM, var/going = FALSE)
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

/obj/effect/overmap/visitable/sector/murkiki_space/confinementbeam/get_space_zlevels()
	return list(Z_LEVEL_OUTPOST_CONFINEMENTBEAM)




// Skybox Settings
/datum/skybox_settings/outpost21
	icon_state = "dyable"
	random_color = TRUE

// For making the 6-in-1 holomap, we calculate some offsets
#define OUTPOST21_MAP_SIZEX 400
#define OUTPOST21_MAP_SIZEY 160
#define OUTPOST21_HOLOMAP_MARGIN_X (HOLOMAP_ICON_SIZE - (2*OUTPOST21_MAP_SIZEX))
#define OUTPOST21_HOLOMAP_MARGIN_Y (HOLOMAP_ICON_SIZE - (2*OUTPOST21_MAP_SIZEY))

/datum/map_z_level/outpost/centcom
	z = Z_LEVEL_OUTPOST_CENTCOM
	name = "CentCom"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED
	base_turf = /turf/simulated/floor/lava

/datum/map_z_level/outpost/deepdark
	z = Z_LEVEL_OUTPOST_DEEPDARK
	name = "Deepdark"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_VORESPAWN
	base_turf = /turf/simulated/mineral/muriki
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * 20) - 32 // hidden
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/basement
	z = Z_LEVEL_OUTPOST_BASEMENT
	name = "Basement"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS|MAP_LEVEL_VORESPAWN
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * 20) - 32 // hidden
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/main
	z = Z_LEVEL_OUTPOST_SURFACE
	name = "Main"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS|MAP_LEVEL_VORESPAWN
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * -0.55)
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/upper
	z = Z_LEVEL_OUTPOST_UPPER
	name = "Upper"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_PERSIST|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_AIRMIX_CLEANS|MAP_LEVEL_VORESPAWN
	base_turf = /turf/simulated/open
	holomap_offset_x = OUTPOST21_HOLOMAP_MARGIN_X
	holomap_offset_y = OUTPOST21_HOLOMAP_MARGIN_Y + (OUTPOST21_MAP_SIZEY * 0.88)
	holomap_legend_x = 140
	holomap_legend_y = 240

/datum/map_z_level/outpost/misc
	z = Z_LEVEL_OUTPOST_MISC
	name = "Misc"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED

/datum/map_z_level/outpost/asteroid_mine
	z = Z_LEVEL_OUTPOST_ASTEROID
	name = "Asteroid"
	transit_chance = 40
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_PERSIST|MAP_LEVEL_BELOW_BLOCKED|MAP_LEVEL_MAPPABLE|MAP_LEVEL_EVENTS|MAP_LEVEL_VORESPAWN

/datum/map_z_level/outpost/vr
	z = Z_LEVEL_OUTPOST_VR
	name = "Virtual"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED

/datum/map_z_level/outpost/confinementbeam
	z = Z_LEVEL_OUTPOST_CONFINEMENTBEAM
	name = "Confinementbeam"
	transit_chance = 40
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_CONTACT|MAP_LEVEL_CONSOLES|MAP_LEVEL_BELOW_BLOCKED|MAP_LEVEL_MAPPABLE|MAP_LEVEL_VORESPAWN


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

/*
/datum/unit_test/zas_area_test/cargo_maint
	name = "ZAS: Cargo Maintenance"
	area_path = /area/maintenance/cargo
*/

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
