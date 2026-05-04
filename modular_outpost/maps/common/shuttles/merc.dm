//////////////////////////////////////////////////////////////
// Mercenary Shuttle
/datum/shuttle/autodock/multi/mercenary
	name = "Mercenary"
	warmup_time = 0
	shuttle_area = /area/shuttle/mercenary
	current_location = "mercenary_base"
	landmark_transition = "mercenary_transit"
	can_cloak = TRUE
	cloaked = TRUE
	docking_controller_tag = "merc_shuttle"
	announcer = "Automated Traffic Control"
	arrival_message = "Attention.  A vessel is approaching the colony."
	departure_message = "Attention.  A vessel is now leaving from the colony."
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

	destination_tags = list(
		"mercenary_base",
		"mercenary_station_se",
		"mercenary_station_sw",
		"mercenary_station_n",
		"mercenary_station_s"
	)

/obj/effect/shuttle_landmark/premade/mercenary/base
	name = "Home Base"
	landmark_tag = "mercenary_base"
	docking_controller = "merc_base"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/mercenary/transit
	name = "Deep Space"
	landmark_tag = "mercenary_transit"

/obj/effect/shuttle_landmark/premade/mercenary/station_se
	name = "ES Outpost 21 (SE)"
	landmark_tag = "mercenary_station_se"

/obj/effect/shuttle_landmark/premade/mercenary/station_sw
	name = "ES Outpost 21 (SW)"
	landmark_tag = "mercenary_station_sw"

/obj/effect/shuttle_landmark/premade/mercenary/station_n
	name = "ES Outpost 21 (N)"
	landmark_tag = "mercenary_station_n"

/obj/effect/shuttle_landmark/premade/mercenary/station_s
	name = "ES Outpost 21 (S)"
	landmark_tag = "mercenary_station_s"
