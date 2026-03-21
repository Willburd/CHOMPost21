/datum/design_techweb/awp_338
	SET_AMMO_DESIGN_NAMEDESC("rifle magazine (.338 Lapua standard)")
	id = "awp_338"
	materials = list(MAT_STEEL = 5600)
	build_type = AUTOLATHE
	build_path = /obj/item/ammo_magazine/awp
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HACKED,
		RND_SUBCATEGORY_WEAPONS_AMMO + RND_SUBCATEGORY_WEAPONS_AMMO_RIFLE
	)

/datum/design_techweb/awp_338_ap
	SET_AMMO_DESIGN_NAMEDESC("rifle magazine (.338 Lapua standard armor piercing)")
	id = "awp_338_ap"
	materials = list(MAT_STEEL = 5600, MAT_PLASTEEL = 1200)
	build_type = AUTOLATHE
	build_path = /obj/item/ammo_magazine/awp_338_ap
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HACKED,
		RND_SUBCATEGORY_WEAPONS_AMMO + RND_SUBCATEGORY_WEAPONS_AMMO_RIFLE
	)

/datum/design_techweb/hectate
	SET_AMMO_DESIGN_NAMEDESC("rifle magazine (.50 BMG)")
	id = "hectate"
	materials = list(MAT_STEEL = 5600)
	build_type = AUTOLATHE
	build_path = /obj/item/ammo_magazine/hectate
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HACKED,
		RND_SUBCATEGORY_WEAPONS_AMMO + RND_SUBCATEGORY_WEAPONS_AMMO_RIFLE
	)

/datum/design_techweb/hectate_ap
	SET_AMMO_DESIGN_NAMEDESC("rifle magazine (.50 BMG armor piercing)")
	id = "hectate_ap"
	materials = list(MAT_STEEL = 5600, MAT_PLASTEEL = 1200)
	build_type = AUTOLATHE
	build_path =  /obj/item/ammo_magazine/hectate/ap
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HACKED,
		RND_SUBCATEGORY_WEAPONS_AMMO + RND_SUBCATEGORY_WEAPONS_AMMO_RIFLE
	)
