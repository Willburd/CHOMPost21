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

//////////////////////////////////////////////////////////////////////////////
//Rogue Mines Stuff

/datum/map_template/outpost_lateload/outpost_roguemines1
	name = LATELOAD_Z_ROGUEMINE_1
	desc = "Mining, but rogue. Zone 1"
	mappath = "modular_outpost/maps/submaps/rogueminer/rogue_mine1.dmm"

	associated_map_datum = /datum/map_z_level/outpost_lateload/roguemines1

/datum/map_z_level/outpost_lateload/roguemines1
	name = "Belt 1"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_1

/datum/map_template/outpost_lateload/outpost_roguemines2
	name = LATELOAD_Z_ROGUEMINE_2
	desc = "Mining, but rogue. Zone 2"
	mappath = "modular_outpost/maps/submaps/rogueminer/rogue_mine2.dmm"

	associated_map_datum = /datum/map_z_level/outpost_lateload/roguemines2

/datum/map_z_level/outpost_lateload/roguemines2
	name = "Belt 2"
	flags = MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	z = Z_LEVEL_ROGUEMINE_2
