/datum/design_techweb/organ/internal/augment/armmounted/apc_connector
	name = "APC Connector Implant"
	desc = "A large implant that fits into a subject's arm. It allows a synthetic to connect to an area power controller to recharge."
	id = "implant_apc"
	// req_tech = list(TECH_BIO = 5, TECH_MATERIAL = 4, TECH_POWER = 4)
	build_type = PROTOLATHE
	materials = list(MAT_STEEL = 6000, MAT_GLASS = 6000, MAT_PHORON = 1000, MAT_GOLD = 2000)
	build_path = /obj/item/organ/internal/augment/armmounted/apc_connector
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
