/turf/simulated/floor/water/acidic
	name = "acidic shallows"
	desc = "Water contaminated by the terraforming process. Highly unpleasant to most organic creatures."
	edge_blending_priority = -2
	movement_cost = 5
	depth = 1

	icon = 'modular_outpost/icons/turf/outdoors.dmi'
	icon_state = "acid_shallow" // So it shows up in the map editor as water.
	water_icon = 'modular_outpost/icons/turf/outdoors.dmi'

	has_fish = FALSE // No fish in this pond
	water_state = "acid_shallow"
	outdoors = OUTDOORS_YES
	reagent_type = "water"
	var/burnlevel = 5

/turf/simulated/floor/water/acidic/deep
	name = "acidic pool"
	desc = "Water contaminated by the terraforming process. Highly unpleasant to most organic creatures. It's very deep,"
	icon_state = "acid_deep" // So it shows up in the map editor as water.
	under_state = "abyss"
	edge_blending_priority = -2
	movement_cost = 10
	depth = 2

	burnlevel = 10
	reagent_type = "water"

/turf/simulated/floor/water/acidic/Entered(atom/movable/AM, atom/oldloc)
	if(isliving(AM))
		var/allowburn = TRUE
		var/mob/living/L = AM
		if(L.buckled && L.buckled.riding_datum)
			// boats don't burn you if riding
			if(istype(L.buckled.riding_datum, /datum/riding/boat))
				allowburn = FALSE

		if(allowburn)
			// handles incorporial and immune creatures itself...
			muriki_enzyme_affect_mob( L, burnlevel * (1 - L.get_water_protection()), FALSE, TRUE)
	..()

/turf/simulated/floor/water/acidic/is_safe_to_enter(mob/living/L)
	// TODO check if mob is acid proof
	return FALSE

// Water sprites are really annoying, so let BYOND sort it out.
/turf/simulated/floor/water/acidic/shoreline/update_icon()
	// detect if corner or not, force the icon state stuff to default, we only want to change the ground art!
	var/ground_state = "shoreline"
	if(istype(src,/turf/simulated/floor/water/acidic/shoreline/corner))
		ground_state = "shorelinecorner"
	underlays.Cut()
	cut_overlays()
	..() // Get the underlay first.
	var/cache_string = "[ground_state]_[water_state]_[src.dir]"
	if(cache_string in shoreline_icon_cache) // Check to see if an icon already exists.
		add_overlay(shoreline_icon_cache[cache_string])
	else // If not, make one, but only once.
		var/icon/shoreline_water = icon(src.icon, "shoreline_water", src.dir)
		var/icon/shoreline_subtract = icon(src.icon, "[ground_state]_subtract", src.dir)
		shoreline_water.Blend(shoreline_subtract,ICON_SUBTRACT)
		var/image/final = image(shoreline_water)
		final.layer = WATER_LAYER

		shoreline_icon_cache[cache_string] = final
		add_overlay(shoreline_icon_cache[cache_string])



// edges!
/turf/simulated/floor/water/acidic/shoreline
	name = "shoreline"
	icon_state = "shoreline"
	water_state = "sand" // Water gets generated as an overlay in update_icon()
	depth = 0

/turf/simulated/floor/water/acidic/shoreline/corner
	icon_state = "shorelinecorner"
	water_state = "sand" // Water gets generated as an overlay in update_icon()


// edges dirt
/turf/simulated/floor/water/acidic/shoreline/shoreline_dirt
	icon_state = "shoreline_dirt"
	water_state = "dirt_shore" // Water gets generated as an overlay in update_icon()

/turf/simulated/floor/water/acidic/shoreline/corner/corner_dirt
	icon_state = "shorelinecorner_dirt"
	water_state = "dirt_shore" // Water gets generated as an overlay in update_icon()



// edges mud
/turf/simulated/floor/water/acidic/shoreline/shoreline_mud
	icon_state = "shoreline_mud"
	water_state = "mud_dark" // Water gets generated as an overlay in update_icon()

/turf/simulated/floor/water/acidic/shoreline/corner/corner_mud
	icon_state = "shorelinecorner_mud"
	water_state = "mud_dark" // Water gets generated as an overlay in update_icon()


// edges plate
/turf/simulated/floor/water/acidic/shoreline/shoreline_plate
	icon_state = "shoreline_plate"
	water_state = "plate_shore" // Water gets generated as an overlay in update_icon()

/turf/simulated/floor/water/acidic/shoreline/corner/corner_plate
	icon_state = "shorelinecorner_plate"
	water_state = "plate_shore" // Water gets generated as an overlay in update_icon()


// edges flesh
/turf/simulated/floor/water/acidic/shoreline/shoreline_flesh
	icon_state = "shoreline_flesh"
	water_state = "flesh_shore" // Water gets generated as an overlay in update_icon()

/turf/simulated/floor/water/acidic/shoreline/corner/corner_flesh
	icon_state = "shorelinecorner_flesh"
	water_state = "flesh_shore" // Water gets generated as an overlay in update_icon()


// edges cave
/turf/simulated/floor/water/acidic/shoreline/shoreline_cave
	icon_state = "shoreline_cave"
	water_state = "cave_shore" // Water gets generated as an overlay in update_icon()

/turf/simulated/floor/water/acidic/shoreline/corner/corner_cave
	icon_state = "shorelinecorner_cave"
	water_state = "cave_shore" // Water gets generated as an overlay in update_icon()


// CAVE
/turf/simulated/floor/water/acidic/indoor
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/deep/indoor
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/indoor
	icon_state = "shoreline"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/indoor
	icon_state = "shorelinecorner"
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/shoreline_dirt/indoor
	icon_state = "shoreline_dirt"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/corner_dirt/indoor
	icon_state = "shorelinecorner_dirt"
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/shoreline_mud/indoor
	icon_state = "shoreline_mud"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/corner_mud/indoor
	icon_state = "shorelinecorner_mud"
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/shoreline_plate/indoor
	icon_state = "shoreline_plate"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/corner_plate/indoor
	icon_state = "shorelinecorner_plate"
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/shoreline_flesh/indoor
	icon_state = "shoreline_flesh"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/corner_flesh/indoor
	icon_state = "shorelinecorner_flesh"
	outdoors = OUTDOORS_NO


/turf/simulated/floor/water/acidic/shoreline/shoreline_cave/indoor
	icon_state = "shoreline_cave"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/acidic/shoreline/corner/corner_cave/indoor
	icon_state = "shorelinecorner_cave"
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/indoors/beach
	// Indoor garden's beach uses split graphics...
	icon = 'modular_outpost/icons/turf/outdoors.dmi'
	under_state = "beachsand"

// Base water given a few missing indoor types
/turf/simulated/floor/water/deep/indoors
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/beach/indoors
	outdoors = OUTDOORS_NO

/turf/simulated/floor/water/beach/corner/indoors
	outdoors = OUTDOORS_NO
