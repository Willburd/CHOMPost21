/datum/design_techweb/hunter
	name = "Hybrid 'Hunter' net gun"
	id = "huntergun"
	materials = list(DEFAULT_WALL_MATERIAL = 6000, MAT_GLASS = 3000, MAT_SILVER = 1000)
	build_path = /obj/item/gun/energy/hunter
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY


// Overrides
/datum/design_techweb/flora_gun
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE // Outpost 21 edit(port) ?
