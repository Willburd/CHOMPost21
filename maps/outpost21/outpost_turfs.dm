//Simulated
/turf/simulated/open/muriki
	edge_blending_priority = 0.5 //Turfs which also have e_b_p and higher than this will plop decorative edges onto this turf
/turf/simulated/open/muriki/New()
	..()
	if(outdoors)
		SSplanets.addTurf(src)

/turf/simulated/open
	dynamic_lighting = 1 //I don't care if there's no true multiz lighting, this looks so much nicer it's not even funny -KK (from turf_yw)

/turf/simulated/floor/indoorrocks //Not outdoor rocks to prevent weather fuckery
	name = "rocks"
	desc = "Hard as a rock."
	icon = 'icons/turf/outdoors.dmi'
	icon_state = "rock"
	edge_blending_priority = 1

/turf/simulated/mineral/vacuum
	oxygen = 0
	nitrogen = 0
	temperature	= TCMB
/turf/simulated/mineral/floor/vacuum
	oxygen = 0
	nitrogen = 0
	temperature	= TCMB
/turf/simulated/floor/shuttle/black
	icon = 'icons/turf/shuttle_white.dmi'
	icon_state = "floor_black"

	//This proc is responsible for ore generation on surface turfs
/turf/simulated/mineral/muriki/make_ore(var/rare_ore)
	if(mineral || ignore_mapgen)
		return
	var/mineral_name
	if(rare_ore)
		mineral_name = pickweight(list(
			ORE_MARBLE = 3,
			ORE_URANIUM = 10,
			ORE_PLATINUM = 10,
			ORE_HEMATITE = 20,
			ORE_CARBON = 20,
			ORE_DIAMOND = 1,
			ORE_GOLD = 8,
			ORE_SILVER = 8,
			ORE_PHORON = 18,
			ORE_LEAD = 2,
			ORE_VERDANTIUM = 1))
	else
		mineral_name = pickweight(list(
			ORE_MARBLE = 2,
			ORE_URANIUM = 5,
			ORE_PLATINUM = 5,
			ORE_HEMATITE = 35,
			ORE_CARBON = 35,
			ORE_GOLD = 3,
			ORE_SILVER = 3,
			ORE_PHORON = 25,
			ORE_LEAD = 1))
	if(mineral_name && (mineral_name in GLOB.ore_data))
		mineral = GLOB.ore_data[mineral_name]
		UpdateMineral()
	update_icon()

/turf/simulated/mineral/muriki/rich/make_ore(var/rare_ore)
	if(mineral || ignore_mapgen)
		return
	var/mineral_name
	if(rare_ore)
		mineral_name = pickweight(list(
			ORE_URANIUM = 10,
			ORE_PLATINUM = 10,
			ORE_HEMATITE = 10,
			ORE_CARBON = 10,
			ORE_DIAMOND = 4,
			ORE_GOLD = 15,
			ORE_SILVER = 15))
	else
		mineral_name = pickweight(list(
			ORE_URANIUM = 7,
			ORE_PLATINUM = 7,
			ORE_HEMATITE = 28,
			ORE_CARBON = 28,
			ORE_DIAMOND = 2,
			ORE_GOLD = 7,
			ORE_SILVER = 7))
	if(mineral_name && (mineral_name in GLOB.ore_data))
		mineral = GLOB.ore_data[mineral_name]
		UpdateMineral()
	update_icon()

/turf/unsimulated/mineral/muriki
	blocks_air = TRUE

/turf/unsimulated/mineral/muriki/basalt
	icon = 'modular_chomp/icons/turf/thor.dmi'
	icon_state = "deeprock-solid"
	desc = "Dark black basalt. Packed impossibly tightly, there is no way to get past this."

/turf/unsimulated/mineral/muriki/crystal
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock-crystal-shiny-dense"
	desc = "Deep blue, shiny material of hyper compressed crystal. It looks completely unbreakable."

/turf/unsimulated/floor/steel
	icon = 'icons/turf/flooring/tiles_vr.dmi'
	icon_state = "steel"

/turf/unsimulated/wall
	blocks_air = 1

/turf/unsimulated/wall/planetary
	blocks_air = 0

// Some turfs to make floors look better in centcom tram station.
/turf/unsimulated/floor/techfloor_grid
	name = "floor"
	icon = 'icons/turf/flooring/techfloor.dmi'
	icon_state = "techfloor_grid"

/turf/unsimulated/floor/maglev
	name = "maglev track"
	desc = "Magnetic levitation tram tracks. Caution! Electrified!"
	icon = 'icons/turf/flooring/maglevs.dmi'
	icon_state = "maglevup"

/turf/unsimulated/wall/transit
	icon = 'icons/turf/transit_vr.dmi'

/turf/unsimulated/floor/transit
	icon = 'icons/turf/transit_vr.dmi'

/obj/effect/floor_decal/transit/orange
	icon = 'icons/turf/transit_vr.dmi'
	icon_state = "transit_techfloororange_edges"

/obj/effect/transit/light
	icon = 'icons/turf/transit_128.dmi'
	icon_state = "tube1-2"

// Bluespace jump turf!
/turf/space/bluespace
	name = "bluespace"
	icon = 'icons/turf/space_vr.dmi'
	icon_state = "bluespace"
/turf/space/bluespace/Initialize()
	..()
	icon = 'icons/turf/space_vr.dmi'
	icon_state = "bluespace"

// Desert jump turf!
/turf/space/sandyscroll
	name = "sand transit"
	icon = 'icons/turf/transit_vr.dmi'
	icon_state = "desert_ns"
/turf/space/sandyscroll/New()
	..()
	icon_state = "desert_ns"

//Sky stuff!
// A simple turf to fake the appearance of flying.
/turf/simulated/sky/muriki
	color = "#E0FFFF"

/turf/simulated/sky/muriki/Initialize()
	SSplanets.addTurf(src)
	set_light(2, 2, "#E0FFFF")

/turf/simulated/sky/muriki/north
	dir = NORTH
/turf/simulated/sky/muriki/south
	dir = SOUTH
/turf/simulated/sky/muriki/east
	dir = EAST
/turf/simulated/sky/muriki/west
	dir = WEST

/turf/simulated/sky/muriki/moving
	icon_state = "sky_fast"
/turf/simulated/sky/muriki/moving/north
	dir = NORTH
/turf/simulated/sky/muriki/moving/south
	dir = SOUTH
/turf/simulated/sky/muriki/moving/east
	dir = EAST
/turf/simulated/sky/muriki/moving/west
	dir = WEST

/turf/simulated/sky/snowscroll
	name = "snow transit"
	icon = 'icons/turf/transit_yw.dmi'
	icon_state = "snow_ns"

/turf/simulated/sky/snowscroll/Initialize()
	SSplanets.addTurf(src)
	set_light(2, 2, "#E0FFFF")

// TRAM USE  - TODO: Compare with existing maglev tracks on the virgo maps. I sense redundant code. Also needs to be moved to a higher level.
// The tram's electrified maglev tracks
/turf/simulated/floor/maglev
	name = "maglev track"
	desc = "Magnetic levitation tram tracks. Caution! Electrified!"
	icon = 'icons/turf/flooring/maglevs.dmi'
	icon_state = "maglevup"

	var/area/shock_area = /area/engineering/engine_smes // engine power hue hue hue

/turf/simulated/floor/maglev/Initialize()
	. = ..()
	shock_area = locate(shock_area)

// Walking on maglev tracks will shock you! Horray!
/turf/simulated/floor/maglev/Entered(var/atom/movable/AM, var/atom/old_loc)
	if(locate(/obj/structure/catwalk) in AM.loc)
		// safe to walk over!
		return
	if(isliving(AM) && prob(80))
		track_zap(AM)
/turf/simulated/floor/maglev/attack_hand(var/mob/user)
	if(prob(95))
		track_zap(user)
/turf/simulated/floor/maglev/proc/track_zap(var/mob/living/user)
	if (!istype(user)) return
	if (user.is_incorporeal()) return
	if (electrocute_mob(user, shock_area, src))
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(5, 1, src)
		s.start()

// override of newly added unsimulated deathdrop tile with black darkness appearance!
/turf/unsimulated/deathdrop/elevator_shaft
	death_message = "You fall into the elevator shaft, the thin atmosphere inside does little to slow you down and by the time you hit the bottom there is nothing more than a bloody smear. The damage you did to the elevator and the cost of your potential resleeve will be deducted from your pay."

/turf/simulated/deathdrop/elevator_shaft
	death_message = "You fall into the elevator shaft, the thin atmosphere inside does little to slow you down and by the time you hit the bottom there is nothing more than a bloody smear. The damage you did to the elevator and the cost of your potential resleeve will be deducted from your pay."

/turf/unsimulated/deathdrop/waterfall
	death_message = "The increasing speed and current of the river swiftly drags you into the rapids, destoying any boat you had and cracking your body against the rocks. The harsh acids of the water then make short work at dissolving your corpse, lost to the river forever."
	icon = 'modular_outpost/icons/turf/outdoors.dmi'
	icon_state = "searapids" // So it shows up in the map editor as water.

/turf/simulated/deathdrop/waterfall
	death_message = "The increasing speed and current of the river swiftly drags you into the rapids, destoying any boat you had and cracking your body against the rocks. The harsh acids of the water then make short work at dissolving your corpse, lost to the river forever."
	icon = 'modular_outpost/icons/turf/outdoors.dmi'
	icon_state = "searapids" // So it shows up in the map editor as water.
