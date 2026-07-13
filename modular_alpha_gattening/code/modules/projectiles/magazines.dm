/// Creates a magazine for all ammo subtypes of a caliber family.
// id             : Non-string id of the caliber family, such as: tenmm
// str_name       : Player visible string name of ammo type, such as: "10mm"
// state          : Icon_state string of magazine used by this magazine, such as: "10mm-extended"
// has_count_icons: If TRUE, the magazine has multiple icon_states depending on how full it is.
// mag_size       : Number of bullets capable of being stored in the magazine
// extended_size  : Number of bullets capable of being stored in the extended version of the magazine
// drum_size  	  : Number of bullets capable of being stored in the drum version of the magazine
#define CREATE_MAGAZINE_VARIANTS(id, str_name, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##id { \
	name = "magazine (" + str_name + ")"; \
	desc = "A " + str_name + " magazine, it can fit " + #mag_size + " rounds."; \
	icon_state = state; \
	mag_type = MAGAZINE; \
	caliber = #id; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id; \
	max_ammo = mag_size; \
	multiple_sprites = has_count_icons; \
}; \
/obj/item/ammo_magazine/mag_ ##id/empty { \
	initial_ammo = 0; \
}; \
/obj/item/ammo_magazine/mag_ ##id/practice { \
	name = "magazine (" + str_name + " practice)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id/practice; \
}; \
/obj/item/ammo_magazine/mag_ ##id/rubber { \
	name = "magazine (" + str_name + " rubber)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id/rubber; \
}; \
/obj/item/ammo_magazine/mag_ ##id/ap { \
	name = "magazine (" + str_name + " armor-piercing)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id/ap; \
}; \
/obj/item/ammo_magazine/mag_ ##id/hp { \
	name = "magazine (" + str_name + " hollow-point)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id/hp; \
}; \
/obj/item/ammo_magazine/mag_ ##id/emp { \
	name = "magazine (" + str_name + " haywire)"; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size, MAT_URANIUM = PER_BULLET_MATERIAL_COST * mag_size); \
	ammo_type = /obj/item/ammo_casing/case_ ##id/emp; \
};

// Optional extended mag
#define CREATE_MAGAZINE_EXTENDED(id, str_name, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##id/extended { \
	name = "magazine (" + str_name + " extended)"; \
	icon_state = state; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
};

// Optional drum mag
#define CREATE_MAGAZINE_DRUM(id, str_name, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/mag_ ##id/drum { \
	name = "drum (" + str_name + ")"; \
	icon_state = state; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
};

// Ammo boxes
#define CREATE_AMMOBOX_VARIANTS(id, str_name, state, has_count_icons, mag_size) \
/obj/item/ammo_magazine/ammo_box/box_ ##id { \
	name = "ammo box (" + str_name + ")"; \
	desc = "A box of " + #mag_size + " " + str_name + " rounds"; \
	icon_state = state; \
	caliber = #id; \
	multiple_sprites = has_count_icons; \
	max_ammo = mag_size; \
	ammo_type = /obj/item/ammo_casing/case_ ##id; \
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST * mag_size); \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##id/rubber { \
	name = "ammo box (" + str_name + " rubber )"; \
	desc = "A box of " + #mag_size + " " + str_name + " rubber rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##id/rubber; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##id/hp { \
	name = "ammo box (" + str_name + " hollow-point )"; \
	desc = "A box of " + #mag_size + " " + str_name + " hollow-point rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##id/hp; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##id/ap { \
	name = "ammo box (" + str_name + " armor-piercing )"; \
	desc = "A box of " + #mag_size + " " + str_name + " armor-piercing rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##id/ap; \
}; \
/obj/item/ammo_magazine/ammo_box/box_ ##id/emp { \
	name = "ammo box (" + str_name + " haywire )"; \
	desc = "A box of " + #mag_size + " " + str_name + " haywire rounds"; \
	ammo_type = /obj/item/ammo_casing/case_ ##id/emp; \
};

/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

CREATE_MAGAZINE_VARIANTS(tenmm, "10mm", "10mm", TRUE, 20)
CREATE_MAGAZINE_EXTENDED(tenmm, "10mm", "10mm", TRUE, 30)
CREATE_MAGAZINE_DRUM(tenmm, "10mm", "ashot-mag", TRUE, 50)
CREATE_AMMOBOX_VARIANTS(tenmm, "10mm", "boxhrifle", TRUE, 50)

/////////////////////////////////////////////////////////////////////////////////////////
// NEXT AMMO
/////////////////////////////////////////////////////////////////////////////////////////



#undef CREATE_MAGAZINE_VARIANTS
#undef CREATE_MAGAZINE_EXTENDED
#undef CREATE_AMMOBOX_VARIANTS
