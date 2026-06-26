//////////////////////////////////////////////////////////////
// Tram to redspace
// Other stations in in modular_outpost\maps\submaps\deepdark\deepdark.dm due to POI checks
/area/shuttle/darktransit
	name = "\improper Unknown Tram"
	flags = AREA_FLAG_IS_NOT_PERSISTENT|AREA_BLOCK_PHASE_SHIFT
	base_turf = /turf/simulated/floor/flesh
	haunted = TRUE

/datum/shuttle/autodock/multi/underdark
	name = "Unknown Tram"
	warmup_time = 5
	shuttle_area = /area/shuttle/darktransit
	current_location = "dark_hell"
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki
	can_be_haunted = TRUE

	destination_tags = list(
		"dark_start",
		"dark_hell",
		"dark_end"
	)

/obj/effect/shuttle_landmark/premade/underdark/hell
	name = "Somewhere Else"
	landmark_tag = "dark_hell"
	base_area = /area/specialty/redspace
	base_turf = /turf/simulated/floor/flesh

/obj/effect/shuttle_landmark/premade/underdark/start
	name = "Station Platform"
	landmark_tag = "dark_start"
	base_area = /area/mine/explored/muriki/cave/deepdark
	base_turf = /turf/simulated/floor/plating/turfpack/muriki

/obj/effect/shuttle_landmark/premade/underdark/end
	name = "End Of The Line"
	landmark_tag = "dark_end"
	base_area = /area/mine/explored/muriki/cave/deepdark
	base_turf = /turf/simulated/floor/plating/turfpack/muriki
