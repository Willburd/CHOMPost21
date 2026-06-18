///BASELINE BALLISTIC FOLDER///

/obj/item/gun/projectile/pistol
	name = "debug handgun"
	desc = "You probably shouldn't be seeing this!"
	description_fluff = "Fluff? On a gun? What is this, cursed gun videos?"
	icon = "modular_alpha_gattening/icons/obj/guns_x32.dmi"
	icon_state = "debug"
	magazine_type = /obj/item/ammo_magazine
	allowed_magazines = list(/obj/item/ammo_magazine)
	projectile_type = /obj/item/projectile/bullet
	load_method = MAGAZINE
	w_class = ITEMSIZE_NORMAL
	caliber = "10mm"
