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

//////////////////////////////////////////////////////////////
// Tramshuttle
/datum/shuttle/autodock/multi/tram
	name = "Station Tram"
	warmup_time = 5
	shuttle_area = /area/shuttle/tram
	docking_controller_tag = "Tram"
	current_location = "tram_shed"
	bluespace = FALSE // don't smoosh shadekin
	can_be_haunted = TRUE
//	landmark_transition = "tram_transit"
	ceiling_type = /turf/simulated/shuttle/floor/white

	destination_tags = list(
		"tram_waste",
		"tram_eng",
		"tram_civ"
	)

	allow_short_crashes = TRUE
	crash_message = "Tram system derailment detected."
	crash_locations = list(
		"tram_crash_waste",
		"tram_crash_eng",
		"tram_crash_med",
		"tram_crash_civ",
		"tram_crash_red",
		"tram_crash_civ_mean",
		"tram_crash_civ_ultramean",
		"tram_crash_eng_mean",
		"tram_crash_eng_ultramean",
		"tram_crash_waste_mean",
		"tram_crash_terraformer_mean",
	)


/datum/shuttle/autodock/multi/tram/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(10)
	if(SShaunting.get_world_haunt() >= 4)
		return prob(1) && prob(1)
	return FALSE

/obj/effect/shuttle_landmark/premade/tram/shed
	name = "Tram Station - Shed"
	landmark_tag = "tram_shed"
	base_area = /area/muriki/tramstation/shed
	base_turf = /turf/simulated/floor/reinforced


/obj/effect/shuttle_landmark/premade/tram/base
	name = "Tram Station - Waste and Maintenance"
	landmark_tag = "tram_waste"
	base_area = /area/muriki/tramstation/waste
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/transit
	name = "Tram Station - Transit"
	landmark_tag = "tram_transit"
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/eng
	name = "Tram Station - Engineering Cargo"
	landmark_tag = "tram_eng"
	base_area = /area/muriki/tramstation/cargeng
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/civ
	name = "Tram Station - Civilian"
	landmark_tag = "tram_civ"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_waste
	name = "Tram Crash - Waste"
	landmark_tag = "tram_crash_waste"
	base_area = /area/muriki/grounds/tramlinewest
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_waste/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng
	name = "Tram Crash - Eng"
	landmark_tag = "tram_crash_eng"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_eng/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_med
	name = "Tram Crash - Med"
	landmark_tag = "tram_crash_med"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_med/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ
	name = "Tram Crash - Civ"
	landmark_tag = "tram_crash_civ"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_civ/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_red
	name = "Tram Crash - Red"
	landmark_tag = "tram_crash_red"
	base_area = /area/specialty/redspace
	base_turf = /turf/simulated/floor/flesh

/obj/effect/shuttle_landmark/premade/tram/crash_red/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ_mean
	name = "Tram Crash - Civ Mean"
	landmark_tag = "tram_crash_civ_mean"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_civ_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_civ_ultramean
	name = "Tram Crash - Civ Ultra Mean"
	landmark_tag = "tram_crash_civ_ultramean"
	base_area = /area/muriki/tramstation/civ
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_civ_ultramean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng_mean
	name = "Tram Crash - Eng Mean"
	landmark_tag = "tram_crash_eng_mean"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_eng_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_eng_ultramean
	name = "Tram Crash - Eng Ultra Mean"
	landmark_tag = "tram_crash_eng_ultramean"
	base_area = /area/muriki/grounds/tramlineeast
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/premade/tram/crash_eng_ultramean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_waste_mean
	name = "Tram Crash - Waste Mean"
	landmark_tag = "tram_crash_waste_mean"
	base_area = /area/muriki/grounds/tramlinewest
	base_turf = /turf/simulated/floor/outdoors/mud/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_waste_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/tram/crash_terraformer_mean
	name = "Tram Crash - Terraformer Mean"
	landmark_tag = "tram_crash_terraformer_mean"
	base_area = /area/muriki/grounds/terraform
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki

/obj/effect/shuttle_landmark/premade/tram/crash_terraformer_mean/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

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

//////////////////////////////////////////////////////////////
// Skipjack
/datum/shuttle/autodock/multi/skipjack
	name = "Skipjack"
	warmup_time = 0
	shuttle_area = /area/shuttle/skipjack
	current_location = "skipjack_base"
	landmark_transition = "skipjack_transit"
	can_cloak = TRUE
	cloaked = TRUE
	announcer = "Automated Traffic Control"
	arrival_message = "Attention.  Unidentified object approaching the colony."
	departure_message = "Attention.  Unidentified object exiting local space.  Unidentified object expected to escape Muriki gravity well with current velocity."
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

	destination_tags = list(
		"skipjack_base",
		"skipjack_station_mount",
		"skipjack_yard_west",
		"skipjack_yard_east",
		"skipjack_beam_east"
	)

/obj/effect/shuttle_landmark/premade/skipjack/base
	name = "Home Base"
	landmark_tag = "skipjack_base"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/transit
	name = "Deep Space"
	landmark_tag = "skipjack_transit"

/obj/effect/shuttle_landmark/premade/skipjack/station_ne
	name = "ES Outpost 21 (Mountains)"
	landmark_tag = "skipjack_station_mount"
	base_area = /area/muriki/skyline/north
	base_turf = /turf/simulated/open/muriki

/obj/effect/shuttle_landmark/premade/skipjack/station_nw
	name = "Reclaimation Yard (West)"
	landmark_tag = "skipjack_yard_west"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/station_se
	name = "Reclaimation Yard (East)"
	landmark_tag = "skipjack_yard_east"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/skipjack/beam_ne
	name = "Confinement Beam (East)"
	landmark_tag = "skipjack_beam_east"
	base_area = /area/space
	base_turf = /turf/space

//////////////////////////////////////////////////////////////
// ERT Shuttle
/datum/shuttle/autodock/ferry/specialops
	name = "Special Operations"
	location = FERRY_LOCATION_STATION
	warmup_time = 10
	shuttle_area = /area/shuttle/specops
	landmark_station = "specops_cc"
	landmark_offsite = "specops_station"
	docking_controller_tag = "specops_shuttle_port"
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki

/obj/effect/shuttle_landmark/premade/specops/centcom
	name = "ESCC Bunker"
	landmark_tag = "specops_cc"
	docking_controller = "specops_centcom_dock"
	base_area = /area/space
	base_turf = /turf/space

/obj/effect/shuttle_landmark/premade/specops/station
	name = "ES Outpost 21"
	landmark_tag = "specops_station"
	docking_controller = "specops_dock_airlock"
	special_dock_targets = list("Special Operations" = "specops_shuttle_fore")

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
	crash_locations = list(
		"crash_cargoyard",
		"crash_north",
		"crash_south",
		"crash_engi_roof",
		"crash_sec_roof",
		"crash_garden_roof"
	)

/datum/shuttle/autodock/overmap/medical/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
	if(emagged_crash)
		return TRUE
	// If on highest level of spooky let the tram crash happen
	if(SShaunting.get_world_haunt() >= 5)
		return prob(1) && prob(1)
	return FALSE

// Docks
/obj/effect/shuttle_landmark/premade/medical/muriki
	name = "ES Outpost 21 (Medical Dock)"
	landmark_tag = "outpost_medical_hangar"
	base_turf = /turf/simulated/floor
	base_area = /area/medical/hangar

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
	crash_locations = list(
		"crash_cargoyard",
		"crash_north",
		"crash_south",
		"crash_engi_roof",
		"crash_sec_roof",
		"crash_garden_roof"
	)

/datum/shuttle/autodock/overmap/security/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
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

/obj/effect/shuttle_landmark/premade/security/aisat_security
	name = "AI Satellite (Security Dock)"
	landmark_tag = "aisat_security"
	docking_controller = "aisat_security_controller"
	base_turf = /turf/space
	base_area = /area/offworld/confinementbeam/exterior

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
	crash_locations = list(
		"crash_cargoyard",
		"crash_north",
		"crash_south",
		"crash_engi_roof",
		"crash_sec_roof",
		"crash_garden_roof"
	)

/datum/shuttle/autodock/overmap/trawler/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
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

/obj/effect/shuttle_landmark/premade/trawler/beltmine
	name = "Reclaimation Yard (Trawler bay)"
	landmark_tag = "trawler_yard"
	base_turf = /turf/simulated/floor
	base_area = /area/offworld/asteroidyard/station/dockingbay

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
	crash_locations = list(
		"crash_cargoyard",
		"crash_north",
		"crash_south",
		"crash_engi_roof",
		"crash_sec_roof",
		"crash_garden_roof"
	)

/datum/shuttle/autodock/multi/beamtransit/should_crash(var/obj/effect/shuttle_landmark/intended_destination)
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

/obj/effect/shuttle_landmark/premade/beamtransit/transit
	name = "Deep Space"
	landmark_tag = "beam_space"

/obj/effect/shuttle_landmark/premade/beamtransit/beam_sat
	name = "ES 21-4 Confinement Beam Platform"
	landmark_tag = "beam_sat"
	docking_controller = "beam_sat_controller"
	base_area = /area/offworld/confinementbeam/exterior
	base_turf = /turf/simulated/floor/airless

//////////////////////////////////////////////////////////////
// RogueMiner "Belter: Shuttle

/datum/shuttle/autodock/ferry/belter
	name = "Belter"
	location = FERRY_LOCATION_STATION
	warmup_time = 5
	move_time = 30
	shuttle_area = /area/shuttle/belter
	landmark_station = "belter_station"
	landmark_offsite = "belter_zone1"
	landmark_transition = "belter_transit"
	docking_controller_tag = "belter_docking"
	move_direction = SOUTH

/datum/shuttle/autodock/ferry/belter/New()
	move_time = move_time + rand(-5 SECONDS, 5 SECONDS)
	..()

/obj/effect/shuttle_landmark/premade/belter/asteroid_yard
	name = "Reclaimation Yard (Belter Platform)"
	landmark_tag = "belter_station"
	base_area = /area/offworld/asteroidyard/external
	base_turf = /turf/simulated/floor/airless

/obj/effect/shuttle_landmark/premade/belter/transit
	name = "Deep Space"
	landmark_tag = "belter_transit"

//////////////////////////////////////////////////////////////
// Tram to redspace
// Other stations in in modular_outpost\maps\submaps\deepdark\deepdark.dm due to POI checks
/area/shuttle/darktransit
	name = "\improper Unknown Tram"
	flags = AREA_FLAG_IS_NOT_PERSISTENT|AREA_BLOCK_PHASE_SHIFT
	base_turf = /turf/simulated/floor/flesh
	haunted = TRUE

/datum/shuttle/autodock/multi/underdark
	name = "Unknown Tram"
	warmup_time = 5
	shuttle_area = /area/shuttle/darktransit
	current_location = "dark_hell"
	ceiling_type = /turf/simulated/shuttle/floor/black/turfpack/muriki
	can_be_haunted = TRUE

	destination_tags = list(
		"dark_start",
		"dark_hell",
		"dark_end"
	)

/obj/effect/shuttle_landmark/premade/underdark/hell
	name = "Somewhere Else"
	landmark_tag = "dark_hell"
	base_area = /area/specialty/redspace
	base_turf = /turf/simulated/floor/flesh

/obj/effect/shuttle_landmark/premade/underdark/start
	name = "Station Platform"
	landmark_tag = "dark_start"
	base_area = /area/mine/explored/muriki/cave/deepdark
	base_turf = /turf/simulated/floor/plating/turfpack/muriki

/obj/effect/shuttle_landmark/premade/underdark/end
	name = "End Of The Line"
	landmark_tag = "dark_end"
	base_area = /area/mine/explored/muriki/cave/deepdark
	base_turf = /turf/simulated/floor/plating/turfpack/muriki


//////////////////////////////////////////////////////////////
// Generic landings
/obj/effect/shuttle_landmark/premade/generic/arrivals
	name = "ES Outpost 21 (Near Arrivals)"
	landmark_tag = "outpost_landing_pad"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/shutt

/obj/effect/shuttle_landmark/premade/generic/engineering
	name = "ES Outpost 21 (Near Engineering)"
	landmark_tag = "outpost_engineering_pad"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/mine/explored/muriki/surface

/obj/effect/shuttle_landmark/premade/generic/prospector_port
	name = "Prospector (Far-Port Dock)"
	landmark_tag = "prospector_public_port"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/generic/prospector_starboard
	name = "Prospector (Far-Starboard Dock)"
	landmark_tag = "prospector_public_starboard"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard // TODO

/obj/effect/shuttle_landmark/premade/generic/beltmine
	name = "Reclaimation Yard (Civilian Dock)"
	landmark_tag = "orbitalyard_civ"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard

/obj/effect/shuttle_landmark/premade/generic/beltmine_north
	name = "Reclaimation Yard (North)"
	landmark_tag = "orbitalyard_north"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard

/obj/effect/shuttle_landmark/premade/generic/beltmine_south
	name = "Reclaimation Yard (South)"
	landmark_tag = "orbitalyard_south"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard

/obj/effect/shuttle_landmark/premade/generic/beltmine_east
	name = "Reclaimation Yard (East)"
	landmark_tag = "orbitalyard_east"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard

/obj/effect/shuttle_landmark/premade/generic/beltmine_west
	name = "Reclaimation Yard (West)"
	landmark_tag = "orbitalyard_west"
	base_turf = /turf/space
	base_area = /area/offworld/asteroidyard

// Crash bang boom!
/obj/effect/shuttle_landmark/premade/generic/crash_cargoyard
	name = "Crash - Cargo Yard"
	landmark_tag = "crash_cargoyard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/yard

/obj/effect/shuttle_landmark/premade/generic/crash_cargoyard/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_north
	name = "Crash - North"
	landmark_tag = "crash_north"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/engi

/obj/effect/shuttle_landmark/premade/generic/crash_north/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_south
	name = "Crash - South"
	landmark_tag = "crash_south"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/turfpack/muriki
	base_area = /area/muriki/grounds/sec

/obj/effect/shuttle_landmark/premade/generic/crash_south/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_engiroof
	name = "Crash - Engineering Roof"
	landmark_tag = "crash_engi_roof"
	base_turf = /turf/simulated/open
	base_area = /area/muriki/rooftop/engineering

/obj/effect/shuttle_landmark/premade/generic/crash_engiroof/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_secroof
	name = "Crash - Security Roof"
	landmark_tag = "crash_sec_roof"
	base_turf = /turf/simulated/open
	base_area = /area/muriki/rooftop/security

/obj/effect/shuttle_landmark/premade/generic/crash_secroof/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

/obj/effect/shuttle_landmark/premade/generic/crash_gardenroof
	name = "Crash - Garden Roof"
	landmark_tag = "crash_garden_roof"
	base_turf = /turf/simulated/open
	base_area = /area/hydroponics/publicgarden

/obj/effect/shuttle_landmark/premade/generic/crash_gardenroof/is_valid(var/datum/shuttle/shuttle)
	if(shuttle.current_location == src)
		return FALSE
	return TRUE

// ELEVATORS --------------------------------------------------------
/obj/turbolift_map_holder/muriki/medevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = EAST
	name = "Medbay Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/medibasement,
		/area/turbolift/medical,
		/area/turbolift/mediupper,
		)

/obj/turbolift_map_holder/muriki/secevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = NORTH
	name = "Security Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/secbase,
		/area/turbolift/secmain,
		/area/turbolift/secupper,
		)

/obj/turbolift_map_holder/muriki/civevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = SOUTH
	name = "Civilian Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/civbase,
		/area/turbolift/civmain,
		/area/turbolift/civupper,
		)

/obj/turbolift_map_holder/muriki/scievator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = SOUTH
	name = "Science Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/scibase,
		/area/turbolift/scimain,
		/area/turbolift/sciupper,
		)
