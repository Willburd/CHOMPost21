// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "container_A.dmm"
#include "container_B.dmm"
#include "container_C.dmm"
#include "container_D.dmm"
#include "path_A.dmm"
#include "path_B.dmm"
#include "light_A.dmm"
#endif

/datum/map_template/outpost21/muriki/cargoyard
	name = "Yard Content - Small"
	desc = "Used to fill extra space to explore in the cargo yard."
	annihilate = TRUE


/datum/map_template/outpost21/muriki/cargoyard_huge
	name = "Yard Content - Big"
	desc = "Used to make the cargo yard a FUN place to explore."
	annihilate = TRUE


//////////////////////////////////////////////////////////////
// Generic things and structures
/datum/map_template/outpost21/muriki/cargoyard/container_A
	name = "Container Variant A"
	desc = "Random container."
	mappath = 'maps/submaps/outpost21/cargoyard/container_A.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_B
	name = "Container Variant B"
	desc = "Random container."
	mappath = 'maps/submaps/outpost21/cargoyard/container_B.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_C
	name = "Container Variant C"
	desc = "Random container."
	mappath = 'maps/submaps/outpost21/cargoyard/container_C.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_D
	name = "Container Variant D"
	desc = "Random container."
	mappath = 'maps/submaps/outpost21/cargoyard/container_D.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/path_A
	name = "Path Variant A"
	desc = "Random path."
	mappath = 'maps/submaps/outpost21/cargoyard/path_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/path_B
	name = "Path Variant B"
	desc = "Random path."
	mappath = 'maps/submaps/outpost21/cargoyard/path_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_A
	name = "Light Variant A"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/cargoyard/light_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_B
	name = "Light Variant B"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/cargoyard/light_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_C
	name = "Light Variant C"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/cargoyard/light_C.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

//////////////////////////////////////////////////////////////
// Huge structures in the yard (usually one at a time...)

/datum/map_template/outpost21/muriki/cargoyard_huge/largeruin_A
	name = "Large Ruins Variant A"
	desc = "Random large ruins in the yard."
	mappath = 'maps/submaps/outpost21/cargoyard/largeruin_A.dmm'
	allow_duplicates = FALSE
	discard_prob = 30
	cost = 90

/datum/map_template/outpost21/muriki/cargoyard_huge/simple_A
	name = "Simple Yard Variant A"
	desc = "Random place in the yard."
	mappath = 'maps/submaps/outpost21/cargoyard/simple_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 30

//////////////////////////////////////////////////////////////
// Area definitions
/area/submap/outpost21/yard_generic
	name = "\improper Somewhere in the Yard"
	icon_state = "red2"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki

/area/submap/outpost21/yard_cargocontainer
	name = "\improper Inside Cargo Container"
	icon_state = "red"
	sound_env = SOUND_ENVIRONMENT_BATHROOM
	music = 'sound/ambience/ambiatm1.ogg'
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
