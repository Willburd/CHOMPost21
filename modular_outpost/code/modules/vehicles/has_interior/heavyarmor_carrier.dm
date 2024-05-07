/obj/vehicle/has_interior/controller/heavyarmor_carrier
	name = "armored personal carrier"
	move_delay = 2

	key_type = /obj/item/weapon/key/heavyarmor_carrier

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "sec_apc"

	health = 800
	maxhealth = 800
	fire_dam_coeff = 0.5
	brute_dam_coeff = 0.4
	breakwalls = FALSE

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/lmg)
	weapons_draw_offset = list(list("1" = list(20,20),"2" = list(-20,10),"4" = list(12,20),"8" = list(-12,34)) )


/obj/item/weapon/key/heavyarmor_carrier
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Band wagon\"."
	icon = 'icons/obj/vehicles_op.dmi'
	icon_state = "sec_apc"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A massive shotgun designed to fill a large area with pellets."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pellet/shotgun/flak
	fire_sound = 'sound/weapons/Gunshot_shotgun.ogg'
	fire_volume = 80
	projectiles = 40
	projectiles_per_shot = 4
	deviation = 0.7

/obj/item/vehicle_interior_weapon/lmg
	name = "\improper Ultra AC 2"
	desc = "A superior version of the standard Solgov Autocannon MK2 design."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pistol/medium
	fire_sound = 'sound/weapons/Gunshot_machinegun.ogg'
	projectiles = 30 //10 bursts, matching the Scattershot's 10. Also, conveniently, doesn't eat your powercell when reloading like 300 bullets does.
	projectiles_per_shot = 3
	deviation = 0.3
	fire_cooldown = 2
