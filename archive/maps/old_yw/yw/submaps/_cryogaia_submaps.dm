// This causes tether submap maps to get 'checked' and compiled, when undergoing a unit test.
// This is so Travis can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.

//////////////////////////////////////////////////////////////////////////////
/// Static Load
#include "cryogaia_plains/cryogaia_plains.dm"
/datum/map_template/cryogaia_lateload/cryogaia_plains
	name = "Snow plains"
	desc = "The Borealis away mission."
	mappath = "maps/yw/submaps/cryogaia_plains/cryogaia_plains.dmm"
	annihilate = TRUE
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/cryogaia_plains

/datum/map_z_level/cryogaia_lateload/cryogaia_plains
	name = "Away Mission - Plains"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	base_turf = /turf/simulated/mineral/floor/
	z = Z_LEVEL_PLAINS

/datum/map_template/cryogaia_lateload/cryogaia_plains/on_map_loaded(z)
	. = ..()
	seed_submaps(list(Z_LEVEL_PLAINS), 240, /area/cryogaia/outpost/exploration_plains, /datum/map_template/surface/plains)

//////////////////////////////////////////////////////////////////////////////
/// Away Missions
#ifdef AWAY_MISSION_TEST
#include "cryogaia_plains/cryogaia_plains.dmm"
#include "beach/beach.dmm"
#include "beach/cave.dmm"
#include "alienship/alienship.dmm"
#include "aerostat/aerostat.dmm"
#include "aerostat/surface.dmm"
#include "space/debrisfield.dmm"
#include "space/fueldepot.dmm"
#include "space/guttersite.dmm"
#endif

#include "beach/_beach.dm"
/datum/map_template/cryogaia_lateload/away_beach
	name = "Desert Planet - Z1 Beach"
	desc = "The beach away mission."
	mappath = "maps/yw/submaps/beach/beach.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_beach

/datum/map_z_level/cryogaia_lateload/away_beach
	name = "Away Mission - Desert Beach"
	z = Z_LEVEL_BEACH

/datum/map_template/cryogaia_lateload/away_beach_cave
	name = "Desert Planet - Z2 Cave"
	desc = "The beach away mission's cave."
	mappath = "maps/yw/submaps/beach/cave.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_beach_cave

/datum/map_template/cryogaia_lateload/away_beach_cave/on_map_loaded(z)
	. = ..()
	seed_submaps(list(Z_LEVEL_BEACH_CAVE), 120, /area/tether_away/cave/unexplored/normal, /datum/map_template/surface/mountains/normal)
	//seed_submaps(list(Z_LEVEL_BEACH_CAVE), 70, /area/tether_away/cave/unexplored/normal, /datum/map_template/surface/mountains/deep)

	// Now for the tunnels.
	new /datum/random_map/automata/cave_system/no_cracks(null, 3, 3, Z_LEVEL_BEACH_CAVE, world.maxx - 4, world.maxy - 4)
	new /datum/random_map/noise/ore/beachmine(null, 1, 1, Z_LEVEL_BEACH_CAVE, 64, 64)

/datum/map_z_level/cryogaia_lateload/away_beach_cave
	name = "Away Mission - Desert Cave"
	z = Z_LEVEL_BEACH_CAVE

/obj/effect/step_trigger/zlevel_fall/beach
	var/static/target_z

#include "alienship/_alienship.dm"
/datum/map_template/cryogaia_lateload/away_alienship
	name = "Alien Ship - Z1 Ship"
	desc = "The alien ship away mission."
	mappath = "maps/yw/submaps/alienship/alienship.dmm"
	associated_map_datum = /datum/map_z_level/tether_lateload/away_alienship

/datum/map_z_level/tether_lateload/away_alienship
	name = "Away Mission - Alien Ship"

#include "aerostat/_aerostat.dm"
/datum/map_template/cryogaia_lateload/away_aerostat
	name = "Remmi Aerostat - Z1 Aerostat"
	desc = "The Virgo 2 Aerostat away mission."
	mappath = "maps/yw/submaps/aerostat/aerostat.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_aerostat

/datum/map_z_level/cryogaia_lateload/away_aerostat
	name = "Away Mission - Aerostat"
	z = Z_LEVEL_AEROSTAT

/datum/map_template/cryogaia_lateload/away_aerostat_surface
	name = "Remmi Aerostat - Z2 Surface"
	desc = "The surface from the Virgo 2 Aerostat."
	mappath = "maps/yw/submaps/aerostat/surface.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_aerostat_surface

/datum/map_template/cryogaia_lateload/away_aerostat_surface/on_map_loaded(z)
	. = ..()
	seed_submaps(list(Z_LEVEL_AEROSTAT_SURFACE), 120, /area/cryogaia_away/aerostat/surface/unexplored, /datum/map_template/virgo2)
	new /datum/random_map/automata/cave_system/no_cracks(null, 3, 3, Z_LEVEL_AEROSTAT_SURFACE, world.maxx - 4, world.maxy - 4)
	new /datum/random_map/noise/ore/bor4(null, 1, 1, Z_LEVEL_AEROSTAT_SURFACE, 64, 64)

/datum/map_z_level/cryogaia_lateload/away_aerostat_surface
	name = "Away Mission - Aerostat Surface"
	z = Z_LEVEL_AEROSTAT_SURFACE


#include "space/_debrisfield.dm"
#include "space/_fueldepot.dm"
#include "space/pois/_templates.dm"
#include "space/pois/debrisfield_things.dm"
#include "space/_guttersite.dm"
/datum/map_template/cryogaia_lateload/away_debrisfield
	name = "Debris Field - Z1 Space"
	desc = "The Virgo 3 Debris Field away mission."
	mappath = "maps/yw/submaps/space/debrisfield.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_debrisfield

/datum/map_template/cryogaia_lateload/away_debrisfield/on_map_loaded(z)
	. = ..()
	//Commented out until we actually get POIs
	seed_submaps(list(Z_LEVEL_DEBRISFIELD), 200, /area/tether_away/debrisfield/unexplored, /datum/map_template/debrisfield)

/datum/map_z_level/cryogaia_lateload/away_debrisfield
	name = "Away Mission - Debris Field"
	z = Z_LEVEL_DEBRISFIELD

/datum/map_template/cryogaia_lateload/away_fueldepot
	name = "Fuel Depot - Z1 Space"
	desc = "An unmanned fuel depot floating in space."
	mappath = "maps/yw/submaps/space/fueldepot.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_fueldepot

/datum/map_z_level/cryogaia_lateload/away_fueldepot
	name = "Away Mission - Fuel Depot"
	z = Z_LEVEL_FUELDEPOT

/datum/map_template/cryogaia_lateload/away_guttersite
	name = "Gutter Site - Z1 Space"
	desc = "The Virgo Erigone Space Away Site."
	mappath = "maps/yw/submaps/space/guttersite.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/away_guttersite

/datum/map_z_level/cryogaia_lateload/away_guttersite
	name = "Away Mission - Gutter Site"
	z = Z_LEVEL_GUTTERSITE

//////////////////////////////////////////////////////////////////////////////////////
// Admin-use z-levels for loading whenever an admin feels like
#ifdef AWAY_MISSION_TEST
#include "admin_use/spa.dmm"
#endif

#include "admin_use/fun.dm"
/datum/map_template/cryogaia_lateload/fun/spa
	name = "Space Spa"
	desc = "A pleasant spa located in a spaceship."
	mappath = "maps/yw/submaps/admin_use/spa.dmm"

	associated_map_datum = /datum/map_z_level/cryogaia_lateload/fun/spa

/datum/map_z_level/cryogaia_lateload/fun/spa
	name = "Spa"
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_SEALED

//////////////////////////////////////////////////////////////////////////////////////
// Code Shenanigans for Tether lateload maps
/datum/map_template/cryogaia_lateload
	allow_duplicates = FALSE
	var/associated_map_datum

/datum/map_template/cryogaia_lateload/on_map_loaded(z)
	if(!associated_map_datum || !ispath(associated_map_datum))
		log_game("Extra z-level [src] has no associated map datum")
		return

	new associated_map_datum(using_map, z)

/datum/map_z_level/cryogaia_lateload
	z = 0
	flags = MAP_LEVEL_SEALED

/datum/map_z_level/cryogaia_lateload/New(var/datum/map/map, mapZ)
	if(mapZ && !z)
		z = mapZ
	return ..(map)

/turf/unsimulated/wall/seperator //to block vision between transit zones
	name = ""
	icon = 'icons/effects/effects.dmi'
	icon_state = "1"

/obj/effect/step_trigger/zlevel_fall //Don't ever use this, only use subtypes.Define a new var/static/target_z on each
	affect_ghosts = 1

/obj/effect/step_trigger/zlevel_fall/Initialize(mapload)
	. = ..()

	if(istype(get_turf(src), /turf/simulated/floor))
		src:target_z = z
		return INITIALIZE_HINT_QDEL

/obj/effect/step_trigger/zlevel_fall/Trigger(var/atom/movable/A) //mostly from /obj/effect/step_trigger/teleporter/planetary_fall, step_triggers.dm L160
	if(!src:target_z)
		return

	var/attempts = 100
	var/turf/simulated/T
	while(attempts && !T)
		var/turf/simulated/candidate = locate(rand(5,world.maxx-5),rand(5,world.maxy-5),src:target_z)
		if(candidate.density)
			attempts--
			continue

		T = candidate
		break

	if(!T)
		return

	if(isobserver(A))
		A.forceMove(T) // Harmlessly move ghosts.
		return

	A.forceMove(T)
	if(isliving(A)) // Someday, implement parachutes.  For now, just turbomurder whoever falls.
		message_admins("\The [A] fell out of the sky.")
		var/mob/living/L = A
		L.fall_impact(T, 42, 90, FALSE, TRUE)	//You will not be defibbed from this.

/////////////////////////////
/obj/cryogaia_away_spawner
	name = "RENAME ME, JERK"
	desc = "Spawns the mobs!"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	invisibility = INVISIBILITY_ABSTRACT
	mouse_opacity = 0
	density = 0
	anchored = 1

	//Weighted with values (not %chance, but relative weight)
	//Can be left value-less for all equally likely
	var/list/mobs_to_pick_from

	//When the below chance fails, the spawner is marked as depleted and stops spawning
	var/prob_spawn = 100	//Chance of spawning a mob whenever they don't have one
	var/prob_fall = 5		//Above decreases by this much each time one spawns

	//Settings to help mappers/coders have their mobs do what they want in this case
	var/faction				//To prevent infighting if it spawns various mobs, set a faction
	var/atmos_comp			//TRUE will set all their survivability to be within 20% of the current air
	//var/guard				//# will set the mobs to remain nearby their spawn point within this dist

	//Internal use only
	var/mob/living/simple_mob/my_mob
	var/depleted = FALSE

/obj/cryogaia_away_spawner/Initialize(mapload)
	. = ..()

	if(!LAZYLEN(mobs_to_pick_from))
		error("Mob spawner at [x],[y],[z] ([get_area(src)]) had no mobs_to_pick_from set on it!")
		initialized = TRUE
		return INITIALIZE_HINT_QDEL
	START_PROCESSING(SSobj, src)

/obj/cryogaia_away_spawner/process()
	if(my_mob && my_mob.stat != DEAD)
		return //No need

	if(LAZYLEN(loc.human_mobs(world.view)))
		return //I'll wait.

	if(prob(prob_spawn))
		prob_spawn -= prob_fall
		var/picked_type = pickweight(mobs_to_pick_from)
		my_mob = new picked_type(get_turf(src))
		my_mob.low_priority = TRUE

		if(faction)
			my_mob.faction = faction

		if(atmos_comp)
			var/turf/T = get_turf(src)
			var/datum/gas_mixture/env = T.return_air()
			if(env)
				my_mob.minbodytemp = env.temperature * 0.8
				my_mob.maxbodytemp = env.temperature * 1.2

				var/list/gaslist = env.gas
				my_mob.min_oxy = gaslist[GAS_O2] * 0.8
				my_mob.min_tox = gaslist[GAS_PHORON] * 0.8
				my_mob.min_n2 = gaslist[GAS_N2] * 0.8
				my_mob.min_co2 = gaslist[GAS_CO2] * 0.8
				my_mob.max_oxy = gaslist[GAS_O2] * 1.2
				my_mob.max_tox = gaslist[GAS_PHORON] * 1.2
				my_mob.max_n2 = gaslist[GAS_N2] * 1.2
				my_mob.max_co2 = gaslist[GAS_CO2] * 1.2
/* //VORESTATION AI TEMPORARY REMOVAL
		if(guard)
			my_mob.returns_home = TRUE
			my_mob.wander_distance = guard
*/
		return
	else
		STOP_PROCESSING(SSobj, src)
		depleted = TRUE
		return

//Shadekin spawner. Could have them show up on any mission, so it's here.
//Make sure to put them away from others, so they don't get demolished by rude mobs.
/obj/cryogaia_away_spawner/shadekin
	name = "Shadekin Spawner"
	icon = 'icons/mob/vore_shadekin.dmi'
	icon_state = "spawner"

	faction = "shadekin"
	prob_spawn = 1
	prob_fall = 1
	//guard = 10 //Don't wander too far, to stay alive.
	mobs_to_pick_from = list(
		/mob/living/simple_mob/shadekin
	)

#include "admin_ships/adminship.dm"

//////////////////////////////////////////////////////////////////////////////////////
// Gateway submaps go here

/obj/effect/overmap/visitable/sector/cryogaia_gateway
	name = "Unknown"
	desc = "Approach and perform a scan to obtain further information."
	icon_state = "object" //or "globe" for planetary stuff
	known = FALSE
	//initial_generic_waypoints = list("don't forget waypoints!")
	var/true_name = "The scanned name goes here"
	var/true_desc = "The scanned desc goes here"

/obj/effect/overmap/visitable/sector/cryogaia_gateway/get_scan_data(mob/user)
	name = true_name
	desc = true_desc
	return ..()

/datum/map_template/cryogaia_lateload/gateway
	name = "Gateway Submap"
	desc = "Please do not use this."
	mappath = null
	associated_map_datum = null

/datum/map_z_level/cryogaia_lateload/gateway_destination
	name = "Gateway Destination"
	z = Z_LEVEL_GATEWAY

#include "gateway/snow_outpost.dm"
/datum/map_template/cryogaia_lateload/gateway/snow_outpost
	name = "Snow Outpost"
	desc = "Big snowy area with various outposts."
	mappath = "maps/yw/submaps/gateway/snow_outpost.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/gateway_destination

#include "gateway/zoo.dm"
/datum/map_template/cryogaia_lateload/gateway/zoo
	name = "Zoo"
	desc = "Gigantic space zoo"
	mappath = "maps/yw/submaps/gateway/zoo.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/gateway_destination

#include "gateway/carpfarm.dm"
/datum/map_template/cryogaia_lateload/gateway/carpfarm
	name = "Carp Farm"
	desc = "Asteroid base surrounded by carp"
	mappath = "maps/yw/submaps/gateway/carpfarm.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/gateway_destination

#include "gateway/snowfield.dm"
/datum/map_template/cryogaia_lateload/gateway/snowfield
	name = "Snow Field"
	desc = "An old base in middle of snowy wasteland"
	mappath = "maps/yw/submaps/gateway/snowfield.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/gateway_destination

#include "gateway/listeningpost.dm"
/datum/map_template/cryogaia_lateload/gateway/listeningpost
	name = "Listening Post"
	desc = "Asteroid-bound mercenary listening post"
	mappath = "maps/yw/submaps/gateway/listeningpost.dmm"
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/gateway_destination

//////////////////////////////////////////////////////////////////////////////
//Rogue Mines Stuff

/datum/map_template/cryogaia_lateload/cryogaia_roguemines1
	name = "Asteroid Belt 1"
	desc = "Mining, but rogue. Zone 1"
	mappath = "maps/yw/submaps/rogue_mines/rogue_mine1.dmm"

	associated_map_datum = /datum/map_z_level/cryogaia_lateload/roguemines1

/datum/map_z_level/cryogaia_lateload/roguemines1
	name = "Belt 1"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_1

/datum/map_template/cryogaia_lateload/cryogaia_roguemines2
	name = "Asteroid Belt 2"
	desc = "Mining, but rogue. Zone 2"
	mappath = "maps/yw/submaps/rogue_mines/rogue_mine2.dmm"

	associated_map_datum = /datum/map_z_level/cryogaia_lateload/roguemines2

/datum/map_z_level/cryogaia_lateload/roguemines2
	name = "Belt 2"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_2

/datum/map_template/cryogaia_lateload/cryogaia_roguemines3
	name = "Asteroid Belt 3"
	desc = "Mining, but rogue. Zone 3"
	mappath = "maps/yw/submaps/rogue_mines/rogue_mine3.dmm"

	associated_map_datum = /datum/map_z_level/cryogaia_lateload/roguemines3

/datum/map_z_level/cryogaia_lateload/roguemines3
	name = "Belt 3"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_3

/datum/map_template/cryogaia_lateload/cryogaia_roguemines4
	name = "Asteroid Belt 4"
	desc = "Mining, but rogue. Zone 4"
	mappath = "maps/yw/submaps/rogue_mines/rogue_mine4.dmm"

	associated_map_datum = /datum/map_z_level/cryogaia_lateload/roguemines4

/datum/map_z_level/cryogaia_lateload/roguemines4
	name = "Belt 4"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_4

//////////////////////////////////////////////////////////////////////////////
