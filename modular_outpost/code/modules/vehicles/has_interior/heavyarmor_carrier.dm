/obj/vehicle/has_interior/controller/heavyarmor_carrier
	name = "armored personal carrier"
	move_delay = 2

	key_type = /obj/item/key/heavyarmor_carrier

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "sec_apc"
	base_icon = "sec_apc"

	health = 900
	maxhealth = 900
	fire_dam_coeff = 0.5
	brute_dam_coeff = 0.4
	breakwalls = FALSE

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/lmg)
	weapons_draw_offset = list(list("1" = list(20,20),"2" = list(-20,10),"4" = list(12,20),"8" = list(-12,34)) )


/obj/item/key/heavyarmor_carrier
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Band wagon\"."
	icon = 'modular_outpost/icons/obj/vehicles.dmi'
	icon_state = "sec_apc"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A massive shotgun designed to fill a large area with pellets."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"
	base_icon = "pointdefense2"

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
	base_icon = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pistol/medium
	fire_sound = 'sound/weapons/Gunshot_machinegun.ogg'
	projectiles = 30 //10 bursts, matching the Scattershot's 10. Also, conveniently, doesn't eat your powercell when reloading like 300 bullets does.
	projectiles_per_shot = 3
	deviation = 0.3
	fire_cooldown = 2

/obj/item/vehicle_interior_weapon/pacify
	name = "\improper MK-IV 'Crowd Pleaser' fire control"
	desc = "A modified version of the L6 SAW, chambered in rubber rounds only. Fun for the whole family!"

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pistol/rubber/strong
	fire_sound = 'sound/weapons/gunshot3.ogg'
	projectiles = 100 //Lots of rounds
	projectiles_per_shot = 3
	deviation = 0.2
	fire_cooldown = 3

/obj/item/vehicle_interior_weapon/hmg
	name = "\improper Mounted Kord 6P50"
	desc = "An appropriately mounted Kord 6P50, guaranteed to supress whatever the hell you're pointing at."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/rifle/a127x108
	fire_sound = 'sound/weapons/serdy/strela.ogg'
	projectiles = 50 //10 bursts, matching the Scattershot's 10. Also, conveniently, doesn't eat your powercell when reloading like 300 bullets does.
	projectiles_per_shot = 5
	deviation = 0.2
	fire_cooldown = 3
