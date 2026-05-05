//////////////////////////////////////////////////////////////
// ERT Overmap Shuttle
/obj/effect/overmap/visitable/ship/landable/specialops_overmap
	name = "Interferon"
	desc = "Eshui aligned Interceptor usually carrying the ERT to the station."
	vessel_mass = 3500
	vessel_size = SHIP_SIZE_LARGE
	shuttle = "Interferon"
	known = TRUE // we own this lol
	fore_dir = EAST

/obj/machinery/computer/shuttle_control/explore/specialops_overmap
	name = "short jump console"
	shuttle_tag = "Interferon"
	req_one_access = list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS)

/area/shuttle/specialops_overmap
	name = "\improper Interferon"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/space

/datum/shuttle/autodock/overmap/specialops_overmap
	name = "Interferon"
	warmup_time = 0
	current_location = "interferon_hangar"
	docking_controller_tag = "int_docker"
	shuttle_area = list(/area/shuttle/specialops_overmap)
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/specialops_overmap/central_command
	name = "Interferon Hanger"
	landmark_tag = "interferon_hangar"
	docking_controller = "int_docking_hanger"
	base_turf = /turf/space
	base_area = /area/space

/obj/effect/shuttle_landmark/premade/specialops_overmap/airdrop_muriki
	name = "ES Outpost 21 Airdrop Central"
	landmark_tag = "interferon_airdrop_muriki_central"
	base_turf = /turf/simulated/open/muriki
	base_area = /area/muriki/skyline/cent

/obj/effect/shuttle_landmark/premade/specialops_overmap/airdrop_muriki_alt
	name = "ES Outpost 21 Airdrop South East"
	landmark_tag = "interferon_airdrop_muriki_southeast"
	base_turf = /turf/simulated/open/muriki
	base_area = /area/muriki/skyline/south
