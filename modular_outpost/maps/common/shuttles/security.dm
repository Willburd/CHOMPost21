//////////////////////////////////////////////////////////////
// Security shuttle
/obj/effect/overmap/visitable/ship/landable/security
	name = "Security Carrier"
	desc = "A modified search and \"rescue\" spacecraft. No one can hide."
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Security Carrier"
	known = TRUE // we own this lol
	fore_dir = SOUTH

/datum/shuttle/autodock/overmap/security
	name = "Security Carrier"
	warmup_time = 0
	current_location = "outpost_security_hangar"
	docking_controller_tag = "sec_docker"
	shuttle_area = list(/area/shuttle/security)
	fuel_consumption = 1 //much less, due to being teeny
	ceiling_type = /turf/simulated/shuttle/floor/white/turfpack/muriki

	allow_short_crashes = TRUE
	crash_message = "Major impact detected, likely large vehicle impact. Please ensure functionality of all shuttles, and begin rescue operations."

/datum/shuttle/autodock/overmap/security/should_crash(obj/effect/shuttle_landmark/intended_destination)
	if(!intended_destination.local_crash_sites?.len)
		return FALSE
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(1)
	return FALSE

/obj/machinery/computer/shuttle_control/explore/security
	name = "short jump console"
	shuttle_tag = "Security Carrier"
	req_one_access = list(ACCESS_SECURITY)

/area/shuttle/security
	name = "\improper Security Shuttle"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/plating
	holomap_color = HOLOMAP_AREACOLOR_SECURITY


// Docks
/obj/effect/shuttle_landmark/premade/security/muriki
	name = "ES Outpost 21 (Security Dock)"
	landmark_tag = "outpost_security_hangar"
	base_turf = /turf/simulated/floor
	base_area = /area/security/hangar
	local_crash_sites = OUTPOST_SURFACE_CRASHES

/obj/effect/shuttle_landmark/premade/security/prospector
	name = "Prospector (Port Dock)"
	landmark_tag = "prospector_docks_security"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/security/confinementbeam
	name = "Confinement Beam (Security Dock)"
	landmark_tag = "confinementbeam_security"
	docking_controller = "beam_sat_security_controller"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior
	local_crash_sites = OUTPOST_CONFINEMENTBEAM_CRASHES

/obj/effect/shuttle_landmark/premade/security/aisat_security
	name = "AI Satellite (Security Dock)"
	landmark_tag = "aisat_security"
	docking_controller = "aisat_security_controller"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior
	local_crash_sites = OUTPOST_CONFINEMENTBEAM_CRASHES
