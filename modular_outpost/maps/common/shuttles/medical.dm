//////////////////////////////////////////////////////////////
// Medical shuttle
/obj/effect/overmap/visitable/ship/landable/medical
	name = "Medical Rescue"
	desc = "A modified search and rescue spacecraft. No man left behind."
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Medical Rescue"
	known = TRUE // we own this lol

/obj/machinery/computer/shuttle_control/explore/medical
	name = "short jump console"
	shuttle_tag = "Medical Rescue"
	req_one_access = list(ACCESS_MEDICAL)

/area/shuttle/medical
	name = "\improper Medevac Shuttle"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/plating
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/datum/shuttle/autodock/overmap/medical
	name = "Medical Rescue"
	warmup_time = 0
	current_location = "outpost_medical_hangar"
	docking_controller_tag = "med_docker"
	shuttle_area = list(/area/shuttle/medical)
	fuel_consumption = 1 //much less, due to being teeny
	ceiling_type = /turf/simulated/shuttle/floor/white/turfpack/muriki

	allow_short_crashes = TRUE
	crash_message = "Major impact detected, likely large vehicle impact. Please ensure functionality of all shuttles, and begin rescue operations."

/datum/shuttle/autodock/overmap/medical/should_crash(obj/effect/shuttle_landmark/intended_destination)
	if(!intended_destination.local_crash_sites?.len)
		return FALSE
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(1)
	return FALSE

/obj/effect/shuttle_landmark/premade/medical/muriki
	name = "ES Outpost 21 (Medical Dock)"
	landmark_tag = "outpost_medical_hangar"
	base_turf = /turf/simulated/floor
	base_area = /area/medical/hangar
	local_crash_sites = OUTPOST_SURFACE_CRASHES

/obj/effect/shuttle_landmark/premade/medical/prospector
	name = "Prospector (Starboard Dock)"
	landmark_tag = "prospector_docks_medical"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/medical/prospector_rear
	name = "Prospector (Medical Dock)"
	landmark_tag = "prospector_rear_medical"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/medical/confinementbeam
	name = "Confinement Beam (Medical Dock)"
	landmark_tag = "confinementbeam_medical"
	docking_controller = "beam_sat_medical_controller"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior
	local_crash_sites = OUTPOST_CONFINEMENTBEAM_CRASHES
