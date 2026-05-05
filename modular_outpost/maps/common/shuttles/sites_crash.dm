/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Crash bang boom!
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/effect/shuttle_landmark/premade/generic/crash_cargoyard
	name = "Crash - Cargo Yard"
	landmark_tag = "crash_cargoyard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/yard

/obj/effect/shuttle_landmark/premade/generic/crash_cargoyard/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_north
	name = "Crash - North"
	landmark_tag = "crash_north"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/engi

/obj/effect/shuttle_landmark/premade/generic/crash_north/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_south
	name = "Crash - South"
	landmark_tag = "crash_south"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/sec

/obj/effect/shuttle_landmark/premade/generic/crash_south/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_engiroof
	name = "Crash - Engineering Roof"
	landmark_tag = "crash_engi_roof"
	base_turf = /turf/simulated/open
	base_area = /area/muriki/rooftop/engineering

/obj/effect/shuttle_landmark/premade/generic/crash_engiroof/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_secroof
	name = "Crash - Security Roof"
	landmark_tag = "crash_sec_roof"
	base_turf = /turf/simulated/open
	base_area = /area/muriki/rooftop/security

/obj/effect/shuttle_landmark/premade/generic/crash_secroof/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_gardenroof
	name = "Crash - Garden Roof"
	landmark_tag = "crash_garden_roof"
	base_turf = /turf/simulated/open
	base_area = /area/hydroponics/publicgarden

/obj/effect/shuttle_landmark/premade/generic/crash_gardenroof/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_ptl
	name = "Crash - PTL"
	landmark_tag = "crash_ptl"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior

/obj/effect/shuttle_landmark/premade/generic/crash_ptl/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_ptl_enginesouth
	name = "Crash - PTL Engine South"
	landmark_tag = "crash_ptl_enginesouth"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior

/obj/effect/shuttle_landmark/premade/generic/crash_ptl_enginesouth/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_ptl_enginenorth
	name = "Crash - PTL Engine North"
	landmark_tag = "crash_ptl_enginenorth"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior

/obj/effect/shuttle_landmark/premade/generic/crash_ptl_enginenorth/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_rec
	name = "Crash - Recyard Basic"
	landmark_tag = "crash_rec"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard/external

/obj/effect/shuttle_landmark/premade/generic/crash_rec/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_rec_trawlerbad
	name = "Crash - Recyard TrawlerBad"
	landmark_tag = "crash_rec_trawlerbad"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard/external

/obj/effect/shuttle_landmark/premade/generic/crash_rec_trawlerbad/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE
