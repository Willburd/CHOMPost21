/datum/design_techweb/board/request_computeralt
	SET_CIRCUIT_DESIGN_NAMEDESC("request computer")
	id = "request_computeralt"
	build_path = /obj/item/circuitboard/supply_request_computeralt
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design_techweb/board/metal_detector
	SET_CIRCUIT_DESIGN_NAMEDESC("threat scanner")
	id = "metal_detector"
	build_path = /obj/item/circuitboard/metal_detector
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_MACHINE_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design_techweb/board/lockdown_console
	SET_CIRCUIT_DESIGN_NAMEDESC("lockdown console")
	id = "lockdown_console"
	build_path = /obj/item/circuitboard/lockdown_console
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_COMMAND
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_COMMAND
