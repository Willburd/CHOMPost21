/datum/design_techweb/hunter
	name = "Hybrid 'Hunter' net gun"
	id = "huntergun"
	materials = list(DEFAULT_WALL_MATERIAL = 6000, MAT_GLASS = 3000, MAT_SILVER = 1000)
	build_path = /obj/item/gun/energy/hunter
	// Outpost 21 edit begin - Missing data
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	// Outpost 21 edit end
