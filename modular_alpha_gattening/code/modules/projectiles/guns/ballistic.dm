///BASELINE BALLISTIC FOLDER///

/obj/item/gun/projectile/pistol
	name = "debug handgun"
	desc = "You probably shouldn't be seeing this!"
	description_fluff = "Fluff? On a gun? What is this, cursed gun videos?"
	w_class = ITEMSIZE_NORMAL
	icon = 'modular_alpha_gattening/icons/obj/guns_x32.dmi'
	icon_state = "debug"

	caliber = ""
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine
	allowed_magazines = list(/obj/item/ammo_magazine)
	projectile_type = /obj/item/projectile/bullet

/obj/item/gun/projectile/pistol/tenmil_test
	name = "debug handgun 10mm"

	caliber = CALIBER_TYPE_10MM
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mag_testtenmil
	allowed_magazines = list(/obj/item/ammo_magazine/mag_testtenmil)
