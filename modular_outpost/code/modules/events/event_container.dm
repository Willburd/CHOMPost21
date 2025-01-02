#define ASSIGNMENT_ANY "Any"
#define ASSIGNMENT_AI "AI"
#define ASSIGNMENT_CYBORG "Cyborg"
#define ASSIGNMENT_ENGINEER "Engineer"
#define ASSIGNMENT_GARDENER "Botanist"
#define ASSIGNMENT_JANITOR "Janitor"
#define ASSIGNMENT_MEDICAL "Medical"
#define ASSIGNMENT_SCIENTIST "Scientist"
#define ASSIGNMENT_SECURITY "Security"
#define ASSIGNMENT_CARGO "Cargo"
#define ASSIGNMENT_CHAPLAIN "Chaplain"

//
// VOREStation overrides to the default event manager configuration. //YW EDIT: WHY THE FUCK IS THIS NOT MENTIONED IN THE REGULAR FILE, AAAGGGHAA!
//
// This file lets us configure which events we want in the rotation without conflicts with upstream.
// It works because the actual event containers don't define New(), allowing us to use New() to replace
// the lists of available events.  If they ever do define New() this will need to be changed.
//
// Specifically the change is to move events we don't want down into the disabled_events list
//
// Outpost edit: Re-enabling most of the Fun events.. we like chaos.

// Adds a list of pre-disabled events to the available events list.
// This keeps them in the rotation, but disabled, so they can be enabled with a click if desired that round.
/datum/event_container/proc/add_disabled_events(var/list/disabled_events)
	for(var/datum/event_meta/EM in disabled_events)
		EM.enabled = 0
		available_events += EM

/datum/event_container/mundane/New()
	available_events = list(
		// Severity level, event name, even type, base weight, role weights, one shot, min weight, max weight. Last two only used if set and non-zero
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Nothing",			/datum/event/nothing,			30),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",		/datum/event/apc_damage,		20, 	list(ASSIGNMENT_ENGINEER = 5)	, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",/datum/event/brand_intelligence,10, 	list(ASSIGNMENT_ENGINEER = 5)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",		/datum/event/camera_damage,		20, 	list(ASSIGNMENT_ENGINEER = 1)	, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Canister Leak",		/datum/event/canister_leak,		10, 	list(ASSIGNMENT_ENGINEER = 5)	, FALSE, min_jobs = list(ASSIGNMENT_ENGINEER = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Dust",		/datum/event/dust,	 			0, 		list(ASSIGNMENT_ENGINEER = 1)	, FALSE, 0, min_jobs = list(ASSIGNMENT_ENGINEER = 2)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",		/datum/event/economic_event,	90),

		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",		/datum/event/money_hacker, 		0, 		list(ASSIGNMENT_ANY = 1)		, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",		/datum/event/money_lotto, 		0, 		list(ASSIGNMENT_ANY = 1)		, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "PDA Spam",			/datum/event/pda_spam, 			0, 		list(ASSIGNMENT_ANY = 1)		, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",	/datum/event/shipping_error	, 	30, 	list(ASSIGNMENT_ANY = 1)		, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",		/datum/event/trivial_news, 		50),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lore News",			/datum/event/lore_news, 		50),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",/datum/event/infestation, 		50,		list(ASSIGNMENT_JANITOR = 5)	,TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Wallrot",			/datum/event/wallrot, 			10,		list(ASSIGNMENT_ENGINEER = 10)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Disposal Damage",	/datum/event/disposal_damage,	3, 		list(ASSIGNMENT_ANY = 1)		, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Manifest Spirit",	/datum/event/ghost_manifest,	1, 		list(ASSIGNMENT_ANY = 1)		, FALSE)
	)
	add_disabled_events(list(
	))

/datum/event_container/moderate/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",					/datum/event/nothing,					40),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				30,		list(ASSIGNMENT_ENGINEER = 10)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Lost Spiders",				/datum/event/spider_migration,			2, 		list(ASSIGNMENT_SECURITY = 5)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",	/datum/event/communications_blackout,	30,		list(ASSIGNMENT_AI = 5, ASSIGNMENT_SECURITY = 5)		, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			70,		list(ASSIGNMENT_ENGINEER = 1, ASSIGNMENT_JANITOR = 5)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Failure",			/datum/event/gravity,	 				2,		list(ASSIGNMENT_ENGINEER = 1)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",				/datum/event/grid_check, 				20,		list(ASSIGNMENT_ENGINEER = 5)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Ion Storm",				/datum/event/ionstorm, 					20,		list(ASSIGNMENT_AI = 10, ASSIGNMENT_CYBORG = 10, ASSIGNMENT_ENGINEER = 5, ASSIGNMENT_SCIENTIST = 1), FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Prison Break",				/datum/event/prison_break,				4,		list(ASSIGNMENT_SECURITY = 10), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Rogue Drones",				/datum/event/rogue_drone, 				50,		list(ASSIGNMENT_SECURITY = 1)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Solar Storm",				/datum/event/solar_storm, 				30,		list(ASSIGNMENT_ENGINEER = 5, ASSIGNMENT_SECURITY = 1)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Dust",				/datum/event/dust,	 					20,		list(ASSIGNMENT_ENGINEER = 5)							, TRUE, min_jobs = list(ASSIGNMENT_ENGINEER = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virology Breach",			/datum/event/prison_break/virology,		1,		list(ASSIGNMENT_ENGINEER = 5)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Xenobiology Breach",		/datum/event/prison_break/xenobiology,	1,		list(ASSIGNMENT_ENGINEER = 1, ASSIGNMENT_SECURITY = 30)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Spider Infestation",		/datum/event/spider_infestation, 		5,		list(ASSIGNMENT_SECURITY = 5)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grub Infestation",			/datum/event/grub_infestation,			5,		list(ASSIGNMENT_SECURITY = 10, ASSIGNMENT_ENGINEER = 30), TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Drone Pod Drop",			/datum/event/drone_pod_drop,			10,		list(ASSIGNMENT_SCIENTIST = 40)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 			/datum/event/spontaneous_appendicitis, 	3,		list(ASSIGNMENT_MEDICAL = 30)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Malignant Organ", 			/datum/event/spontaneous_malignant_organ,3,		list(ASSIGNMENT_MEDICAL = 30)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jellyfish School",			/datum/event/jellyfish_migration,		10,		list(ASSIGNMENT_ANY = 1, ASSIGNMENT_SECURITY = 15, ASSIGNMENT_MEDICAL = 3), TRUE),
		//new /datum/event_meta(EVENT_LEVEL_MODERATE, "Supply Demand",			/datum/event/supply_demand,				1,		list(ASSIGNMENT_ANY = 5, ASSIGNMENT_SCIENCE = 15, ASSIGNMENT_GARDENER = 10, ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_MEDICAL = 15), TRUE, min_jobs = list(ASSIGNMENT_CARGO = 1)), //YW EDIT, Readded
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wormholes",				/datum/event/wormholes, 				15),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Vines",				/datum/event/spacevine, 				8,		list(ASSIGNMENT_ENGINEER = 3, ASSIGNMENT_GARDENER = 2)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				10,		list(ASSIGNMENT_ENGINEER = 15)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Psychic Screach",			/datum/event/psychic_screach,			4, 		list(ASSIGNMENT_ENGINEER = 1)							, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Backflow",		/datum/event/dirty_room,				3,		list(ASSIGNMENT_ANY = 3)								, FALSE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Chu Pack",					/datum/event/chu_infestation,			1, 		list(ASSIGNMENT_ENGINEER = 1,ASSIGNMENT_SECURITY = 1)	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jil Pack",					/datum/event/jil_infestation,			3, 		list(ASSIGNMENT_ENGINEER = 1,ASSIGNMENT_SECURITY = 1)	, TRUE),
		//new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virus Outbreak", 			/datum/event/viral_infection,			5, 		list(ASSIGNMENT_MEDICAL = 1)							, TRUE, min_jobs = list(ASSIGNMENT_MEDICAL = 2)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Phone Spiders",			/datum/event/phone_spiders,				5),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Moss",				/datum/event/spacemoss, 				12,		list(ASSIGNMENT_ANY = 1, ASSIGNMENT_GARDENER = 2)		, TRUE),
		//new /datum/event_meta(EVENT_LEVEL_MODERATE, "Escaped Slimes",			/datum/event/escaped_slimes, 			5,		list(ASSIGNMENT_SCIENCE = 1, ASSIGNMENT_ENGINEER = 5, ASSIGNMENT_SECURITY = 5), TRUE, min_jobs = list(ASSIGNMENT_MEDICAL = 3)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Damage",			/datum/event/disposal_damage,			2,		list(ASSIGNMENT_ANY = 3)								, FALSE)
	)
	add_disabled_events(list(
	))

/datum/event_container/major/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",				/datum/event/nothing						,20),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Meteor Wave",			/datum/event/meteor_wave					,5	, list(ASSIGNMENT_ENGINEER = 5)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Carp Migration",		/datum/event/carp_migration					,16	, list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 1,ASSIGNMENT_SECURITY = 5)	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Containment Breach",	/datum/event/prison_break/station			,8	, list(ASSIGNMENT_ANY = 5)													, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jellyfish Migration",	/datum/event/jellyfish_migration			,10	, list(ASSIGNMENT_ANY = 5, ASSIGNMENT_SECURITY = 5, ASSIGNMENT_MEDICAL = 1)	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disease Outbreak",	/datum/event/disease_outbreak				,1	, list(ASSIGNMENT_MEDICAL = 30, ASSIGNMENT_ANY = 1)							, TRUE, min_jobs = list(ASSIGNMENT_MEDICAL = 2)),
		//new /datum/event_meta(EVENT_LEVEL_MAJOR, "Virus Outbreak", 		/datum/event/viral_infection				,5	, list(ASSIGNMENT_MEDICAL = 1) 												, TRUE, min_jobs = list(ASSIGNMENT_MEDICAL = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Chu Infestation",		/datum/event/chu_infestation				,2	, list(ASSIGNMENT_SECURITY = 1)												, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jil Infestation",		/datum/event/jil_infestation				,5	, list(ASSIGNMENT_ENGINEER = 1,ASSIGNMENT_SECURITY = 1)						, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clowns",				/datum/event/clune_infestation				,7	, list(ASSIGNMENT_ENGINEER = 1,ASSIGNMENT_SECURITY = 5) 					, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Redspace",			/datum/event/redspacefissure				,12	, list()																	, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body",		/datum/event/badbody						,3	, list(ASSIGNMENT_CARGO = 1)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue",		/datum/event/badbody/morgue					,3	, list(ASSIGNMENT_MEDICAL = 1)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Psychic Screach",		/datum/event/psychic_screach				,1  , list(ASSIGNMENT_ENGINEER = 2)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Weeping Statue",		/datum/event/weeping_statue					,1	, list(ASSIGNMENT_SECURITY = 1)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Borg Freedom Law",	/datum/event/borglawerror					,1	, list(ASSIGNMENT_CYBORG = 5, ASSIGNMENT_SCIENCE = 5, ASSIGNMENT_SECURITY = 5), TRUE, min_jobs = list(ASSIGNMENT_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Spider Migration",	/datum/event/spider_migration				,2	, list(ASSIGNMENT_SECURITY = 5)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disposal Damage",		/datum/event/disposal_damage				,3	, list(ASSIGNMENT_ENGINEER = 5)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clang",				/datum/event/clang							,3	, list(ASSIGNMENT_ENGINEER = 3)												, TRUE, min_jobs = list(ASSIGNMENT_ENGINEER = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Horde Infestation",	/datum/event/horde_infestation				,5	, list(ASSIGNMENT_SECURITY = 5)												, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Quake",				/datum/event/quake							,5  , list(ASSIGNMENT_ENGINEER = 4)												, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blood Writing",		/datum/event/dirty_room/cult				,1	, list(ASSIGNMENT_ANY = 3)													, TRUE),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Electrical Fire",		/datum/event/electrical_fire				,5	, list(ASSIGNMENT_ENGINEER = 5,ASSIGNMENT_CYBORG = 3)												, FALSE),
		//new /datum/event_meta(EVENT_LEVEL_MAJOR, "Infected Room",				/datum/event/infectedroom			,1	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_MEDICAL = 2)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Security Advisement",	/datum/event/security_drill					,10	, list(ASSIGNMENT_SECURITY = 1,ASSIGNMENT_ANY = 5) 							, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Septic Explosion",	/datum/event/septic_explosion				,4	, list(ASSIGNMENT_ENGINEER = 1) 											, TRUE, min_jobs = list(ASSIGNMENT_ENGINEER = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean						,0  , list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, list()																	, TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99))
	)
	add_disabled_events(list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean,					 0  , list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Body Forced",	/datum/event/badbody/forced					,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Haunted Morgue Forced",/datum/event/badbody/morgue/forced			,0	, list(), TRUE, min_jobs = list(ASSIGNMENT_SECURITY = 99))
	))

#undef ASSIGNMENT_ANY
#undef ASSIGNMENT_AI
#undef ASSIGNMENT_CYBORG
#undef ASSIGNMENT_ENGINEER
#undef ASSIGNMENT_GARDENER
#undef ASSIGNMENT_JANITOR
#undef ASSIGNMENT_MEDICAL
#undef ASSIGNMENT_SCIENTIST
#undef ASSIGNMENT_SECURITY
#undef ASSIGNMENT_CARGO
#undef ASSIGNMENT_CHAPLAIN
