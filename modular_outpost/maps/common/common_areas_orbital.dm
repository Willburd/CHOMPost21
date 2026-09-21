//
//-----------------------------------------------------------------------
// Orbital

// This makes the area behave like area/space
#define EXTERIOR_AREA_BEHAVIOR(x) x {base_turf = /turf/space;has_gravity = FALSE;dynamic_lighting = FALSE;}; x/get_gravity(){return FALSE;}

/area/offworld/orbital/station
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	base_turf = /turf/simulated/mineral/floor/cave

/area/offworld/orbital/exterior
	name = "\improper Orbital Exterior"
	icon_state = "red2"
	ambience = AMBIENCE_MURIKICAVE
	base_turf = /turf/simulated/mineral/floor/vacuum
	flags = AREA_BLOCK_GHOST_SIGHT
	ambience = AMBIENCE_SPACE


// Area where pois generate
/area/offworld/orbital/exterior/yardzone
	icon_state = "construction"
EXTERIOR_AREA_BEHAVIOR(/area/offworld/orbital/exterior/yardzone)

/area/offworld/orbital/exterior/rust_cooling
	name = "\improper Orbital Rust Cooling Array"

/area/offworld/orbital/exterior/emitter_cooling
	name = "\improper Orbital Emitter Cooling Array"
EXTERIOR_AREA_BEHAVIOR(/area/offworld/orbital/exterior/emitter_cooling)


// HALLWAYS
/area/offworld/orbital/station/halls
	name = "\improper Orbital Hallway"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE

/area/offworld/orbital/station/halls/central
	name = "\improper Orbital Central Hallway"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/fore
	name = "\improper Orbital Fore Hallway"
	icon_state = "orange"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/aft
	name = "\improper Orbital Aft Hallway"
	icon_state = "orange"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/starboard
	name = "\improper Orbital Starboard Hallway"
	icon_state = "orange"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/lower
	name = "\improper Orbital Lower Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/lower/central
	name = "\improper Orbital Lower Central Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/halls/lower/fore
	name = "\improper Orbital Lower Fore Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/halls/lower/aft
	name = "\improper Orbital Lower Aft Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/offworld/orbital/station/halls/lower/port
	name = "\improper Orbital Lower Port Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/lower/starboard
	name = "\improper Orbital Lower Starboard Hallway"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/stairs_upper
	name = "\improper Orbital Stairwell Upper"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	base_turf = /turf/simulated/open

/area/offworld/orbital/station/halls/stairs_lower
	name = "\improper Orbital Stairwell Lower"
	icon_state = "yellow"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/orbital/station/halls/rust_tool_storage
	name = "\improper Orbital RUST Storage Hallway"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/halls/rust_entry
	name = "\improper Orbital RUST Entry Hallway"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/washing
	name = "\improper Orbital Cleaning Room"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC

/area/offworld/orbital/station/bar
	name = "\improper Orbital Bar"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	color_grading = COLORTINT_WARM
	sound_env = MEDIUM_SOFTFLOOR
	ambience = AMBIENCE_GENERIC

/area/offworld/orbital/station/spelunker
	name = "\improper Orbital Spelunker"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DARK
	flags = /area/muriki/bathroom::flags
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC

/area/offworld/orbital/station/droppod
	name = "\improper Orbital Drop Pod"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_CIV
	color_grading = COLORTINT_DARK
	flags = /area/muriki/bathroom::flags
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC

/area/offworld/orbital/station/engineering
	name = "\improper Orbital Engineering"
	icon_state = "orange"
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/telecomms
	name = "\improper Orbital Telecomms"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_HIGHSEC
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/offworld/orbital/station/teleport
	name = "\improper Orbital Teleporter"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_HIGHSEC
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	color_grading = COLORTINT_DIM

/area/offworld/orbital/station/medical_treatment
	name = "\improper Orbital Upper Medical Station"
	icon_state = "green"
	sound_env = SOUND_ENVIRONMENT_STONEROOM
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = /area/medical/first_aid_station::flags

/area/offworld/orbital/station/lower_medical_treatment
	name = "\improper Orbital Lower Medical Station"
	icon_state = "green"
	sound_env = SOUND_ENVIRONMENT_STONEROOM
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = /area/medical/first_aid_station::flags

/area/offworld/orbital/station/engineering/mass_driver
	name = "\improper Orbital Mass Driver"
	icon_state = "blue"

//
//-----------------------------------------------------------------------
// Orbital : Airlocks and docking

/area/offworld/orbital/station/port_airlock
	name = "\improper Orbital Port Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/starboard_airlock
	name = "\improper Orbital Starboard Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/orbital/station/trawler_airlock
	name = "\improper Orbital Trawler Airlock"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/orbital/station/dockingarm
	name = "\improper Orbital Docking Arm"
	icon_state = "decontamination"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/orbital/station/south_power_airlock
	name = "\improper Orbital Power Distribution Airlock South"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/south_engine_access_west
	name = "\improper Orbital Engine Access Airlock West"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/south_engine_access_east
	name = "\improper Orbital Engine Access Airlock East"
	icon_state = "shuttle2"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : Access shafts/hangers

/area/offworld/orbital/station/access_shaft
	name = "\improper Orbital Public Docking Arm"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR

/area/offworld/orbital/station/dockinghanger
	name = "\improper Orbital Cargo Loading Airlock"
	icon_state = "decontamination"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/orbital/station/access_shaft/upper
	name = "\improper Orbital Upper Docking Arm"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	base_turf = /turf/space

/area/offworld/orbital/station/access_shaft/upper_connector
	name = "\improper Orbital Upper Docking Connector"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	base_turf = /turf/space

/area/offworld/orbital/station/access_shaft/lower
	name = "\improper Orbital Lower Docking Arm"
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	base_turf = /turf/space

//
//-----------------------------------------------------------------------
// Orbital : Observation

/area/offworld/orbital/station/observation
	name = "\improper Orbital Primary Observation"
	icon_state = "blue"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/orbital/station/port_observation
	name = "\improper Orbital Port Observation"
	icon_state = "blue"
	sound_env = SMALL_SOFTFLOOR
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/space

/area/offworld/orbital/station/starboard_observation
	name = "\improper Orbital Starboard Observation"
	icon_state = "blue"
	sound_env = SMALL_SOFTFLOOR
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_CIV

//
//-----------------------------------------------------------------------
// Orbital : Security

/area/offworld/orbital/station/security
	name = "\improper Orbital Security"
	icon_state = "red"
	sound_env = SMALL_SOFTFLOOR
	ambience = AMBIENCE_HIGHSEC
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/offworld/orbital/station/security/lockup
	name = "\improper Orbital Security Lockup"
	icon_state = "locker"

/area/offworld/orbital/station/security/armory
	name = "\improper Orbital Security Armory"
	icon_state = "toxtest"

/area/offworld/orbital/station/security/holding_cell
	name = "\improper Orbital Security Holding Cell"
	icon_state = "LP"

//
//-----------------------------------------------------------------------
// Orbital : AI core

/area/offworld/orbital/station/ai_transit_hub
	name = "\improper AI Core Transit Hub"
	icon_state = "teleporter"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HIGHSEC
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

//
//-----------------------------------------------------------------------
// Orbital : PTL emitter

/area/offworld/orbital/station/ptl_core
	name = "\improper Orbital PTL Beam Engineering"
	icon_state = "LP"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/beam_emitter
	name = "\improper Orbital Emitter Control"
	icon_state = "shuttle2"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : Atmos

/area/offworld/orbital/station/atmos_primary
	name = "\improper Orbital Primary Atmospherics"
	icon_state = "toxtest"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ATMOS
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/atmos_sublevel
	name = "\improper Orbital Lower Atmospherics"
	icon_state = "engineering_workshop"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ATMOS
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/atmos_aux
	name = "\improper Orbital Auxiliary Atmospherics"
	icon_state = "blue"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ATMOS
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : Solars

/area/offworld/orbital/station/solar_control
	name = "\improper Orbital Solar Control"
	icon_state = "dark128"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/exterior/starboard_solars
	name = "\improper Orbital Starboard Solars"
	icon_state = "purple"
EXTERIOR_AREA_BEHAVIOR(/area/offworld/orbital/exterior/starboard_solars)

//
//-----------------------------------------------------------------------
// Orbital : Power distro

/area/offworld/orbital/station/engine_primer
	name = "\improper Orbital Engine Primer"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/power_distribution
	name = "\improper Orbital Power Distribution"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/backup_power
	name = "\improper Orbital Auxilary Power"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : Main engines

// Tesla
/area/offworld/orbital/exterior/engine_core_port
	name = "\improper Port Engine Core"
	icon_state = "engine"
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

// Singulo
/area/offworld/orbital/exterior/engine_core_starboard
	name = "\improper Starboard Engine Core"
	icon_state = "engine"
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/engine_core_aux
	name = "\improper Auxiliary Engine Core"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/port_equipment
	name = "\improper Orbital Engine Equipment Port"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/starboard_equipment
	name = "\improper Orbital Engine Equipment Starboard"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/aux_equipment
	name = "\improper Orbital Auxilary Engine Equipment"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : RUST engine

/area/offworld/orbital/station/rust_core
	name = "\improper Orbital RUST Engine Core"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/rust_tool_storage
	name = "\improper Orbital RUST Tool Storage"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/rust_gas_storage
	name = "\improper Orbital RUST Gas Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/rust_aux_tool_storage
	name = "\improper Orbital RUST Auxiliary Tool Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/rust_control
	name = "\improper RUST Engine Control Room"
	icon_state = "engine_monitoring"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/rust_backup_power
	name = "\improper Orbital RUST Backup Power"
	icon_state = "orange"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//
//-----------------------------------------------------------------------
// Orbital : Storage

/area/offworld/orbital/station/storage
	name = "\improper Orbital Primary Storage"
	icon_state = "locker"
	sound_env = ASTEROID
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM

/area/offworld/orbital/station/storage_aux
	name = "\improper Orbital Material Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	color_grading = COLORTINT_DIM

/area/offworld/orbital/station/storage
	name = "\improper Orbital Primary Storage"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/station/storage_engine_core
	name = "\improper Orbital Engine Core Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	color_grading = COLORTINT_DIM

//
//-----------------------------------------------------------------------
// Orbital : Maints

/area/maintenance/orbital
	name = "\improper Orbital Maintenance"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	base_turf = /turf/simulated/mineral/floor/cave

/area/maintenance/orbital/fore
	name = "\improper Orbital Maintenance Fore"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/aft
	name = "\improper Orbital Maintenance Aft"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/open

/area/maintenance/orbital/port
	name = "\improper Orbital Maintenance Port"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/starboard
	name = "\improper Orbital Maintenance Starboard"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/lower
	name = "\improper Orbital Maintenance Lower"

/area/maintenance/orbital/lower/fore
	name = "\improper Orbital Maintenance Lower Fore"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/lower/aft
	name = "\improper Orbital Maintenance Lower Aft"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/lower/port
	name = "\improper Orbital Maintenance Lower Port"
	sound_env = SMALL_ENCLOSED

/area/maintenance/orbital/lower/starboard
	name = "\improper Orbital Maintenance Lower Starboard"
	sound_env = SMALL_ENCLOSED

//
//-----------------------------------------------------------------------
// Orbital : Phoronics

/area/offworld/orbital/phoronics
	name = "\improper Orbital Phoronics Lab"
	icon_state = "toxtest"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/orbital/phoronics/bomb_test_range
	name = "\improper Orbital Bomb Test Range"
	icon_state = "orange"

/area/offworld/orbital/phoronics/burn_chamber
	name = "\improper Orbital Phoronics Burn Chamber"
	icon_state = "red"
	sound_env = SMALL_ENCLOSED

/area/offworld/orbital/phoronics/overflow_storage
	name = "\improper Orbital Phoronics Overflow Storage"
	icon_state = "locker"
	sound_env = SMALL_ENCLOSED

/area/offworld/orbital/phoronics/pressure_release
	name = "\improper Orbital Phoronics Pressure Release Chamber"
	sound_env = SMALL_ENCLOSED
	flags = /area/muriki/bathroom::flags
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_CHILL

/area/offworld/orbital/phoronics/breakroom
	name = "\improper Orbital Phoronics Breakroom"

/area/offworld/orbital/phoronics/gas_storage
	name = "\improper Orbital Phoronics Gas Storage"
	icon_state = "locker"

/area/offworld/orbital/phoronics/airlock
	name = "\improper Orbital Phoronics Airlock"
	icon_state = "decontamination"
