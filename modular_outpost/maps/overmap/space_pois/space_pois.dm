/*
MAPPER QUICK GUDE
Looking to add new overmap POI's with as little code knowledge as possible? Here's the vital stuff:
-Maps are stored in /datum/map_template/dynamic_overmap templates, you will need to make one template per POI. Code automagically handles adding templates to the overmap.
-The "name" variable must be unique.
-The "mappath" variable must be the file path of your map file. Store maps in "modular_chomp/maps/overmap/space_pois."
-The "block_size" variable is the tile size of your map's LARGEST dimension. Code may break horribly if you do not set this correctly.
	-If your map is 60 tiles by 45 tiles, the block_size should be 60.
-ADD YOUR MAP(s) TO THE #include LIST BELOW. This lets github catch POI's breaking in the future.
-Keep templates alphebetical.
-Include the map dimensions in the map file name.

Less important
-"scanner_desc" is the information presented to players upon scanning the POI. You should probably fill this out but it's not necessary for POI spawning.
-"poi_icon" is the icon_state used when the POI is first scanned.
-"active_icon" is the icon_state used when the POI is loaded into the game.
-POI icons use "icons/obj/overmap.dmi" by default. Using other .dmi files is not currently supported but would be easy to code if desired.
-"poi_color" colors the overmap object when set, does nothing when null. Uses hexadecimal color codes.
-Most POI spawning code is in dynamic_sector.dm, if you're looking for it.
*/


// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#endif

// Vars (excluding mappath) are passed to the overmap object after scanning.
// Every template MUST have a unique name both because of the mapping subsystem and the overmap system.
/datum/map_template/dynamic_overmap
	name = "bluespace static"
	mappath = null
	annihilate = TRUE
	var/scanner_desc = "Unable to resolve bluespace fluctuations."
	var/poi_icon = "ring"
	var/active_icon = "ring_active" // Icon to use when the POI is loaded. Set to null to disable behavior.
	var/poi_color = null
	var/block_size = 60 // The size of the map's largest dimension. If the map is 66x49, this var should be 66. Essential for laoding/unloading system.

// Stolen from map_template/shelter
/datum/map_template/dynamic_overmap/proc/update_lighting(turf/deploy_location)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/T in affected)
		T.lighting_build_overlay()

/*
/datum/map_template/dynamic_overmap/wayhome_30x30
	name = "Strange Rock"
	mappath = "modular_chomp/maps/overmap/space_pois/wayhome_30x30.dmm"
	block_size = 30
*/
