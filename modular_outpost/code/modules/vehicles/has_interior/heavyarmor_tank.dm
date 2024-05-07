/obj/vehicle/has_interior/controller/heavyarmor_tank
	name = "K72-4"
	desc = "Kylos model 72 varient 4, heavy asset reclaimation vehicle. For when lesser force has failed."
	move_delay = 4

	key_type = /obj/item/weapon/key/heavyarmor_tank

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "sec_tank"

	health = 2500
	maxhealth = 2500
	fire_dam_coeff = 0.5
	brute_dam_coeff = 0.4
	breakwalls = TRUE

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/mainturret)
	// list of weapons, with a sublist containing directions, with a subsub list of x and ys
	weapons_draw_offset = list(list("1" = list(-96,-96),"2" = list(-96,-96),"4" = list(-96,-96),"8" = list(-96,-96)) )


/obj/item/weapon/key/heavyarmor_tank
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Greater force\"."
	icon = 'icons/obj/vehicles_op.dmi'
	icon_state = "sec_tank"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/mainturret
	name = "\improper TD Type-L Accelerator"
	desc = "Tandem Logistics Linear-Type Heavy-Ordinance Magnetic Accelerator."

	icon = 'icons/obj/vehicles_224x224.dmi'
	icon_state = "tank_turret"

	// graphics offset of lorge boi
	old_x = -64
	old_y = -64
	pixel_x = -64
	pixel_y = -64

	projectile = /obj/item/projectile/bullet/kyshell
	fire_sound = 'sound/weapons/railgun.ogg'
	projectiles = 1
	projectiles_per_shot = 1
	deviation = 0.1
	fire_cooldown = 6

	freeaim = FALSE


// basically just meaner /obj/item/projectile/bullet/srmrocket
/obj/item/projectile/bullet/kyshell
	name ="TD Type-L \"Reclaimer\" Shell"
	desc = "Boom"
	icon = 'icons/obj/grenade_op.dmi'
	icon_state = "shell"
	damage = 35 // Bonk
	range = 90
	sharp = FALSE
	nondirectional_sprite = TRUE
	hud_state = "rocket_he"
	hud_state_empty = "rocket_empty"

/obj/item/projectile/bullet/kyshell/on_hit(atom/target, blocked=0)
	explosion(target, 1, 2, 2, 4)
	return 1

/obj/item/projectile/bullet/kyshell/throw_impact(atom/target, var/speed)
	explosion(target, 1, 2, 2, 4)
	qdel(src)

/obj/item/projectile/bullet/kyshell/on_range()
	. = ..()
	explosion(loc, 1, 2, 2, 4)

/obj/item/projectile/bullet/kyshell/on_impact(atom/A)
	. = ..()
	explosion(loc, 1, 2, 2, 4)

/obj/item/ammo_casing/kyshell
	name = "TD Type-L \"Reclaimer\" Shell"
	desc = "High explosive shell."
	icon_state = "rocketshell"
	projectile_type = /obj/item/projectile/bullet/kyshell
	caliber = "rocket"
	matter = list(MAT_STEEL = 10000)
