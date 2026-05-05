//////////////////////////////////////////////////////////////
// Engineering Ferry
/area/shuttle/beamtransit
	name = "\improper Engineering Ferry"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
	base_turf = /turf/simulated/floor/plating/external/turfpack/muriki

/datum/shuttle/autodock/multi/beamtransit
	name = "Engineering Ferry"
	warmup_time = 5
	move_time = 90
	shuttle_area = /area/shuttle/beamtransit
	current_location = "beam_base"
	landmark_transition = "beam_space"
	docking_controller_tag = "beam_ferry_controller"
	announcer = "Automated Traffic Control"
	arrival_message = "Attention.  The engineering ferry is approaching the outpost."
	departure_message = "Attention.  The engineering ferry is now leaving the outpost."
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki
	can_be_haunted = TRUE
	move_direction = NORTH

	destination_tags = list(
		"beam_base",
		"beam_sat"
	)

	allow_short_crashes = TRUE
	crash_message = "Major impact detected, likely large vehicle impact. Please ensure functionality of all shuttles, and begin rescue operations."

/datum/shuttle/autodock/multi/beamtransit/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	if(!intended_destination.local_crash_sites?.len)
		return FALSE
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(1)
	return FALSE

/obj/effect/shuttle_landmark/premade/beamtransit/base
	name = "ES Outpost 21 (Engineering Dock)"
	landmark_tag = "beam_base"
	docking_controller = "beam_base_controller"
	base_turf = /turf/simulated/floor/plating/external/turfpack/muriki
	base_area = /area/muriki/grounds/engi
	local_crash_sites = OUTPOST_SURFACE_CRASHES

/obj/effect/shuttle_landmark/premade/beamtransit/transit
	name = "Deep Space"
	landmark_tag = "beam_space"

/obj/effect/shuttle_landmark/premade/beamtransit/beam_sat
	name = "ES 21-4 Confinement Beam Platform"
	landmark_tag = "beam_sat"
	docking_controller = "beam_sat_controller"
	base_area = /area/offworld/confinementbeam/exterior
	base_turf = /turf/simulated/floor/airless
	local_crash_sites = OUTPOST_CONFINEMENTBEAM_CRASHES
