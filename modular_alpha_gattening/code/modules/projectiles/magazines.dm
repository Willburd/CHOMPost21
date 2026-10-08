/// Creates a magazine for all ammo subtypes of a caliber family.
// mag_id         : Non-string id of the magazine, used for the path of the final object
// cal_id         : Non-string id of the caliber family, such as: tenmm
// str_name       : Player visible string name of ammo type, such as: "10mm"
// icon_dmi       : Dmi file where the iconstate exists, such as: 'icons/obj/ammo.dmi'
// state          : Icon_state string of magazine used by this magazine, such as: "10mm-extended"
// has_count_icons: If TRUE, the magazine has multiple icon_states depending on how full it is.
// mag_size       : Number of bullets capable of being stored in the magazine
// extended_size  : Number of bullets capable of being stored in the extended version of the magazine
// drum_size  	  : Number of bullets capable of being stored in the drum version of the magazine
#define CREATE_MAGAZINE_VARIANTS(mag_id, cal_id, str_name, icon_dmi, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##mag_id { \
	name = "magazine (" + str_name + ")"; \
	desc = "A " + str_name + " magazine, it can fit " + #mag_size + " rounds."; \
	icon = icon_dmi; \
	icon_state = state; \
	mag_type = MAGAZINE; \
	caliber = #cal_id; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id; \
	max_ammo = mag_size; \
	multiple_sprites = has_count_icons; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/empty { \
	initial_ammo = 0; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/practice { \
	name = "magazine (" + str_name + " practice)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/practice; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/rubber { \
	name = "magazine (" + str_name + " rubber)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/rubber; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/ap { \
	name = "magazine (" + str_name + " armor-piercing)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/ap; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/hp { \
	name = "magazine (" + str_name + " hollow-point)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/hp; \
}; \
/obj/item/ammo_magazine/mag_ ##mag_id/emp { \
	name = "magazine (" + str_name + " haywire)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size, MAT_URANIUM = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/emp; \
};

// Optional extended mag
#define CREATE_MAGAZINE_EXTENDED(mag_id, str_name, icon_dmi, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##mag_id/extended { \
	name = "magazine (" + str_name + " extended)"; \
	icon = icon_dmi; \
	icon_state = state; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
};

// Optional drum mag
#define CREATE_MAGAZINE_DRUM(mag_id, str_name, icon_dmi, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##mag_id/drum { \
	name = "drum (" + str_name + ")"; \
	icon = icon_dmi; \
	icon_state = state; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
};

// Ammo boxes
#define CREATE_AMMOBOX_VARIANTS(cal_id, str_name, icon_dmi, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/ammo_box/box_ ##cal_id { \
	name = "ammo box (" + str_name + ")"; \
	desc = "A box of " + #mag_size + " " + str_name + " rounds"; \
	icon = icon_dmi; \
	icon_state = state; \
	caliber = #cal_id; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##cal_id/rubber { \
	name = "ammo box (" + str_name + " rubber )"; \
	desc = "A box of " + #mag_size + " " + str_name + " rubber rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/rubber; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##cal_id/hp { \
	name = "ammo box (" + str_name + " hollow-point )"; \
	desc = "A box of " + #mag_size + " " + str_name + " hollow-point rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/hp; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##cal_id/ap { \
	name = "ammo box (" + str_name + " armor-piercing )"; \
	desc = "A box of " + #mag_size + " " + str_name + " armor-piercing rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/ap; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##cal_id/emp { \
	name = "ammo box (" + str_name + " haywire )"; \
	desc = "A box of " + #mag_size + " " + str_name + " haywire rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##cal_id/emp; \
};

/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

// testtenmil guns
CREATE_MAGAZINE_VARIANTS(testtenmil, tenmm, "10mm", 'icons/obj/ammo.dmi', "10mm", TRUE, 20)
CREATE_MAGAZINE_EXTENDED(testtenmil, "10mm", 'icons/obj/ammo.dmi', "10mm", TRUE, 30)
CREATE_MAGAZINE_DRUM(testtenmil, "10mm", 'icons/obj/ammo.dmi', "ashot-mag", TRUE, 50)
// Ammo box
CREATE_AMMOBOX_VARIANTS(tenmm, "10mm", 'icons/obj/ammo.dmi', "boxhrifle", TRUE, 50)

/////////////////////////////////////////////////////////////////////////////////////////
// NEXT AMMO
/////////////////////////////////////////////////////////////////////////////////////////



#undef CREATE_MAGAZINE_VARIANTS
#undef CREATE_MAGAZINE_EXTENDED
#undef CREATE_AMMOBOX_VARIANTS
