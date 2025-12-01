/datum/design_techweb/retail_scanner
	name = "Retail Scanner"
	desc = "Scans the value of items for export."
	id = "retail_scanner"
	materials = list(MAT_STEEL = 2000, MAT_GLASS = 2000)
	build_path = /obj/item/retail_scanner
	build_type = PROTOLATHE
	category = list(
		RND_CATEGORY_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE


// Overrides

/datum/design_techweb/pda_cartridge/science
	id = "cart_science"
	build_path = /obj/item/cartridge/signal/engineering
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
