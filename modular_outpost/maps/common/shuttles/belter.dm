//////////////////////////////////////////////////////////////
// RogueMiner "Belter: Shuttle

/datum/shuttle/autodock/ferry/belter
	name = "Belter"
	location = FERRY_LOCATION_STATION
	warmup_time = 5
	move_time = 30
	shuttle_area = /area/shuttle/belter
	landmark_station = "belter_station"
	landmark_offsite = "belter_zone1"
	landmark_transition = "belter_transit"
	docking_controller_tag = "belter_docking"
	move_direction = SOUTH

/datum/shuttle/autodock/ferry/belter/New()
	move_time = move_time + rand(-5 SECONDS, 5 SECONDS)
	..()

/obj/effect/shuttle_landmark/premade/belter/asteroid_yard
	name = "Reclaimation Yard (Belter Platform)"
	landmark_tag = "belter_station"
	base_area = /area/offworld/asteroidyard/external
	base_turf = /turf/simulated/floor/airless

/obj/effect/shuttle_landmark/premade/belter/transit
	name = "Deep Space"
	landmark_tag = "belter_transit"
