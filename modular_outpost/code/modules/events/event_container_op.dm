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
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Light Flicker",		/datum/event/light_flicker,		12),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",		/datum/event/apc_damage,		6, 		list(DEPARTMENT_ENGINEERING = 2)	, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",/datum/event/brand_intelligence,2, 		list(DEPARTMENT_ENGINEERING = 2)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",		/datum/event/camera_damage,		10, 	list(DEPARTMENT_ENGINEERING = 1)	, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Canister Leak",		/datum/event/canister_leak,		10, 	list(DEPARTMENT_ENGINEERING = 3)	, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Dust",		/datum/event/dust,	 			0, 		list(DEPARTMENT_ENGINEERING = 1)	, FALSE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",		/datum/event/economic_event,	8),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",		/datum/event/money_hacker, 		0, 		list(DEPARTMENT_ANY = 1)			, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",		/datum/event/money_lotto, 		0, 		list(DEPARTMENT_ANY = 1)			, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "PDA Spam",			/datum/event/pda_spam, 			0, 		list(DEPARTMENT_ANY = 1)			, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",	/datum/event/shipping_error	, 	8, 		list(DEPARTMENT_ANY = 1)			, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",		/datum/event/trivial_news, 		5),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lore News",			/datum/event/lore_news, 		5),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",/datum/event/infestation, 		8,		list(JOB_JANITOR = 2)				, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Wallrot",			/datum/event/wallrot, 			3,		list(DEPARTMENT_ENGINEERING = 2)	, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Disposal Damage",	/datum/event/disposal_damage,	3, 		list(DEPARTMENT_ANY = 1)			, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Manifest Spirit",	/datum/event/ghost_manifest,	1, 		list(JOB_CHAPLAIN = 2)				, FALSE)
	)
	add_disabled_events(list(
	))

/datum/event_container/moderate/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",					/datum/event/nothing,					30),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				20,		list(DEPARTMENT_ENGINEERING = 1)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Lost Spiders",				/datum/event/spider_migration,			2, 		list(DEPARTMENT_SECURITY = 2)								, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",	/datum/event/communications_blackout,	10,		list(JOB_AI = 2, DEPARTMENT_SECURITY = 2, JOB_CHAPLAIN = 2)	, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			20,		list(DEPARTMENT_ENGINEERING = 1, DEPARTMENT_ENGINEERING = 2), FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Failure",			/datum/event/gravity,	 				2,		list(DEPARTMENT_ENGINEERING = 1)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",				/datum/event/grid_check, 				15,		list(DEPARTMENT_ENGINEERING = 5)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Ion Storm",				/datum/event/ionstorm, 					10,		list(JOB_AI = 2, JOB_CYBORG = 2, DEPARTMENT_ENGINEERING = 1), FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Prison Break",				/datum/event/prison_break,				1,		list(DEPARTMENT_SECURITY = 1)								, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Rogue Drones",				/datum/event/rogue_drone, 				10,		list(DEPARTMENT_SECURITY = 1)								, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Solar Storm",				/datum/event/solar_storm, 				10,		list(DEPARTMENT_ENGINEERING = 2, DEPARTMENT_SECURITY = 1)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Dust",				/datum/event/dust,	 					10,		list(DEPARTMENT_ENGINEERING = 2)							, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virology Breach",			/datum/event/prison_break/virology,		1,		list(DEPARTMENT_ENGINEERING = 1)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Xenobiology Breach",		/datum/event/prison_break/xenobiology,	1,		list(DEPARTMENT_ENGINEERING = 1, DEPARTMENT_SECURITY = 3)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Spider Infestation",		/datum/event/spider_infestation, 		5,		list(DEPARTMENT_SECURITY = 2)								, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grub Infestation",			/datum/event/grub_infestation,			5,		list(DEPARTMENT_SECURITY = 1, DEPARTMENT_ENGINEERING = 3)	, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Drone Pod Drop",			/datum/event/drone_pod_drop,			10,		list(DEPARTMENT_RESEARCH = 2)								, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 			/datum/event/spontaneous_appendicitis, 	3,		list(DEPARTMENT_MEDICAL = 3)								, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Malignant Organ", 			/datum/event/spontaneous_malignant_organ,3,		list(DEPARTMENT_MEDICAL = 3)								, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jellyfish School",			/datum/event/jellyfish_migration,		2,		list(DEPARTMENT_SECURITY = 1, DEPARTMENT_MEDICAL = 1)		, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wormholes",				/datum/event/wormholes, 				8),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Vines",				/datum/event/spacevine, 				8,		list(DEPARTMENT_ENGINEERING = 3, JOB_BOTANIST = 2)			, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				5,		list(DEPARTMENT_ENGINEERING = 2)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Psychic Screach",			/datum/event/psychic_screach,			4, 		list(DEPARTMENT_ENGINEERING = 1, JOB_CHAPLAIN = 2)			, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Backflow",		/datum/event/dirty_room,				3,		list(JOB_JANITOR = 3)										, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Chu Pack",					/datum/event/chu_infestation,			1, 		list(DEPARTMENT_ENGINEERING = 1,DEPARTMENT_SECURITY = 2)	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jil Pack",					/datum/event/jil_infestation,			3, 		list(DEPARTMENT_ENGINEERING = 1,DEPARTMENT_SECURITY = 1)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Phone Spiders",			/datum/event/phone_spiders,				5,		list(DEPARTMENT_SECURITY = 3)								, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Moss",				/datum/event/spacemoss, 				8,		list(JOB_BOTANIST = 2)										, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Damage",			/datum/event/disposal_damage,			2,		list(DEPARTMENT_ENGINEERING = 3)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Random Borg Laws",			/datum/event/law_reset,					1, 		list(DEPARTMENT_ENGINEERING = 1, DEPARTMENT_SECURITY = 1)	, TRUE, min_jobs = list(JOB_CYBORG = 1)),
	)
	add_disabled_events(list(
	))

/datum/event_container/major/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",				/datum/event/nothing						,15),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Meteor Wave",			/datum/event/meteor_wave					,5	, list(DEPARTMENT_ENGINEERING = 1)											, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Carp Migration",		/datum/event/carp_migration					,8	, list(JOB_CYBORG = 1,DEPARTMENT_ENGINEERING = 1,DEPARTMENT_SECURITY = 3)	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Containment Breach",	/datum/event/prison_break/station			,2	, list(DEPARTMENT_SECURITY = 2)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jellyfish Migration",	/datum/event/jellyfish_migration			,8	, list(DEPARTMENT_SECURITY = 2, DEPARTMENT_MEDICAL = 1)						, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disease Outbreak",	/datum/event/disease_outbreak				,1	, list(DEPARTMENT_MEDICAL = 3)												, TRUE, min_jobs = list(DEPARTMENT_MEDICAL = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Chu Infestation",		/datum/event/chu_infestation				,2	, list(DEPARTMENT_SECURITY = 3)												, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jil Infestation",		/datum/event/jil_infestation				,5	, list(DEPARTMENT_ENGINEERING = 1,DEPARTMENT_SECURITY = 1)					, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clowns",				/datum/event/clune_infestation				,7	, list(DEPARTMENT_MEDICAL = 1,DEPARTMENT_SECURITY = 3, JOB_CHAPLAIN = 2)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Redspace",			/datum/event/redspacefissure				,8	, list(DEPARTMENT_SECURITY = 1, JOB_CHAPLAIN = 1)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body",		/datum/event/badbody						,1	, list(JOB_CHAPLAIN = 2)													, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue",		/datum/event/badbody/morgue					,1	, list(DEPARTMENT_MEDICAL = 2, JOB_CHAPLAIN = 2)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Psychic Screach",		/datum/event/psychic_screach				,1  , list(DEPARTMENT_ENGINEERING = 3, JOB_CHAPLAIN = 2)						, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Weeping Statue",		/datum/event/weeping_statue					,1	, list(DEPARTMENT_SECURITY = 1)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Borg Freedom Law",	/datum/event/borglawerror					,1	, list(JOB_CYBORG = 2, DEPARTMENT_ENGINEERING = 2, DEPARTMENT_SECURITY = 2)	, TRUE, min_jobs = list(JOB_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Spider Migration",	/datum/event/spider_migration				,2	, list(DEPARTMENT_SECURITY = 2)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disposal Damage",		/datum/event/disposal_damage				,1	, list(JOB_CYBORG = 2, DEPARTMENT_ENGINEERING = 3)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clang",				/datum/event/clang							,3	, list(DEPARTMENT_ENGINEERING = 3)											, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Horde Infestation",	/datum/event/horde_infestation				,2	, list(DEPARTMENT_SECURITY = 2)												, FALSE, min_jobs = list(DEPARTMENT_SECURITY = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Quake",				/datum/event/quake							,1  , list(DEPARTMENT_ENGINEERING = 3)											, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blood Writing",		/datum/event/dirty_room/cult				,1	, list(JOB_CHAPLAIN = 2)													, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Electrical Fire",		/datum/event/electrical_fire				,5	, list(DEPARTMENT_ENGINEERING = 3,JOB_CYBORG = 3)							, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Security Advisement",	/datum/event/security_drill					,5	, list(DEPARTMENT_SECURITY = 3,JOB_CYBORG = 1) 								, FALSE, min_jobs = list(DEPARTMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Septic Explosion",	/datum/event/septic_explosion				,1	, list(DEPARTMENT_ENGINEERING = 1) 											, TRUE, min_jobs = list(DEPARTMENT_ENGINEERING = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Random Borg Laws",	/datum/event/law_reset						,1	, list(DEPARTMENT_ENGINEERING = 1, DEPARTMENT_SECURITY = 1)					, FALSE, min_jobs = list(JOB_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean						,0  , list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, list()																	, TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99))
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
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, list(), TRUE, min_jobs = list(DEPARTMENT_SECURITY = 99))
	))
