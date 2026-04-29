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

/datum/design_techweb/stent_kit
	name = "stent kit"
	desc = "Metal rods designed to interlock and pry something open. Authorization to enter maximum-security areas must be obtained before entering the terraforming unit."
	id = "stentkit"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(MAT_STEEL = 4500)
	build_path = /obj/item/stent_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
