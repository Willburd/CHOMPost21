//////////////////////////////////////////////////////////////
// ERT Quick Drop Shuttle
/datum/shuttle/autodock/ferry/specialops
	name = "Special Operations"
	location = FERRY_LOCATION_STATION
	warmup_time = 10
	shuttle_area = /area/shuttle/specops/centcom
	landmark_station = "specops_cc"
	landmark_offsite = "specops_station"
	docking_controller_tag = "specops_shuttle_port"
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/specops/centcom
	name = "ESCC Bunker"
	landmark_tag = "specops_cc"
	docking_controller = "specops_centcom_dock"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/specops/station
	name = "ES Outpost 21"
	landmark_tag = "specops_station"
	docking_controller = "specops_station_dock"
	base_area = /area/muriki/skyline/east
	base_turf = /turf/simulated/open/muriki
