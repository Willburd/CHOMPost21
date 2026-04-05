//
// Surface ---------------------------------------------------------------------
//
/obj/vehicle/has_interior/heavyarmor_tank/garage_tank
	name = "K72-4"
	desc = "Kylos model 72 varient 4, heavy asset reclaimation vehicle. For when lesser force has failed."
	interior_area = /area/vehicle_interior/heavyarmor_tank_A
	haskey = FALSE

/obj/vehicle/has_interior/heavyarmor_carrier/garage_apc
	name = "armored personal carrier"
	interior_area = /area/vehicle_interior/heavyarmor_carrier_A
	weapons_equiped = list(/obj/structure/vehicle_interior_weapon/pacify)
	haskey = FALSE

/obj/vehicle/has_interior/heavyarmor_medic/bradley
	name = "Nurse Bradley"
	desc = "The Heavy Medical Recovery vehicle. Designed to break into areas, rescue crew, and get out, no matter how dangerous. Classified as Station Suppository."
	interior_area = /area/vehicle_interior/heavyarmor_medic_recovery
	haskey = FALSE

//
// Central ---------------------------------------------------------------------
//
/obj/vehicle/has_interior/heavyarmor_tank/central_tank
	name = "K72-4"
	desc = "Kylos model 72 varient 4, heavy asset reclaimation vehicle. For when lesser force has failed."
	interior_area = /area/vehicle_interior/heavyarmor_tank_B

/obj/vehicle/has_interior/heavyarmor_carrier/central_apc
	name = "armored personal carrier"
	interior_area = /area/vehicle_interior/heavyarmor_carrier_B
	weapons_equiped = list(/obj/structure/vehicle_interior_weapon/hmg)

/obj/vehicle/has_interior/heavyarmor_carrier/ert_apc
	name = "armored personal carrier"
	interior_area = /area/vehicle_interior/heavyarmor_carrier_C
	weapons_equiped = list(/obj/structure/vehicle_interior_weapon/hmg)

//
// Interior areas ---------------------------------------------------------------------
//
/area/vehicle_interior
	sound_env = SMALL_ENCLOSED
	flags = AREA_BLOCK_INSTANT_BUILDING | RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT | AREA_BLOCK_PHASE_SHIFT | BLUE_SHIELDED
	requires_power = FALSE
	color_grading = COLORTINT_DIM

/area/vehicle_interior/heavyarmor_carrier_A
	name = "\improper Carrier A"

/area/vehicle_interior/heavyarmor_carrier_B
	name = "\improper Carrier B"

/area/vehicle_interior/heavyarmor_carrier_C
	name = "\improper Carrier C"

/area/vehicle_interior/heavyarmor_tank_A
	name = "\improper Tank A"

/area/vehicle_interior/heavyarmor_tank_B
	name = "\improper Tank B"

/area/vehicle_interior/heavyarmor_tank_C
	name = "\improper Tank C"

/area/vehicle_interior/heavyarmor_medic_recovery
	name = "\improper Medic Recovery Vehicle"
