// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "light_A.dmm"
#include "light_B.dmm"
#include "light_C.dmm"
#include "flesh_A.dmm"
#include "flesh_B.dmm"
#include "gas_pocket_A.dmm"
#include "trap_A.dmm"
#include "den_A.dmm"
#include "den_B.dmm"
#include "cave_A.dmm"
#include "cave_B.dmm"
#include "hall_A.dmm"
#include "hall_B.dmm"
#include "lake_A.dmm"
#include "wall_A.dmm"
#include "wall_B.dmm"
#include "honk_A.dmm"
#include "spider_A.dmm"
#include "liminal_A.dmm"
#include "liminal_B.dmm"
#include "liminal_C.dmm"
#include "redspace_A.dmm"
#include "redspace_B.dmm"
#include "redspace_C.dmm"
#include "statue_A.dmm"
#include "hole_A.dmm"
#include "lava_A.dmm"
#include "lava_B.dmm"
#include "biohazard_A.dmm"
#endif

/datum/map_template/outpost21/muriki/caves_deepdark
	name = "Cave Content - Small"
	desc = "Used to fill extra space to explore in the deep dark."
	annihilate = TRUE

/datum/map_template/outpost21/muriki/caves_deepdark_huge
	name = "Cave Content - Big"
	desc = "Used to fill EXTRA space to explore in the deep dark."
	annihilate = TRUE

//////////////////////////////////////////////////////////////
// Generic things and structures
/datum/map_template/outpost21/muriki/caves_deepdark/light_A
	name = "Light Variant A"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/deepdark/light_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/light_B
	name = "Light Variant B"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/deepdark/light_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/light_C
	name = "Light Variant C"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/deepdark/light_C.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/gas_A
	name = "Gas Pocket Variant A"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/gas_B
	name = "Gas Pocket Variant B"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 50
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/gas_C
	name = "Gas Pocket Variant C"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_C.dmm'
	allow_duplicates = TRUE
	discard_prob = 50
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_A
	name = "Flesh Variant A"
	desc = "flesh varient."
	mappath = 'maps/submaps/outpost21/deepdark/flesh_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_B
	name = "Flesh Variant B"
	desc = "flesh varient."
	mappath = 'maps/submaps/outpost21/deepdark/flesh_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark/den_A
	name = "Den A"
	desc = "Random den."
	mappath = 'maps/submaps/outpost21/deepdark/den_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/den_B
	name = "Den B"
	desc = "Random den."
	mappath = 'maps/submaps/outpost21/deepdark/den_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 40
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/trap_A
	name = "Trap A"
	desc = "Random trap."
	mappath = 'maps/submaps/outpost21/deepdark/trap_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/lava_A
	name = "Lava A"
	desc = "Random lava."
	mappath = 'maps/submaps/outpost21/deepdark/lava_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/lava_B
	name = "Lava B"
	desc = "Random lava."
	mappath = 'maps/submaps/outpost21/deepdark/lava_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

//////////////////////////////////////////////////////////////
// Huge structures in the cave
/datum/map_template/outpost21/muriki/caves_deepdark_huge/cave_A
	name = "Cave A"
	desc = "Random cave."
	mappath = 'maps/submaps/outpost21/deepdark/cave_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/cave_B
	name = "Cave B"
	desc = "Random cave."
	mappath = 'maps/submaps/outpost21/deepdark/cave_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hall_A
	name = "Hall A"
	desc = "Random cave hall."
	mappath = 'maps/submaps/outpost21/deepdark/hall_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hall_B
	name = "Hall B"
	desc = "Random cave hall."
	mappath = 'maps/submaps/outpost21/deepdark/hall_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/lake_A
	name = "Lake A"
	desc = "Random cave lake."
	mappath = 'maps/submaps/outpost21/deepdark/lake_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/wall_A
	name = "Wall A"
	desc = "Random cave maint wall."
	mappath = 'maps/submaps/outpost21/deepdark/wall_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark_huge/wall_B
	name = "Wall B"
	desc = "Random cave maint wall."
	mappath = 'maps/submaps/outpost21/deepdark/wall_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark_huge/honk_A
	name = "Honk A"
	desc = "Random honk."
	mappath = 'maps/submaps/outpost21/deepdark/honk_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/spider_A
	name = "Spider A"
	desc = "Random spiders."
	mappath = 'maps/submaps/outpost21/deepdark/spider_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_A
	name = "Liminal A"
	desc = "Random liminal space."
	mappath = 'maps/submaps/outpost21/deepdark/liminal_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_B
	name = "Liminal B"
	desc = "Random liminal space."
	mappath = 'maps/submaps/outpost21/deepdark/liminal_B.dmm'
	allow_duplicates = FALSE // DO NOT SPAWN TWICE, has a controller effect for the area...
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_C
	name = "Liminal C"
	desc = "Random liminal space."
	mappath = 'maps/submaps/outpost21/deepdark/liminal_C.dmm'
	allow_duplicates = TRUE
	discard_prob = 40
	cost = 10

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_A
	name = "Red A"
	desc = "Random redspace leak."
	mappath = 'maps/submaps/outpost21/deepdark/redspace_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_B
	name = "Red B"
	desc = "Random redspace leak."
	mappath = 'maps/submaps/outpost21/deepdark/redspace_B.dmm'
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_C
	name = "Red C"
	desc = "Random redspace leak."
	mappath = 'maps/submaps/outpost21/deepdark/redspace_C.dmm'
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/statue_A
	name = "statue A"
	desc = "Random statue."
	mappath = 'maps/submaps/outpost21/deepdark/statue_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 85
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hole_A
	name = "hole A"
	desc = "Random hole."
	mappath = 'maps/submaps/outpost21/deepdark/hole_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 75
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/biohazard_A
	name = "biohazard A"
	desc = "Random biohazard."
	mappath = 'maps/submaps/outpost21/deepdark/biohazard_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 75
	cost = 20


//////////////////////////////////////////////////////////////
// Area definitions

/area/submap/outpost21/cave_liminal_A
	name = "\improper Come Closer"
	icon_state = "red2"
	secret_name = FALSE
	sound_env = SOUND_ENVIRONMENT_PSYCHOTIC
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki

/area/submap/outpost21/cave_liminal_B
	name = "\improper GET OUT"
	var/show_name = "GET OUT" // replaces name
	icon_state = "red2"
	secret_name = FALSE
	always_unpowered = FALSE
	requires_power = FALSE
	sound_env = SOUND_ENVIRONMENT_AUDITORIUM
	ambience = AMBIENCE_MAINTENANCE
	base_turf = /turf/simulated/mineral/floor/muriki

/area/submap/outpost21/cave_liminal_B/get_name()
	return show_name

/area/submap/outpost21/cave_red_A
	name = "\improper Our Pulsing Mass"
	icon_state = "red2"
	secret_name = FALSE
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki

/area/submap/outpost21/cave_red_B
	name = "\improper Inside Us"
	secret_name = FALSE
	icon_state = "red2"
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki

/area/submap/outpost21/cave_red_C
	name = "\improper Touch Our Skin"
	icon_state = "red2"
	secret_name = FALSE
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki
