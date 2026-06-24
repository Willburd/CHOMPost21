/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

#define MAG_SIZE_TENMM 20

/obj/item/ammo_magazine/mag_10mm
	name = "magazine (10mm)"
	icon_state = "10mm"
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * MAG_SIZE_TENMM)
	ammo_type = /obj/item/ammo_casing/case_10mm
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/mag_10mm/empty
	initial_ammo = 0

/obj/item/ammo_magazine/mag_10mm/practice
	name = "magazine (10mm practice)"
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * MAG_SIZE_TENMM)
	ammo_type = /obj/item/ammo_casing/case_10mm/practice

/obj/item/ammo_magazine/mag_10mm/rubber
	name = "magazine (10mm rubber)"
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * MAG_SIZE_TENMM)
	ammo_type = /obj/item/ammo_casing/case_10mm/rubber

/obj/item/ammo_magazine/mag_10mm/emp
	name = "magazine (10mm haywire)"
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * MAG_SIZE_TENMM, MAT_URANIUM = PER_BULLET_MATERIAL_COST * MAG_SIZE_TENMM)
	ammo_type = /obj/item/ammo_casing/case_10mm/emp

#undef MAG_SIZE_TENMM
