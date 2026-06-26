//////////////////////////////////////////////////////////////
// Skipjack
/datum/shuttle/autodock/multi/skipjack
	name = "Skipjack"
	warmup_time = 0
	shuttle_area = /area/shuttle/skipjack
	current_location = "skipjack_base"
	landmark_transition = "skipjack_transit"
	can_cloak = TRUE
	cloaked = TRUE
	announcer = "Automated Traffic Control"
	arrival_message = "Attention.  Unidentified object approaching the colony."
	departure_message = "Attention.  Unidentified object exiting local space.  Unidentified object expected to escape Muriki gravity well with current velocity."
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

	destination_tags = list(
		"skipjack_base",
		"skipjack_station_mount",
		"skipjack_yard_west",
		"skipjack_yard_east",
		"skipjack_beam_east"
	)

/obj/effect/shuttle_landmark/premade/skipjack/base
	name = "Home Base"
	landmark_tag = "skipjack_base"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/transit
	name = "Deep Space"
	landmark_tag = "skipjack_transit"

/obj/effect/shuttle_landmark/premade/skipjack/station_ne
	name = "ES Outpost 21 (Mountains)"
	landmark_tag = "skipjack_station_mount"
	base_area = /area/muriki/skyline/north
	base_turf = /turf/simulated/open/muriki

/obj/effect/shuttle_landmark/premade/skipjack/station_nw
	name = "Reclaimation Yard (West)"
	landmark_tag = "skipjack_yard_west"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/station_se
	name = "Reclaimation Yard (East)"
	landmark_tag = "skipjack_yard_east"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/beam_ne
	name = "Confinement Beam (East)"
	landmark_tag = "skipjack_beam_east"
	base_area = /area/space
	base_turf = /turf/space
