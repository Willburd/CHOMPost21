/datum/design_techweb/mechfab
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

// Overrides
/datum/design_techweb/mechfab/vehicle/basic
	build_path = /obj/item/uav/has_cart
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY

/datum/design_techweb/mechfab/equipment/mecha_firesaw
	name = "fire-rescue saw"
	desc = "An exosuit-mounted anti-material circular saw with multiple safety guards. Designed for fire rescue operations."
	id = "mech_firesaw"
	materials = list(MAT_STEEL = MATERIAL_COST(4), MAT_PLASTIC = MATERIAL_COST(1.5), MAT_GLASS = MATERIAL_COST(0.5))
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/powertool/firesaw
	category = list(
		RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
