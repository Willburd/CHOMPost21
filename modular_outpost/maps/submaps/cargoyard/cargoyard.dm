// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#ifdef MAP_TEST
#include "container_A.dmm"
#include "container_B.dmm"
#include "container_C.dmm"
#include "container_D.dmm"
#include "container_E.dmm"
#include "container_F.dmm"
#include "container_G.dmm"
#include "container_H.dmm"
#include "container_I.dmm"
#include "path_A.dmm"
#include "path_B.dmm"
#include "den_A.dmm"
#include "light_A.dmm"
#include "light_B.dmm"
#include "light_C.dmm"
#include "largeruin_A.dmm"
#include "simple_A.dmm"
#include "sinkhole_A.dmm"
#include "sinkhole_B.dmm"
#include "pond_A.dmm"
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
	mappath = "modular_outpost/maps/submaps/cargoyard/container_A.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_B
	name = "Container Variant B"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_B.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_C
	name = "Container Variant C"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_C.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_D
	name = "Container Variant D"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_D.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/container_E
	name = "Container Variant E"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_E.dmm"
	allow_duplicates = TRUE
	cost = 7 //slightly higher cut it's got some nice stuff. Makes it a bit more rare

/datum/map_template/outpost21/muriki/cargoyard/container_F
	name = "Container Variant F"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_F.dmm"
	allow_duplicates = TRUE
	cost = 4 //little lower, cuz its kindof crap intentionally.

/datum/map_template/outpost21/muriki/cargoyard/container_G
	name = "Container Variant G"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_G.dmm"
	allow_duplicates = TRUE
	cost = 7

/datum/map_template/outpost21/muriki/cargoyard/container_H
	name = "Container Variant H"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_H.dmm"
	allow_duplicates = TRUE
	cost = 5
	discard_prob = 70

/datum/map_template/outpost21/muriki/cargoyard/container_I
	name = "Container Variant I"
	desc = "Random container."
	mappath = "modular_outpost/maps/submaps/cargoyard/container_I.dmm"
	allow_duplicates = TRUE
	cost = 5
	discard_prob = 60

/datum/map_template/outpost21/muriki/cargoyard/path_A
	name = "Path Variant A"
	desc = "Random path."
	mappath = "modular_outpost/maps/submaps/cargoyard/path_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/path_B
	name = "Path Variant B"
	desc = "Random path."
	mappath = "modular_outpost/maps/submaps/cargoyard/path_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_A
	name = "Light Variant A"
	desc = "Random light."
	mappath = "modular_outpost/maps/submaps/cargoyard/light_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_B
	name = "Light Variant B"
	desc = "Random light."
	mappath = "modular_outpost/maps/submaps/cargoyard/light_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/light_C
	name = "Light Variant C"
	desc = "Random light."
	mappath = "modular_outpost/maps/submaps/cargoyard/light_C.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/cargoyard/den_A
	name = "Den Variant A"
	desc = "Random creature den."
	mappath = "modular_outpost/maps/submaps/cargoyard/den_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 70
	cost = 5

//////////////////////////////////////////////////////////////
// Huge structures in the yard (usually one at a time...)

/datum/map_template/outpost21/muriki/cargoyard_huge/largeruin_A
	name = "Large Ruins Variant A"
	desc = "Random large ruins in the yard."
	mappath = "modular_outpost/maps/submaps/cargoyard/largeruin_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 30
	cost = 90

/datum/map_template/outpost21/muriki/cargoyard_huge/simple_A
	name = "Simple Yard Variant A"
	desc = "Random place in the yard."
	mappath = "modular_outpost/maps/submaps/cargoyard/simple_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 30

/datum/map_template/outpost21/muriki/cargoyard_huge/sinkhole_A
	name = "Sinkhole Variant A"
	desc = "Random place in the yard."
	mappath = "modular_outpost/maps/submaps/cargoyard/sinkhole_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 20

/datum/map_template/outpost21/muriki/cargoyard_huge/sinkhole_B
	name = "Sinkhole Variant B"
	desc = "Random place in the yard."
	mappath = "modular_outpost/maps/submaps/cargoyard/sinkhole_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 20

/datum/map_template/outpost21/muriki/cargoyard_huge/pond_A
	name = "Pond Variant B"
	desc = "Random place in the yard."
	mappath = "modular_outpost/maps/submaps/cargoyard/pond_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 70
	cost = 10

//////////////////////////////////////////////////////////////
// Area definitions
/area/submap/outpost21/yard_generic
	name = "\improper Somewhere in the Yard"
	icon_state = "red2"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki

/area/submap/outpost21/yard_cargocontainer
	name = "\improper Inside Cargo Container"
	icon_state = "red"
	sound_env = SOUND_ENVIRONMENT_BATHROOM
	music = 'sound/ambience/ambiatm1.ogg'
	ambience = AMBIENCE_FOREBODING
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	color_grading = COLORTINT_DARK
