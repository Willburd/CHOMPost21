/// Creates a casing for all ammo subtypes of a caliber family.
// id             : Non-string id of the caliber family, such as: tenmm
// str_name       : Player visible string name of ammo type, such as: "10mm"
// haywiretype    : Projectile subtype path used by emp shell, such as: /obj/item/projectile/ion/small
#define CREATE_CALIBER_VARIENTS(id, name_str, haywiretype) \
/obj/item/ammo_casing/case_ ##id { \
	name = "A " + name_str + " round"; \
	desc = "A " + name_str + " bullet casing."; \
	caliber = #id; \
	projectile_type = /obj/item/projectile/bullet/proj_ ##id; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST); \
}; \
/obj/item/ammo_casing/case_ ##id/BULLET_TYPE_PRACTICE { \
	name = "A " + name_str + " practice round"; \
	desc = "A " + name_str + " practice bullet casing."; \
	icon_state = "r-casing"; \
	projectile_type = /obj/item/projectile/bullet/proj_ ##id/BULLET_TYPE_PRACTICE; \
}; \
/obj/item/ammo_casing/case_ ##id/BULLET_TYPE_RUBBER { \
	name = "A " + name_str + " rubber round"; \
	desc = "A " + name_str + " rubber bullet casing."; \
	icon_state = "r-casing"; \
	projectile_type = /obj/item/projectile/bullet/proj_ ##id/BULLET_TYPE_RUBBER; \
}; \
/obj/item/ammo_casing/case_ ##id/BULLET_TYPE_ARMORPIERCING { \
	name = "A " + name_str + " armor-piercing round"; \
	desc = "A armor-piercing " + name_str + " bullet casing."; \
	projectile_type = /obj/item/projectile/bullet/proj_ ##id/BULLET_TYPE_ARMORPIERCING; \
}; \
/obj/item/ammo_casing/case_ ##id/BULLET_TYPE_HOLLOWPOINT { \
	name = "A " + name_str + " hollow-point round"; \
	desc = "A hollow-point " + name_str + " bullet casing."; \
	projectile_type = /obj/item/projectile/bullet/proj_ ##id/BULLET_TYPE_HOLLOWPOINT; \
}; \
/obj/item/ammo_casing/case_ ##id/emp { \
	name = "A " + name_str + " haywire round"; \
	desc = "A " + name_str + " bullet casing fitted with a single-use ion pulse generator."; \
	projectile_type = haywiretype; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST, MAT_URANIUM = PER_BULLET_MATERIAL_COST); \
};

/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

CREATE_CALIBER_VARIENTS(tenmm, "10mm", /obj/item/projectile/ion/small)




#undef CREATE_CALIBER_VARIENTS
