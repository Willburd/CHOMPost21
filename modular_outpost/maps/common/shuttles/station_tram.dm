//////////////////////////////////////////////////////////////
// Tramshuttle
/datum/shuttle/autodock/multi/tram
	name = "Station Tram"
	warmup_time = 5
	shuttle_area = /area/shuttle/tram
	docking_controller_tag = "Tram"
	current_location = "tram_shed"
	bluespace = FALSE // don't smoosh shadekin
	can_be_haunted = TRUE
//	landmark_transition = "tram_transit"
	ceiling_type = /turf/simulated/shuttle/floor/white

	destination_tags = list(
		"tram_waste",
		"tram_eng",
		"tram_civ"
	)

	allow_short_crashes = TRUE
	crash_message = "Tram system derailment detected."
	crash_locations = list("tram_crash_red")

/datum/shuttle/autodock/multi/tram/can_launch()
	var/area/cur_area = shuttle_area[1]
	if(cur_area.always_unpowered)
		return FALSE
	. = ..()

/datum/shuttle/autodock/multi/tram/can_force()
	var/area/cur_area = shuttle_area[1]
	if(cur_area.always_unpowered)
		return FALSE
	. = ..()

/datum/shuttle/autodock/multi/tram/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	if(emagged_crash)
		return TRUE
	// Crash due to powerloss on move
	var/area/cur_area = shuttle_area[1]
	if(cur_area.always_unpowered)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(10)
	if(SShaunting.get_world_haunt() >= 4)
		return prob(1) && prob(1)
	return FALSE

/obj/effect/shuttle_landmark/premade/tram/shed
	name = "Tram Station - Shed"
	landmark_tag = "tram_shed"
	base_area = /area/muriki/tramstation/shed
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/premade/tram/transit
	name = "Tram Station - Transit"
	landmark_tag = "tram_transit"
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/base
	name = "Tram Station - Waste and Maintenance"
	landmark_tag = "tram_waste"
	base_area = /area/muriki/tramstation/waste
	base_turf = /turf/simulated/open
	local_crash_sites = list("tram_crash_waste","tram_crash_waste_mean","tram_crash_terraformer_mean")

/obj/effect/shuttle_landmark/premade/tram/eng
	name = "Tram Station - Engineering Cargo"
	landmark_tag = "tram_eng"
	base_area = /area/muriki/tramstation/cargeng
	base_turf = /turf/simulated/open
	local_crash_sites = list("tram_crash_eng","tram_crash_eng_mean","tram_crash_eng_ultramean")

/obj/effect/shuttle_landmark/premade/tram/civ
	name = "Tram Station - Civilian"
	landmark_tag = "tram_civ"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open
	local_crash_sites = list("tram_crash_civ","tram_crash_civ_mean","tram_crash_civ_ultramean")

/obj/effect/shuttle_landmark/premade/tram/crash_waste
	name = "Tram Crash - Waste"
	landmark_tag = "tram_crash_waste"
	base_area = /area/muriki/grounds/tramlinewest
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_waste/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng
	name = "Tram Crash - Eng"
	landmark_tag = "tram_crash_eng"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_eng/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_med
	name = "Tram Crash - Med"
	landmark_tag = "tram_crash_med"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_med/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ
	name = "Tram Crash - Civ"
	landmark_tag = "tram_crash_civ"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_civ/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_red
	name = "Tram Crash - Red"
	landmark_tag = "tram_crash_red"
	base_area = /area/specialty/redspace
	base_turf = /turf/simulated/floor/flesh

/obj/effect/shuttle_landmark/premade/tram/crash_red/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ_mean
	name = "Tram Crash - Civ Mean"
	landmark_tag = "tram_crash_civ_mean"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_civ_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ_ultramean
	name = "Tram Crash - Civ Ultra Mean"
	landmark_tag = "tram_crash_civ_ultramean"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_civ_ultramean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng_mean
	name = "Tram Crash - Eng Mean"
	landmark_tag = "tram_crash_eng_mean"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_eng_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng_ultramean
	name = "Tram Crash - Eng Ultra Mean"
	landmark_tag = "tram_crash_eng_ultramean"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_eng_ultramean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_waste_mean
	name = "Tram Crash - Waste Mean"
	landmark_tag = "tram_crash_waste_mean"
	base_area = /area/muriki/grounds/tramlinewest
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_waste_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_terraformer_mean
	name = "Tram Crash - Terraformer Mean"
	landmark_tag = "tram_crash_terraformer_mean"
	base_area = /area/muriki/grounds/terraform
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_terraformer_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE
