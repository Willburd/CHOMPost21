/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

/obj/item/ammo_casing/case_10mm
	desc = "A 10mm bullet casing."
	caliber = GUN_CHAMBER_10MIL
	projectile_type = /obj/item/projectile/bullet/proj_10mm
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST)

/obj/item/ammo_casing/case_10mm/practice
	desc = "A 10mm practice bullet casing."
	icon_state = "r-casing"
	projectile_type = /obj/item/projectile/bullet/proj_10mm

/obj/item/ammo_casing/case_10mm/rubber
	desc = "A 10mm rubber bullet casing."
	icon_state = "r-casing"
	projectile_type = /obj/item/projectile/bullet/proj_10mm/rubber

/obj/item/ammo_casing/case_10mm/ap
	desc = "A armor-piercing 10mm round."
	projectile_type = /obj/item/projectile/bullet/proj_10mm/ap

/obj/item/ammo_casing/case_10mm/hp
	desc = "A hollow-point 10mm round."
	projectile_type = /obj/item/projectile/bullet/proj_10mm/hp

/obj/item/ammo_casing/case_10mm/emp
	name = "10mm haywire round"
	desc = "A 10mm bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small // todo
	icon_state = "empcasing"
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST, MAT_URANIUM = PER_BULLET_MATERIAL_COST)
