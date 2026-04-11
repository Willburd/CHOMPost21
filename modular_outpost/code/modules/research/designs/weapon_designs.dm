/datum/design_techweb/hunter
	name = "Hybrid 'Hunter' net gun"
	id = "huntergun"
	materials = list(DEFAULT_WALL_MATERIAL = 6000, MAT_GLASS = 3000, MAT_SILVER = 1000)
	build_path = /obj/item/gun/energy/hunter
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design_techweb/sledgehammer
	name = "sledgehammer"
	desc = "A long, heavy hammer meant to be used with both hands."
	id = "sledgehammer"
	build_type = AUTOLATHE
	materials = list(MAT_STEEL = 12000)
	build_path = /obj/item/material/twohanded/sledgehammer
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MELEE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

// Overrides
/datum/design_techweb/flora_gun
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE
