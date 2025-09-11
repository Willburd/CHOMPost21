// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#ifdef MAP_TEST
#include "chunk_A.dmm"
#include "chunk_B.dmm"
#include "chunk_C.dmm"
#include "chunk_D.dmm"
#include "chunk_E.dmm"
#include "chunk_F.dmm"
#include "scaff_A.dmm"
#include "scaff_B.dmm"
#include "scaff_C.dmm"
#include "structure_A.dmm"
#include "giant_asteroid_A.dmm"
#include "giant_asteroid_B.dmm"
#include "giant_asteroid_C.dmm"
#include "giant_asteroid_D.dmm"
#include "giant_asteroid_E.dmm"
#include "giant_asteroid_F.dmm"
#include "structure_A.dmm"
#include "platform_A.dmm"
#include "survpod_a.dmm"
#include "container_LOST.dmm"
#include "lost_ship_A.dmm"
#include "lost_ship_B.dmm"
#include "container_C.dmm"
#include "alienship_A.dmm"
#include "diona_A.dmm"
#include "delight_A.dmm"
#include "delight_B.dmm"
#include "bear_A"
#endif

/datum/map_template/outpost21/space/orbitalyard
	name = "Space Content - Spooce"
	desc = "Used to fill extra space to explore in the orbital yard."
	annihilate = TRUE

/datum/map_template/outpost21/space/orbitalyard_huge
	name = "Space Content - Thats no moon"
	desc = "Used to make the orbital yard a FUN place to explore."
	annihilate = TRUE


//////////////////////////////////////////////////////////////
// Generic floating junk
/datum/map_template/outpost21/space/orbitalyard/chunk_A
	name = "Asteroid Variant A"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_A.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_B
	name = "Asteroid Variant B"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_B.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_C
	name = "Asteroid Variant C"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_C.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_D
	name = "Asteroid Variant D"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_D.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_E
	name = "Asteroid Variant E"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_E.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_F
	name = "Asteroid Variant F"
	desc = "Random asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/chunk_F.dmm"
	allow_duplicates = TRUE
	cost = 15

/datum/map_template/outpost21/space/orbitalyard/scaff_A
	name = "Scaffolding Variant A"
	desc = "Random construction."
	mappath = "modular_outpost/maps/submaps/orbitalyard/scaff_A.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/scaff_B
	name = "Scaffolding Variant B"
	desc = "Random construction."
	mappath = "modular_outpost/maps/submaps/orbitalyard/scaff_B.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/scaff_C
	name = "Scaffolding Variant C"
	desc = "Random construction."
	mappath = "modular_outpost/maps/submaps/orbitalyard/scaff_C.dmm"
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/platform_A
	name = "Platform Variant A"
	desc = "Random platform."
	mappath = "modular_outpost/maps/submaps/orbitalyard/platform_A.dmm"
	allow_duplicates = TRUE
	cost = 2

/datum/map_template/outpost21/space/orbitalyard/lostshelter
	name = "Lost survival pod 1"
	desc = "Abandoned survival pod"
	mappath = "modular_outpost/maps/submaps/orbitalyard/survpod_a.dmm"
	allow_duplicates = TRUE
	discard_prob = 65
	cost = 2


/datum/map_template/outpost21/space/orbitalyard/container_LOST
	name = "Lost Container"
	desc = "Random platform."
	mappath = "modular_outpost/maps/submaps/orbitalyard/container_LOST.dmm"
	allow_duplicates = TRUE
	discard_prob = 5
	cost = 2

/datum/map_template/outpost21/space/orbitalyard/container_C
	name = "Lost Contraband Container"
	desc = "Random platform."
	mappath = "modular_outpost/maps/submaps/orbitalyard/container_C.dmm"
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 4

/datum/map_template/outpost21/space/orbitalyard/bear_A
	name = "Space bear asteroid cluster"
	desc = "Random asteroid with a bear"
	mappath = "modular_outpost/maps/submaps/orbitalyard/bear_A.dmm"
	allow_duplicates = FALSE
	cost = 15

//////////////////////////////////////////////////////////////
// Huge structures in the yard (usually one at a time...)
/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_A
	name = "Giant Asteroid Variant A"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_A.dmm"
	allow_duplicates = TRUE
	cost = 20

/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_B
	name = "Giant Asteroid Variant B"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_B.dmm"
	allow_duplicates = FALSE // has secret in it
	cost = 20

/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_C
	name = "Giant Asteroid Variant C"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_C.dmm"
	allow_duplicates = TRUE
	cost = 10

/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_D
	name = "Giant Asteroid Variant D"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_D.dmm"
	allow_duplicates = TRUE
	cost = 30

/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_E
	name = "Giant Asteroid Variant E"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_E.dmm"
	allow_duplicates = TRUE
	cost = 10

/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_F
	name = "Giant Asteroid Variant F"
	desc = "Random Giant asteroid."
	mappath = "modular_outpost/maps/submaps/orbitalyard/giant_asteroid_F.dmm"
	allow_duplicates = TRUE
	cost = 10

/datum/map_template/outpost21/space/orbitalyard_huge/structure_A
	name = "Structure Variant A"
	desc = "Destroyed ruins of a facility."
	mappath = "modular_outpost/maps/submaps/orbitalyard/structure_A.dmm"
	allow_duplicates = FALSE
	cost = 55

/datum/map_template/outpost21/space/orbitalyard_huge/structure_B
	name = "Structure Variant B"
	desc = "Destroyed ruins of a facility."
	mappath = "modular_outpost/maps/submaps/orbitalyard/structure_B.dmm"
	allow_duplicates = FALSE
	cost = 55

/datum/map_template/outpost21/space/orbitalyard_huge/lostship_A
	name = "Lost Ship Variant A"
	desc = "An old derelict ship"
	mappath = "modular_outpost/maps/submaps/orbitalyard/lost_ship_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 10
	cost = 50

/datum/map_template/outpost21/space/orbitalyard_huge/lostship_B
	name = "Lost Ship Variant B"
	desc = "An old derelict ship"
	mappath = "modular_outpost/maps/submaps/orbitalyard/lost_ship_B.dmm"
	allow_duplicates = FALSE
	discard_prob = 10
	cost = 55

/datum/map_template/outpost21/space/orbitalyard_huge/alienship_A
	name = "Abandoned Alien Vessel"
	desc = "An old derelict ship"
	mappath = "modular_outpost/maps/submaps/orbitalyard/alienship_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 55
	cost = 80

/datum/map_template/outpost21/space/orbitalyard_huge/diona_A
	name = "Diona Vessel"
	desc = "An organic mass"
	mappath = "modular_outpost/maps/submaps/orbitalyard/diona_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 55
	cost = 80

/datum/map_template/outpost21/space/orbitalyard_huge/delight_A
	name = "Derelict Vessel"
	desc = "The remains of time long past"
	mappath = "modular_outpost/maps/submaps/orbitalyard/delight_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 55
	cost = 80

/datum/map_template/outpost21/space/orbitalyard_huge/delight_B
	name = "Derelict Vessel"
	desc = "The remains of time long past"
	mappath = "modular_outpost/maps/submaps/orbitalyard/delight_B.dmm"
	allow_duplicates = FALSE
	discard_prob = 55
	cost = 80

//////////////////////////////////////////////////////////////
// Area definitions
/area/submap/outpost21/asteroid_generic
	name = "\improper Asteroids"
	icon_state = "red2"
	has_gravity = 0
	ambience = AMBIENCE_OUTPOST21_SPACE
	base_turf = /turf/space
	always_unpowered = TRUE

/area/submap/outpost21/asteroid_generic/get_gravity()
	return 0

/area/submap/outpost21/structure_generic
	name = "\improper Ruined Facility"
	icon_state = "red2"
	has_gravity = 0
	ambience = AMBIENCE_OUTPOST21_SPACE
	base_turf = /turf/space
	always_unpowered = TRUE

/area/submap/outpost21/structure_generic/get_gravity()
	return 0

/area/submap/outpost21/structure_generic/lostshipa
	name = "\improper Abandoned Vessel"
	always_unpowered = FALSE

/area/submap/outpost21/structure_generic/lostshipb
	name = "\improper Abandoned Vessel"
	always_unpowered = FALSE

/area/submap/outpost21/structure_generic/lostpod
	name = "\improper Lost Survival Pod"
	always_unpowered = FALSE

/area/submap/outpost21/structure_generic/alienshipa
	name = "\improper Alien Vessel"
	requires_power = FALSE
	always_unpowered = FALSE

/area/submap/outpost21/structure_generic/delight_ruins
	name = "\improper Derelict Vessel"
	always_unpowered = FALSE
