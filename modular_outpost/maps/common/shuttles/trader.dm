//////////////////////////////////////////////////////////////
// Trade Ship
/datum/shuttle/autodock/ferry/trade
	name = "Trade"
	location = FERRY_LOCATION_OFFSITE
	warmup_time = 10	//want some warmup time so people can cancel.
	shuttle_area = /area/shuttle/trade
	landmark_offsite = "trade_away"
	landmark_station = "trade_station"
	docking_controller_tag = "trade_shuttle"
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/trade/away
	name = "Deep Space"
	landmark_tag = "trade_away"
	docking_controller = "trade_shuttle_bay"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/trade/station
	name = "ES Outpost21"
	landmark_tag = "trade_station"
	docking_controller = "trade_shuttle_dock_airlock"
