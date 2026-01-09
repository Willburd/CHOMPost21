// Adds a list of pre-disabled events to the available events list.
// This keeps them in the rotation, but disabled, so they can be enabled with a click if desired that round.
/datum/event_container/proc/add_disabled_events(var/list/disabled_events)
	for(var/datum/event_meta/EM in disabled_events)
		EM.enabled = 0
		available_events += EM

/datum/event_container/mundane/New()
	available_events = list(
		// Severity level, event name, even type, base weight, role weights, one shot, min weight, max weight. Last two only used if set and non-zero
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Nothing",			/datum/event/nothing,			10),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",		/datum/event/apc_damage,		2,	null, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",/datum/event/brand_intelligence,2,	null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",		/datum/event/camera_damage,		2, null, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Canister Leak",		/datum/event/canister_leak,		3, null, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Dust",		/datum/event/dust,	 			1, 	null, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",		/datum/event/economic_event,	1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",		/datum/event/money_hacker, 		2,  null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",		/datum/event/money_lotto, 		2,  null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "PDA Spam",			/datum/event/pda_spam, 			2, 	null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",	/datum/event/shipping_error	, 	1, 	null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",		/datum/event/trivial_news, 		2),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lore News",			/datum/event/lore_news, 		1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",/datum/event/infestation, 		3,	null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Wallrot",			/datum/event/wallrot, 			3,	null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Disposal Damage",	/datum/event/disposal_damage,	1, 	null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Manifest Spirit",	/datum/event/ghost_manifest,	2, 	null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Launch Rocket",		/datum/event/launch_rocket,		2)
	)
	add_disabled_events(list(
	))

/datum/event_container/moderate/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",					/datum/event/nothing,					12),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				2,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Lost Spiders",				/datum/event/spider_migration,			3, 		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",	/datum/event/communications_blackout,	1,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			5,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Failure",			/datum/event/gravity,	 				1,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",				/datum/event/grid_check, 				3,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Ion Storm",				/datum/event/ionstorm, 					3,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Rogue Drones",				/datum/event/rogue_drone, 				4,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Solar Storm",				/datum/event/solar_storm, 				4,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Dust",				/datum/event/dust,	 					3,		null, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Spider Infestation",		/datum/event/spider_infestation, 		3,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grub Infestation",			/datum/event/grub_infestation,			4,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Drone Pod Drop",			/datum/event/drone_pod_drop,			4,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 			/datum/event/spontaneous_appendicitis, 	4,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Malignant Organ", 			/datum/event/spontaneous_malignant_organ,3,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jellyfish School",			/datum/event/jellyfish_migration,		2,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wormholes",				/datum/event/wormholes, 				2),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Vines",				/datum/event/spacevine, 				3,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				5,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Psychic Screach",			/datum/event/psychic_screach,			1, 		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Backflow",		/datum/event/dirty_room,				3,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Chu Pack",					/datum/event/chu_infestation,			2, 		null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jil Pack",					/datum/event/jil_infestation,			3, 		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Phone Spiders",			/datum/event/phone_spiders,				5,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Moss",				/datum/event/spacemoss, 				5,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Damage",			/datum/event/disposal_damage,			1,		null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Random Borg Laws",			/datum/event/law_reset,					2, 		null, TRUE, min_jobs = list(JOB_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Bsa Test",					/datum/event/bsa_test_fire, 			3,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Hostile Runtime", 			/datum/event/hostile_runtime, 			2, 		null, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Bluespace Lockers", 		/datum/event/bluespace_locker, 			3, 		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Bluespace Anomaly",		/datum/event/anomaly/bluespace,			1,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Bioscrambler Anomaly",		/datum/event/anomaly/bioscrambler,		1,		null, TRUE, min_jobs = list(DEPARTMENT_MEDICAL = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Dimensional Anomaly",		/datum/event/anomaly/dimensional,		1,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Anomaly", 			/datum/event/anomaly/grav, 				1,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Pyroclastic Anomaly", 		/datum/event/anomaly/pyro,				1,		null, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Hallucination Anomaly",	/datum/event/anomaly/hallucination,		1,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Flux Anomaly",				/datum/event/anomaly/flux,				1,		null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Weather Anomaly",			/datum/event/anomaly/weather,			1,		null, TRUE),
	)
	add_disabled_events(list(
	))

/datum/event_container/major/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",				/datum/event/nothing						,5),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Meteor Wave",			/datum/event/meteor_wave					,2	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Meaty Ores Wave", 	/datum/event/meteor_wave/meatyores			,2	, null, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Carp Migration",		/datum/event/carp_migration					,2	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jellyfish Migration",	/datum/event/jellyfish_migration			,3	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disease Outbreak",	/datum/event/disease_outbreak				,3	, null, TRUE, min_jobs = list(DEPARTMENT_MEDICAL = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Chu Infestation",		/datum/event/chu_infestation				,2	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jil Infestation",		/datum/event/jil_infestation				,3	, null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Mouse Assault",		/datum/event/mouse_assualt					,1	, null, FALSE), // They have EARNED the single round trigger
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clowns",				/datum/event/clune_infestation				,2	, null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Redspace",			/datum/event/redspacefissure				,2	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Psychic Screach",		/datum/event/psychic_screach				,2  , null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Borg Freedom Law",	/datum/event/borglawerror					,2	, null, TRUE, min_jobs = list(JOB_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Spider Migration",	/datum/event/spider_migration				,2	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disposal Damage",		/datum/event/disposal_damage				,1	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clang",				/datum/event/clang							,2	, null, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Horde Infestation",	/datum/event/horde_infestation				,3	, null, FALSE, min_jobs = list(DEPARTMENT_SECURITY = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Quake",				/datum/event/quake							,1  , null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blood Writing",		/datum/event/dirty_room/cult				,1	, null, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Electrical Fire",		/datum/event/electrical_fire				,2	, null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Security Advisement",	/datum/event/security_drill					,3	, null, FALSE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Electrical Storm",	/datum/event/electrical_storm				,2	, null, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Septic Explosion",	/datum/event/septic_explosion				,1	, null, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Hostile Runtime", 	/datum/event/hostile_runtime				,2  , null, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Random Borg Laws",	/datum/event/law_reset						,2	, null, FALSE, min_jobs = list(JOB_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean						,0  , null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Weeping Statue Forced",/datum/event/weeping_statue				,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99))
	)
	add_disabled_events(list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean,					 0  , list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Weeping Statue Forced",/datum/event/weeping_statue				,0	, null, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99))
	))
