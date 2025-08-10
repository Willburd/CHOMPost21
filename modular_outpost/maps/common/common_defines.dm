// Z_LEVEL are just hard coded z-levels
// Z_NAME are late loaded z-level maps that can be looked up in GLOB.map_templates_loaded
// GLOB.map_templates_loaded is populated as /datum/map_template/proc/on_map_preload(z) is called
// Some Z_NAME ultimately will be indexed under an alias however e.g. Z_NAME_ALIAS_GATEWAY

// Outpost 21
//Outpost map defs
#define Z_LEVEL_OUTPOST_DEEPDARK					1
#define Z_LEVEL_OUTPOST_BASEMENT					2
#define Z_LEVEL_OUTPOST_SURFACE						3
#define Z_LEVEL_OUTPOST_UPPER						4
#define Z_LEVEL_OUTPOST_ASTEROID 					5
#define Z_LEVEL_OUTPOST_CONFINEMENTBEAM				6
#define Z_LEVEL_OUTPOST_VR		 					7
//define Z_LEVEL_OUTPOST_PROSPECTOR					8 // Does nothing currently
//define Z_LEVEL_OUTPOST_SURVEYOR					9 // Does nothing currently


// Lateload Z level names
#define Z_NAME_OUTPOST_CENTCOM					"Outpost21 - Central Command" // Aliased to Z_NAME_ALIAS_CENTCOM
#define Z_NAME_OUTPOST_MISC						"Outpost21 - Misc" // Aliased to Z_NAME_ALIAS_MISC
#define Z_NAME_OUTPOST_ROGUEMINE_1 				"Asteroid Belt 1"
#define Z_NAME_OUTPOST_ROGUEMINE_2 				"Asteroid Belt 2"
