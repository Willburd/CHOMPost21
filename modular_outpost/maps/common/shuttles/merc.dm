//////////////////////////////////////////////////////////////
// Mercenary Shuttle
/obj/effect/overmap/visitable/ship/landable/mercenary_overmap
	name = "Mercenary"
	desc = "A rough and ready hacked together shuttle." // todo - make this actually interesting
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Mercenary"
	fore_dir = EAST
	overmap_stealth = TRUE

/obj/machinery/computer/shuttle_control/explore/mercenary_overmap
	name = "short jump console"
	shuttle_tag = "Mercenary"
	req_one_access = list(ACCESS_SYNDICATE)

/datum/shuttle/autodock/overmap/mercenary_overmap
	name = "Mercenary"
	warmup_time = 0
	current_location = "mercenary_base"
	//docking_controller_tag = "merc_shuttle"
	shuttle_area = list(/area/shuttle/mercenary)
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/mercenary/base
	name = "Home Base"
	landmark_tag = "mercenary_base"
	docking_controller = "merc_base"
	base_area = /area/space
	base_turf = /turf/space
