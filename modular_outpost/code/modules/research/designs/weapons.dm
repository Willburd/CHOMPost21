/datum/design_techweb/confetti_cannon/pie
	name = "pie cannon"
	desc = "Stuff it with pie and shoot! You'll be a hit at every party."
	id = "pie_cannon"
	materials = list(MAT_STEEL = 3000, MAT_GLASS = 3000)
	build_path = /obj/item/gun/launcher/confetti_cannon/pie
	build_type = PROTOLATHE
	category = list(
		RND_CATEGORY_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design_techweb/grenade_dephasing
	name = "Dephasing Grenade"
	desc = "Causes localized instability in bluespace, dephasing things into real space if they are near enough to it."
	id = "grenade_phase"
	materials = list(MAT_STEEL = 3000, MAT_GLASS = 3000)
	build_path = /obj/item/grenade/dephasing
	build_type = PROTOLATHE
	category = list(
		RND_CATEGORY_WEAPONS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE


// Overrides
