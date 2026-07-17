//////////////////////////////////////////////////////////////
// ERT Overmap Shuttle
/obj/effect/overmap/visitable/ship/landable/ninja_overmap
	name = "Rokkaku-Dako"
	desc = "An advanced stealth shuttle used commonly by the spider clan."
	vessel_mass = 500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Rokkaku-Dako"
	fore_dir = EAST
	overmap_stealth = TRUE

/obj/machinery/computer/shuttle_control/explore/ninja_overmap
	name = "short jump console"
	shuttle_tag = "Rokkaku-Dako"
	req_one_access = list(ACCESS_SYNDICATE)

/area/shuttle/ninja_overmap
	name = "\improper Rokkaku-Dako"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/space

/datum/shuttle/autodock/overmap/ninja_overmap
	name = "Rokkaku-Dako"
	warmup_time = 0
	current_location = "dako_hangar"
	docking_controller_tag = "dako_docker"
	shuttle_area = list(/area/shuttle/ninja_overmap)
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/ninja_overmap/homebase
	name = "Rokkaku-Dako Hanger"
	landmark_tag = "dako_hangar"
	docking_controller = "dako_docking_hanger"
	base_turf = /turf/space
	base_area = /area/space

/obj/effect/shuttle_landmark/premade/ninja_overmap/airdrop_muriki
	name = "Rokkaku-Dako Airdrop"
	landmark_tag = "dako_airdrop_muriki_central"
	base_turf = /turf/simulated/open/muriki
	base_area = /area/muriki/skyline/cent
