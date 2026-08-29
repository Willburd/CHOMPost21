/datum/shuttle/autodock/ferry/escape_pod/orbital_pod_one
	name = "Orbital Escape Pod 1"
	location = FERRY_LOCATION_STATION
	shuttle_area = /area/shuttle/orbital_pod_one
	warmup_time = 0
	landmark_station = "pod_berth_one"
	landmark_offsite = "orbital_escape_pod_landing_one"
	landmark_transition = "orbital_escape_pod_transit_one"
	docking_controller_tag = "orbital_escape_pod_one"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN
	move_direction = WEST
	ceiling_type = /turf/simulated/shuttle/floor/white

/datum/shuttle/autodock/ferry/escape_pod/orbital_pod_two
	name = "Orbital Escape Pod 2"
	location = FERRY_LOCATION_STATION
	shuttle_area = /area/shuttle/orbital_pod_two
	warmup_time = 0
	landmark_station = "pod_berth_two"
	landmark_offsite = "orbital_escape_pod_landing_two"
	landmark_transition = "orbital_escape_pod_transit_two"
	docking_controller_tag = "orbital_escape_pod_two"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN
	move_direction = WEST
	ceiling_type = /turf/simulated/shuttle/floor/white

/datum/shuttle/autodock/ferry/escape_pod/orbital_pod_three
	name = "Orbital Escape Pod 3"
	location = FERRY_LOCATION_STATION
	shuttle_area = /area/shuttle/orbital_pod_three
	warmup_time = 0
	landmark_station = "pod_berth_three"
	landmark_offsite = "orbital_escape_pod_landing_three"
	landmark_transition = "orbital_escape_pod_transit_three"
	docking_controller_tag = "orbital_escape_pod_three"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN
	move_direction = WEST
	ceiling_type = /turf/simulated/shuttle/floor/white


// Areas
/area/shuttle/orbital_pod_one
	name = "\improper Orbital Escape Pod 1"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/airless
	requires_power = FALSE

/area/shuttle/orbital_pod_two
	name = "\improper Orbital Escape Pod 2"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/airless
	requires_power = FALSE

/area/shuttle/orbital_pod_three
	name = "\improper Orbital Escape Pod 3"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/airless
	requires_power = FALSE


// Docks
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_one
	name = "Escape Pod Berth 1"
	landmark_tag = "pod_berth_one"
	docking_controller = "escape_berth_one"
	base_turf = /turf/simulated/floor/airless
	base_area = /area/offworld/orbital/exterior

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_two
	name = "Escape Pod Berth 2"
	landmark_tag = "pod_berth_two"
	docking_controller = "escape_berth_two"
	base_turf = /turf/simulated/floor/airless
	base_area = /area/offworld/orbital/exterior

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_three
	name = "Escape Pod Berth 3"
	landmark_tag = "pod_berth_three"
	docking_controller = "escape_berth_three"
	base_turf = /turf/simulated/floor/airless
	base_area = /area/offworld/orbital/exterior


// Transit
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_one/transit
	name = "Deep Space"
	landmark_tag = "orbital_escape_pod_transit_one"
	base_area = /area/space
	base_turf = /turf/space/transit/west

// Force acceptable, this pod can't risk stopping
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_one/transit/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_two/transit
	name = "Deep Space"
	landmark_tag = "orbital_escape_pod_transit_two"
	base_area = /area/space
	base_turf = /turf/space/transit/west

// Force acceptable, this pod can't risk stopping
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_two/transit/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_three/transit
	name = "Deep Space"
	landmark_tag = "orbital_escape_pod_transit_three"
	base_area = /area/space
	base_turf = /turf/space/transit/west

// Force acceptable, this pod can't risk stopping
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_three/transit/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE


// Landing
/obj/effect/shuttle_landmark/premade/orbital_escape/pod_one/landing_site
	name = "Landing Site"
	landmark_tag = "orbital_escape_pod_landing_one"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/mine/explored/muriki/mountaineast

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_two/landing_site
	name = "Landing Site"
	landmark_tag = "orbital_escape_pod_landing_two"
	base_turf = /turf/simulated/floor/water/acidic/deep/turfpack/muriki
	base_area = /area/muriki/grounds/engi

/obj/effect/shuttle_landmark/premade/orbital_escape/pod_three/landing_site
	name = "Landing Site"
	landmark_tag = "orbital_escape_pod_landing_three"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/sec

// Force acceptable, this pod can't risk stopping
/obj/effect/shuttle_landmark/premade/orbital_escape/landing_site/is_valid(datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE
