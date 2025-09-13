/datum/design_techweb/hunter
	name = "Hybrid 'Hunter' net gun"
	id = "huntergun"
	materials = list(DEFAULT_WALL_MATERIAL = 6000, MAT_GLASS = 3000, MAT_SILVER = 1000)
	build_path = /obj/item/gun/energy/hunter
	// Outpost 21 edit begin - Missing data
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	announce_channels = list(DEPARTMENT_BITFLAG_SECURITY,CHANNEL_SCIENCE)
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE
	// Outpost 21 edit end
