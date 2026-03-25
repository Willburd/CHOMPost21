/datum/design_techweb/bearslap
	name = "bear slap"
	desc = "What sick deranged maniac designed this thing."
	id = "bearslap"
	build_type = PROTOLATHE
	materials = list(MAT_STEEL = 25000)
	build_path = /obj/item/blade_trap_kit
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY
	)

/datum/design_techweb/robot_scanner
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design_techweb/nanopaste
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
