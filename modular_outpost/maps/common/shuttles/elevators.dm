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
