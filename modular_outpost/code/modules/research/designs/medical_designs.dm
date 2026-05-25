#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/datum/design_techweb/board/needle_cleaner_board
	name = "needle cleaning centrifuge circuit"
	id = "needle_cleaner_board"
	build_path = /obj/item/circuitboard/needle_cleaner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
