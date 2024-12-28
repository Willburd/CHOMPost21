// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#ifdef MAP_TEST
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
#include "crashed_ufo.dmm"
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
	mappath = "modular_outpost/maps/submaps/deepdark/light_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/light_B
	name = "Light Variant B"
	desc = "Random light."
	mappath = "modular_outpost/maps/submaps/deepdark/light_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/light_C
	name = "Light Variant C"
	desc = "Random light."
	mappath = "modular_outpost/maps/submaps/deepdark/light_C.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/gas_A
	name = "Gas Pocket Variant A"
	desc = "Random gas pocket."
	mappath = "modular_outpost/maps/submaps/deepdark/gas_pocket_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/gas_B
	name = "Gas Pocket Variant B"
	desc = "Random gas pocket."
	mappath = "modular_outpost/maps/submaps/deepdark/gas_pocket_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 50
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/gas_C
	name = "Gas Pocket Variant C"
	desc = "Random gas pocket."
	mappath = "modular_outpost/maps/submaps/deepdark/gas_pocket_C.dmm"
	allow_duplicates = TRUE
	discard_prob = 50
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_A
	name = "Flesh Variant A"
	desc = "flesh varient."
	mappath = "modular_outpost/maps/submaps/deepdark/flesh_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_B
	name = "Flesh Variant B"
	desc = "flesh varient."
	mappath = "modular_outpost/maps/submaps/deepdark/flesh_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark/den_A
	name = "Den A"
	desc = "Random den."
	mappath = "modular_outpost/maps/submaps/deepdark/den_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/den_B
	name = "Den B"
	desc = "Random den."
	mappath = "modular_outpost/maps/submaps/deepdark/den_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 40
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/trap_A
	name = "Trap A"
	desc = "Random trap."
	mappath = "modular_outpost/maps/submaps/deepdark/trap_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/lava_A
	name = "Lava A"
	desc = "Random lava."
	mappath = "modular_outpost/maps/submaps/deepdark/lava_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/lava_B
	name = "Lava B"
	desc = "Random lava."
	mappath = "modular_outpost/maps/submaps/deepdark/lava_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

//////////////////////////////////////////////////////////////
// Huge structures in the cave
/datum/map_template/outpost21/muriki/caves_deepdark_huge/cave_A
	name = "Cave A"
	desc = "Random cave."
	mappath = "modular_outpost/maps/submaps/deepdark/cave_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/cave_B
	name = "Cave B"
	desc = "Random cave."
	mappath = "modular_outpost/maps/submaps/deepdark/cave_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hall_A
	name = "Hall A"
	desc = "Random cave hall."
	mappath = "modular_outpost/maps/submaps/deepdark/hall_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hall_B
	name = "Hall B"
	desc = "Random cave hall."
	mappath = "modular_outpost/maps/submaps/deepdark/hall_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 10
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/lake_A
	name = "Lake A"
	desc = "Random cave lake."
	mappath = "modular_outpost/maps/submaps/deepdark/lake_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 20
	cost = 25

/datum/map_template/outpost21/muriki/caves_deepdark_huge/wall_A
	name = "Wall A"
	desc = "Random cave maint wall."
	mappath = "modular_outpost/maps/submaps/deepdark/wall_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark_huge/wall_B
	name = "Wall B"
	desc = "Random cave maint wall."
	mappath = "modular_outpost/maps/submaps/deepdark/wall_B.dmm"
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark_huge/honk_A
	name = "Honk A"
	desc = "Random honk."
	mappath = "modular_outpost/maps/submaps/deepdark/honk_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/spider_A
	name = "Spider A"
	desc = "Random spiders."
	mappath = "modular_outpost/maps/submaps/deepdark/spider_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_A
	name = "Liminal A"
	desc = "Random liminal space."
	mappath = "modular_outpost/maps/submaps/deepdark/liminal_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_B
	name = "Liminal B"
	desc = "Random liminal space."
	mappath = "modular_outpost/maps/submaps/deepdark/liminal_B.dmm"
	allow_duplicates = FALSE // DO NOT SPAWN TWICE, has a controller effect for the area...
	discard_prob = 20
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/liminal_C
	name = "Liminal C"
	desc = "Random liminal space."
	mappath = "modular_outpost/maps/submaps/deepdark/liminal_C.dmm"
	allow_duplicates = TRUE
	discard_prob = 40
	cost = 10

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_A
	name = "Red A"
	desc = "Random redspace leak."
	mappath = "modular_outpost/maps/submaps/deepdark/redspace_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_B
	name = "Red B"
	desc = "Random redspace leak."
	mappath = "modular_outpost/maps/submaps/deepdark/redspace_B.dmm"
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/redspace_C
	name = "Red C"
	desc = "Random redspace leak."
	mappath = "modular_outpost/maps/submaps/deepdark/redspace_C.dmm"
	allow_duplicates = FALSE
	discard_prob = 50
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/statue_A
	name = "statue A"
	desc = "Random statue."
	mappath = "modular_outpost/maps/submaps/deepdark/statue_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 85
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/hole_A
	name = "hole A"
	desc = "Random hole."
	mappath = "modular_outpost/maps/submaps/deepdark/hole_A.dmm"
	allow_duplicates = FALSE
	discard_prob = 75
	cost = 30

/datum/map_template/outpost21/muriki/caves_deepdark_huge/biohazard_A
	name = "biohazard A"
	desc = "Random biohazard."
	mappath = "modular_outpost/maps/submaps/deepdark/biohazard_A.dmm"
	allow_duplicates = TRUE
	discard_prob = 75
	cost = 20

/datum/map_template/outpost21/muriki/caves_deepdark_huge/crashed_ufo
	name = "crashed ufo"
	desc = "Crashed ufo."
	mappath = "modular_outpost/maps/submaps/deepdark/crashed_ufo.dmm"
	allow_duplicates = FALSE
	discard_prob = 55
	cost = 20

//////////////////////////////////////////////////////////////
// Area definitions
/area/mine/explored/muriki/cave/deepdark
	name = "\improper Muriki Underground"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "orange"
	always_unpowered = TRUE
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FORBID_EVENTS
	haunted = TRUE
/area/mine/unexplored/muriki/cave/deepdark
	name = "\improper Muriki Underground"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "yellow"
	always_unpowered = TRUE
	flags = AREA_BLOCK_GHOST_SIGHT | AREA_FORBID_EVENTS
	haunted = TRUE

/area/submap/outpost21/cave_liminal_A
	name = "\improper Come Closer"
	icon_state = "red2"
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	sound_env = SOUND_ENVIRONMENT_PSYCHOTIC
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki
	haunted = TRUE

/area/submap/outpost21/cave_liminal_B
	name = "\improper GET OUT"
	var/show_name = "GET OUT" // replaces name
	icon_state = "red2"
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	always_unpowered = FALSE
	requires_power = FALSE
	sound_env = SOUND_ENVIRONMENT_AUDITORIUM
	ambience = AMBIENCE_MAINTENANCE
	base_turf = /turf/simulated/mineral/floor/muriki
	haunted = TRUE

/area/submap/outpost21/cave_liminal_B/get_name()
	return show_name

/area/submap/outpost21/cave_red_A
	name = "\improper Our Pulsing Mass"
	icon_state = "red2"
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki
	haunted = TRUE

/area/submap/outpost21/cave_red_B
	name = "\improper Inside Us"
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	icon_state = "red2"
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki
	haunted = TRUE

/area/submap/outpost21/cave_red_C
	name = "\improper Touch Our Skin"
	icon_state = "red2"
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	sound_env = SOUND_ENVIRONMENT_CAVE
	ambience = AMBIENCE_OTHERWORLDLY
	base_turf = /turf/simulated/mineral/floor/muriki
	haunted = TRUE

/area/submap/outpost21/crashed_ufo
	name = "\improper Unknown"
	requires_power = FALSE
	flags = AREA_FLAG_IS_NOT_PERSISTENT | AREA_FORBID_EVENTS | AREA_SECRET_NAME | AREA_BLOCK_GHOST_SIGHT
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = SOUND_ENVIRONMENT_STONEROOM
	ambience = AMBIENCE_OTHERWORLDLY

//////////////////////////////////////////////////////////////
// Liminal area specialty controllers
/obj/effect/map_effect/interval/liminal_B_controller
	name = "liminal B controller"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 5 SECONDS
	interval_upper_bound = 20 SECONDS

/obj/effect/map_effect/interval/liminal_B_controller/trigger()
	var/area/submap/outpost21/cave_liminal_B/A = get_area(src)
	if(!istype(A,/area/submap/outpost21/cave_liminal_B))
		return
	// Do not edit name directly, it mulches the warp to area list
	A.show_name = pick("GET OUT","I HATE YOU","GET OUT OF ME","I FEEL YOU INSIDE ME","GET OUT","IT HURTS","LEAVE LEAVE LEAVE LEAVE","GET OUT GET OUT GET OUT GET OUT")
	if(prob(5))
		for(var/mob/living/L in range(10, get_turf(src)))
			if(!L)
				continue
			if(prob(10))
				L.adjustOxyLoss(rand(23,37),TRUE)
			else if(prob(50))
				L.adjustBruteLoss(rand(3,7),TRUE)
			else
				L.adjustFireLoss(rand(3,7),TRUE)


//////////////////////////////////////////////////////////////
// Liminal area specialty deathdrops
/turf/simulated/deathdrop/liminal
	death_message = "You pass into the empty darkness ahead of you, and fall into another repeating room. There is no way back. You cease to exist in the world you once called home. Now there is only the same room, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over, over and over..."

/turf/simulated/deathdrop/liminal_home_pit
	death_message = "The wind rushes past you as you fall into the darkness... Then you wake up."

/turf/simulated/deathdrop/liminal_home_pit/Entered(atom/A)
	spawn(0)
		if(A.is_incorporeal())
			return
		if(istype( A, /atom/movable))
			var/atom/movable/AM = A
			if(!AM.can_fall()) // flying checks
				return
		if(ismob( A))
			var/mob/M = A
			var/list/redexitlist = list()
			for(var/obj/effect/landmark/R in landmarks_list)
				if(R.name == "redexit")
					redexitlist += R

			if(redexitlist.len > 0)
				var/obj/effect/landmark/L = pick( redexitlist)
				do_teleport(M, L.loc, 0,local = FALSE)
				to_chat( A, span_danger(death_message))
				// passout on return to reality
				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					H.AdjustSleeping(15)
					H.AdjustWeakened(3)
					H.adjustHalLoss(-9)
