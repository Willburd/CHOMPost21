//
// Outpost holomap modifications. !!!OVERRIDES ONLY!!! New areas go in outpost_modular/maps/common/common_areas.dm ---------------------------------------------------------------------
//
/area/centcom // lets NOT
	flags = RAD_SHIELDED|AREA_FLAG_IS_NOT_PERSISTENT|BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_BLOCK_GHOST_SIGHT|AREA_FORBID_EVENTS

/area/mine/unexplored
	flags = AREA_BLOCK_GHOST_SIGHT

/area/supply/station
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki
	outdoors = TRUE

/area/rnd/supermatter
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/constructionsite/science
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	use_emergency_overlay = TRUE

/area/maintenance/disposal
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/engineering/engine_room
	outdoors = TRUE
	base_turf = /turf/simulated/open/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/mail
	name = "\improper Engineering Mailing Room"
	icon_state = "quartdelivery"
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/maintenance/incinerator
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/maintenance/substation/mining
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/maintenance/tool_storage
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_NONE

/area/hallway/secondary/entry/docking_lounge
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/hallway/secondary/engineering_hallway
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/bridge
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/bridge_hallway
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/bridge/hallway
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	lightswitch = 1

/area/bridge/meeting_room
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/captain
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/heads/hop
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/heads/hor
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/heads/chief
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/heads/hos
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/heads/cmo
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/crew_quarters/courtroom
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_WARM

/area/crew_quarters/recreation_area_hallway
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	lightswitch = 1

/area/hallway/secondary/construction
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/crew_quarters/recreation_area
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/mint
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/comms
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	flags = RAD_SHIELDED | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED
	color_grading = COLORTINT_COLD

/area/server
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_COLD

/area/crew_quarters
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/crew_quarters/sleep/engi_wash
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/crew_quarters/sleep/cryo
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/crew_quarters/sleep/elevator
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/crew_quarters/locker
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/locker/locker_toilet
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/fitness
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/crew_quarters/pool
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/crew_quarters/sleep/Dorm_1
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_FIRE_SUPRESSION|AREA_ALLOW_LARGE_SIZE|AREA_SOUNDPROOF
	color_grading = COLORTINT_WARM

/area/crew_quarters/sleep/Dorm_2
	holomap_color = /area/crew_quarters/sleep/Dorm_1::holomap_color
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = /area/crew_quarters/sleep/Dorm_1::flags
	color_grading = /area/crew_quarters/sleep/Dorm_1::color_grading

/area/crew_quarters/sleep/Dorm_3
	holomap_color = /area/crew_quarters/sleep/Dorm_1::holomap_color
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = /area/crew_quarters/sleep/Dorm_1::flags
	color_grading = /area/crew_quarters/sleep/Dorm_1::color_grading

/area/crew_quarters/sleep/Dorm_4
	holomap_color = /area/crew_quarters/sleep/Dorm_1::holomap_color
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = /area/crew_quarters/sleep/Dorm_1::flags
	color_grading = /area/crew_quarters/sleep/Dorm_1::color_grading

/area/crew_quarters/sleep/Dorm_5
	holomap_color = /area/crew_quarters/sleep/Dorm_1::holomap_color
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = /area/crew_quarters/sleep/Dorm_1::flags
	color_grading = /area/crew_quarters/sleep/Dorm_1::color_grading

/area/crew_quarters/cafeteria
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/crew_quarters/coffee_shop
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/crew_quarters/kitchen
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	base_turf = /turf/simulated/open
	flags = AREA_FIRE_SUPRESSION

/area/crew_quarters/bar
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/library
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_WARM

/area/library_conference_room
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_WARM

/area/chapel
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_WARM

/area/lawoffice
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/security/prison
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = AREA_BLOCK_INSTANT_BUILDING | AREA_FIRE_SUPRESSION
	lightswitch = 1

/area/security/brig
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	flags = /area/security/prison::flags
	color_grading = COLORTINT_DIM
	lightswitch = 1

/area/security/security_aid_station
	name = "\improper Security Medical Station"
	icon_state = "medbay2"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open
	flags = /area/medical/first_aid_station::flags
	lightswitch = 1

/area/constructionsite/medical
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	use_emergency_overlay = TRUE

/area/medical/medbay
	name = "\improper Medbay Hallway - Stairwell"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/medbay2
	name = "\improper Medbay Hallway - Basement"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/medbay3
	name = "\improper Medbay Hallway - Primary"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/medbay4
	name = "\improper Medbay Hallway - Vox"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	flags = AREA_BLOCK_INSTANT_BUILDING | AREA_FIRE_SUPRESSION

/area/medical/psych
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	color_grading = COLORTINT_WARM

/area/crew_quarters/medbreak
	name = "\improper Medical Break Room"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/crew_quarters/medical_restroom
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/patients_rooms
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/ward
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/patient_wing
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/cmostore
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/robotics
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/medical/virology
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	color_grading = COLORTINT_CHILL

/area/medical/biostorage
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/medical/medbay2
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/medical/virologyaccess
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/morgue
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_COLD

/area/medical/chemistry
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery2
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgeryobs
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgeryprep
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery_hallway
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery_storage
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_CHILL

/area/medical/medbay4
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	lightswitch = 1

/area/medical/cryo
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/exam_room
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/genetics
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/genetics_cloning
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/medical/first_aid_station_starboard
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	lightswitch = 1

/area/medical/first_aid_station
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/open
	flags = AREA_BLOCK_INSTANT_BUILDING | AREA_FIRE_SUPRESSION
	lightswitch = 1

/area/storage/tools
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open

/area/storage/tech
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/engineering/drone_fabrication
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DARK

/area/janitor/
	holomap_color = HOLOMAP_AREACOLOR_JANITOR
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/djstation
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_WARM

/area/rnd/rdoffice
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/hydroponics
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	base_turf = /turf/simulated/open

/area/hydroponics/cafegarden
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	base_turf = /turf/simulated/open

/area/hydroponics/garden
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS
	base_turf = /turf/simulated/open

/area/quartermaster
	holomap_color = HOLOMAP_AREACOLOR_CARGO
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/quartermaster/foyer
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	base_turf = /turf/simulated/open
	lightswitch = 1

/area/quartermaster/qm
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open

/area/construction/solars
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/construction/solarscontrol
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/ai
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/mineral/floor/vacuum
	use_emergency_overlay = TRUE

/area/ai_upload
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/mineral/floor/vacuum
	use_emergency_overlay = TRUE

/area/ai_upload_foyer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/mineral/floor/vacuum
	use_emergency_overlay = TRUE

/area/ai_server_room
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/mineral/floor/vacuum
	use_emergency_overlay = TRUE

/area/ai_cyborg_station
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/mineral/floor/vacuum
	use_emergency_overlay = TRUE

/area/security/tactical
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	base_turf = /turf/simulated/open
	lightswitch = 1

/area/tcommsat
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/tcomsat
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE

/area/tcomfoyer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	use_emergency_overlay = TRUE
	flags = RAD_SHIELDED | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED

/area/tcommsat/computer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	flags = RAD_SHIELDED | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED

/area/tcommsat/lounge
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	flags = RAD_SHIELDED | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED

/area/tcommsat/powercontrol
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
	base_turf = /turf/simulated/open
	flags = RAD_SHIELDED | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED

/area/engineering/atmos
	name = "\improper Pulmonary Atmospherics"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DIM

/area/engineering/atmos/monitoring
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DIM

/area/constructionsite/atmospherics
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	use_emergency_overlay = TRUE
	color_grading = COLORTINT_DIM

/area/engineering/atmos/storage
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/substation/engineering
	base_turf = /turf/simulated/open

/area/maintenance/engineering
	base_turf = /turf/simulated/open

/area/maintenance/engi_engine
	base_turf = /turf/simulated/open

/area/maintenance/cargo
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki

/area/maintenance/substation/cargo
	base_turf = /turf/simulated/open

/area/maintenance/substation/security
	base_turf = /turf/simulated/open

/area/maintenance/arrivals
	base_turf = /turf/simulated/open

/area/maintenance/medbay_aft
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_DIM

/area/maintenance/medbay_fore
	base_turf = /turf/simulated/open

/area/maintenance/substation/medical
	base_turf = /turf/simulated/open

/area/rnd/xenobiology/xenoflora_storage
	base_turf = /turf/simulated/open

/area/rnd/xenobiology/xenoflora
	base_turf = /turf/simulated/open

/area/maintenance/substation/research
	base_turf = /turf/simulated/open

/area/maintenance/substation/civilian
	base_turf = /turf/simulated/open

/area/maintenance/substation/command
	base_turf = /turf/simulated/open

/area/maintenance/substation/virology
	base_turf = /turf/simulated/open

/area/maintenance/security_port
	base_turf = /turf/simulated/open

/area/maintenance/security_starboard
	base_turf = /turf/simulated/open

/area/maintenance/bar
	base_turf = /turf/simulated/open

/area/medical/sleeper
	flags = 0 //Makes it FILTHY again
	base_turf = /turf/simulated/open
	lightswitch = 1

/area/rnd/workshop
	name = "\improper Circuitry Lab"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DIM

/area/security/vacantoffice
	base_turf = /turf/simulated/open

/area/security/vacantoffice2
	base_turf = /turf/simulated/open

/area/security/lobby
	base_turf = /turf/simulated/open

/area/security/interrogation
	base_turf = /turf/simulated/open

/area/security/checkpoint2
	base_turf = /turf/simulated/open

/area/security/evidence_storage
	base_turf = /turf/simulated/open

/area/security/security_equiptment_storage
	base_turf = /turf/simulated/open

/area/security/armoury
	base_turf = /turf/simulated/open
	flags = BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_FIRE_SUPRESSION
	color_grading = COLORTINT_DIM
	lightswitch = 1

/area/security/briefing_room
	base_turf = /turf/simulated/open
	color_grading = COLORTINT_WARM

/area/security/detectives_office
	base_turf = /turf/simulated/open

/area/security/nuke_storage
	base_turf = /turf/simulated/open
	flags = BLUE_SHIELDED|AREA_BLOCK_PHASE_SHIFT|AREA_FIRE_SUPRESSION
	color_grading = COLORTINT_DARK
	lightswitch = 1

/area/security/range
	base_turf = /turf/simulated/open

/area/security/riot_control
	base_turf = /turf/simulated/mineral/floor/turfpack/muriki
	color_grading = COLORTINT_DARK

/area/virtual_reality
	name = "DO NOT USE ME. Use /area/vr"

/area/vr
	name = "Virtual Reality"
	icon_state = "Virtual_Reality"
	dynamic_lighting = 0
	requires_power = 0
	flags = AREA_ALLOW_LARGE_SIZE | AREA_LIMIT_DARK_RESPITE | AREA_FLAG_IS_NOT_PERSISTENT

/area/rnd/xenobiology/hallway
	lightswitch = 1

/area/medical/reception
	lightswitch = 1
