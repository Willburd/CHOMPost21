#define OUTPOST_SURFACE_CRASHES list("crash_cargoyard","crash_north","crash_south","crash_engi_roof","crash_sec_roof","crash_garden_roof")
#define OUTPOST_CONFINEMENTBEAM_CRASHES list("crash_ptl","crash_ptl_enginesouth","crash_ptl_enginenorth")
#define OUTPOST_ASTEROID_CRASHES list("crash_rec","crash_rec_trawlerbad")

//////////////////////////////////////////////////////////////
// Escape shuttle
/datum/shuttle/autodock/ferry/emergency/escape
	name = "Escape"
	location = FERRY_LOCATION_OFFSITE // At offsite
	warmup_time = 10
	docking_controller_tag = "escape_shuttle"
	shuttle_area = /area/shuttle/escape
	landmark_offsite = "escape_centcom"
	landmark_station = "escape_station"
	landmark_transition = "escape_transit"
	move_time = SHUTTLE_TRANSIT_DURATION_RETURN
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki
	bluespace = FALSE // not a bluespace shuttle

/obj/effect/shuttle_landmark/premade/escape/centcom
	name = "ESCC Bunker"
	landmark_tag = "escape_centcom"
	docking_controller = "centcom_dock"
	base_area = /area/centcom/main_hall
	base_turf = /turf/unsimulated/deathdrop/elevator_shaft

/obj/effect/shuttle_landmark/premade/escape/transit
	name = "Elevator Shaft"
	landmark_tag = "escape_transit"
	base_turf = /turf/unsimulated/deathdrop/elevator_shaft

/obj/effect/shuttle_landmark/premade/escape/station
	name = "ES Outpost21"
	landmark_tag = "escape_station"
	docking_controller = "escape_dock"
	base_area = /area/engineering/gravgen
	base_turf = /turf/unsimulated/deathdrop/elevator_shaft

//////////////////////////////////////////////////////////////
// Supply shuttle
/datum/shuttle/autodock/ferry/supply/cargo
	name = "Supply"
	location = FERRY_LOCATION_OFFSITE
	warmup_time = 10
	shuttle_area = /area/shuttle/supply
	landmark_offsite = "supply_centcom"
	landmark_station = "supply_station"
	docking_controller_tag = "supply_shuttle"
	flags = SHUTTLE_FLAGS_PROCESS|SHUTTLE_FLAGS_SUPPLY
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/supply/centcom
	name = "ESCC Bunker"
	landmark_tag = "supply_centcom"
	base_area = /area/centcom/suppy
	base_turf = /turf/unsimulated/floor/techfloor_grid

/obj/effect/shuttle_landmark/premade/supply/station
	name = "ES Outpost21"
	landmark_tag = "supply_station"
	docking_controller = "cargo_bay"
