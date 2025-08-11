
//////////////////////////////////////////////////////////////////////////////////////
// Code Shenanigans for lateload maps

/datum/map_template/outpost_lateload
	allow_duplicates = FALSE
	var/associated_map_datum

/datum/map_template/outpost_lateload/on_map_loaded(z)
	if(!associated_map_datum || !ispath(associated_map_datum))
		log_game("Extra z-level [src] has no associated map datum")
		return

	new associated_map_datum(using_map, z)

/datum/map_z_level/outpost_lateload
	z = 0

/datum/map_z_level/outpost_lateload/New(var/datum/map/map, mapZ)
	if(mapZ && !z)
		z = mapZ
	return ..(map)

//////////////////////////////////////////////////////////////////////////////////////
// Centcom Z-Level
/datum/map_z_level/outpost_lateload/centcom
	name = Z_NAME_OUTPOST_CENTCOM
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED
	base_turf = /turf/simulated/floor/lava

/datum/map_template/outpost_lateload/centcom
	name = Z_NAME_OUTPOST_CENTCOM
	name_alias = Z_NAME_ALIAS_CENTCOM
	mappath = "modular_outpost/maps/outpost_22/outpost-centcom.dmm" // Different centcom from 21
	associated_map_datum = /datum/map_z_level/outpost_lateload/centcom


// Misc Z-level
/datum/map_z_level/outpost_lateload/misc
	name = Z_NAME_OUTPOST_MISC
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_XENOARCH_EXEMPT|MAP_LEVEL_SEALED|MAP_LEVEL_BELOW_BLOCKED

/datum/map_template/outpost_lateload/misc
	name = Z_NAME_OUTPOST_MISC
	name_alias = Z_NAME_ALIAS_MISC
	mappath = "modular_outpost/maps/outpost_21/outpost-misc.dmm" // Same misc level
	associated_map_datum = /datum/map_z_level/outpost_lateload/misc

//////////////////////////////////////////////////////////////////////////////
//Rogue Mines Stuff
/datum/map_template/outpost_lateload/outpost_roguemines1
	name = Z_NAME_OUTPOST_ROGUEMINE_1
	desc = "Mining, but rogue. Zone 1"
	mappath = "modular_outpost/maps/submaps/rogueminer/rogue_mine1.dmm"

	associated_map_datum = /datum/map_z_level/outpost_lateload/roguemines1

/datum/map_z_level/outpost_lateload/roguemines1
	name = Z_NAME_OUTPOST_ROGUEMINE_1
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER

/datum/map_template/outpost_lateload/outpost_roguemines2
	name = Z_NAME_OUTPOST_ROGUEMINE_2
	desc = "Mining, but rogue. Zone 2"
	mappath = "modular_outpost/maps/submaps/rogueminer/rogue_mine2.dmm"

	associated_map_datum = /datum/map_z_level/outpost_lateload/roguemines2

/datum/map_z_level/outpost_lateload/roguemines2
	name = Z_NAME_OUTPOST_ROGUEMINE_2
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
