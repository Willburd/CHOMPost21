//////////////////////////////////////////////////////////////
// Trawler Shuttle
/obj/effect/overmap/visitable/ship/landable/trawler
	name = "Mining Trawler"
	desc = "A hefty beast for making the station rich. Supposedly in compliance."
	vessel_mass = 3500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Mining Trawler"
	known = TRUE // we own this lol
	fore_dir = EAST

/datum/shuttle/autodock/overmap/trawler
	name = "Mining Trawler"
	warmup_time = 0
	current_location = "outpost_trawler_pad"
	docking_controller_tag = "trawler_docker"
	shuttle_area = list(/area/shuttle/trawler)
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki
	fuel_consumption = 2 // chonky

	allow_short_crashes = TRUE
	crash_message = "Major impact detected, likely large vehicle impact. Please ensure functionality of all shuttles, and begin rescue operations."

/datum/shuttle/autodock/overmap/trawler/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	if(!intended_destination.local_crash_sites?.len)
		return FALSE
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(1)
	return FALSE

/obj/machinery/computer/shuttle_control/explore/trawler
	name = "short jump console"
	shuttle_tag = "Mining Trawler"
	req_one_access = list(ACCESS_MINING)

/area/shuttle/trawler
	name = "\improper Mining Trawler"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/plating/external/turfpack/muriki
	holomap_color = HOLOMAP_AREACOLOR_CARGO

// Docks
/obj/effect/shuttle_landmark/premade/trawler/muriki
	name = "ES Outpost 21 (Trawler Pad)"
	landmark_tag = "outpost_trawler_pad"
	base_turf = /turf/simulated/floor/plating/external/turfpack/muriki
	base_area = /area/muriki/station/trawler_dock
	local_crash_sites = OUTPOST_SURFACE_CRASHES

/obj/effect/shuttle_landmark/premade/trawler/beltmine
	name = "Reclaimation Yard (Trawler bay)"
	landmark_tag = "trawler_yard"
	base_turf = /turf/simulated/floor
	base_area = /area/offworld/asteroidyard/station/dockingbay
	local_crash_sites = OUTPOST_ASTEROID_CRASHES

/obj/effect/shuttle_landmark/premade/trawler/prospector
	name = "Prospector (Trawler Dock)"
	landmark_tag = "prospector_docks_trawler"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/trawler/confinementbeam
	name = "Confinement Beam (Trawler Dock)"
	landmark_tag = "confinementbeam_trawler"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior
	local_crash_sites = OUTPOST_CONFINEMENTBEAM_CRASHES
