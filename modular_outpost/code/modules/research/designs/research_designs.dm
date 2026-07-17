/datum/design_techweb/telescience_probe_monitor
	name = "Telescience Probe Monitor"
	id = "telesci_probe_monitor"
	build_type = PROTOLATHE
	build_path = /obj/item/bug_monitor/telesci
	materials = list(MAT_STEEL = 1500, MAT_GLASS = 3000)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design_techweb/telescience_probe
	name = "Telescience Probe"
	id = "telesci_probe"
	build_type = PROTOLATHE
	build_path = /obj/item/camerabug/telesci
	materials = list(MAT_STEEL = 2500, MAT_GLASS = 1000)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design_techweb/advanced_slimescanner
	name = "advanced slime scanner"
	desc = "A slime scanner with ranged scanning capabilities."
	id = "adv_slime_scanner"
	build_type = PROTOLATHE
	build_path = /obj/item/slime_scanner/advanced
	materials = list(MAT_STEEL = 1500, MAT_GLASS = 600, MAT_SILVER = 200)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design_techweb/airlock_braces
	name = "airlock brace"
	desc = "A sturdy device that can be attached to an airlock to reinforce it and provide additional security."
	id = "airlock_braces"
	build_type = PROTOLATHE
	materials = list(MAT_STEEL = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/airlock_brace
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE
