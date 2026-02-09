/obj/item/gun/energy/flamegun
	name = "Flame Crystal Projector"
	desc = "A strange gun pulsing with energy, it's touch warming you up."
	icon = 'modular_chomp/icons/obj/guns/precursor/eclipse.dmi'
	icon_state = "flamegun"
	item_state = "flamegun"
	wielded_item_state = "flame-wielded"

	w_class = ITEMSIZE_LARGE

	accept_cell_type = /obj/item/cell/device
	cell_type = /obj/item/cell/device/weapon
	projectile_type = /obj/item/projectile/energy/flamecrystal

	matter = list(MAT_DURASTEEL = 1000, MAT_MORPHIUM = 500)
	origin_tech = list(TECH_COMBAT = 6, TECH_POWER = 5, TECH_PRECURSOR = 3)

	recoil_mode = 0
	charge_meter = 1

	move_delay = 0

	charge_cost = 80

	reload_time = 10

	firemodes = list(
		list(mode_name="normal", fire_delay=5, projectile_type=/obj/item/projectile/energy/flamecrystal, charge_cost = 80),
		list(mode_name="shotgun", fire_delay=15, projectile_type=/obj/item/projectile/bullet/flamegun, charge_cost = 240),
		list(mode_name="explosive", fire_delay=10, projectile_type=/obj/item/projectile/energy/fireball, charge_cost = 160),
		)


/obj/item/projectile/energy/flamecrystal
	name = "Flame Crystal"
	icon = 'modular_chomp/icons/mob/eclipse.dmi' //commiting sin
	icon_state = "firecrystal"
	damage = 15
	armor_penetration = 40 //Large pointy crystal
	damage_type = BRUTE
	check_armour = "bullet"
	range = 12
	hud_state = "laser_sniper"

/obj/item/projectile/energy/flamecrystal/on_hit(atom/target, blocked = 0, def_zone)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_fire_stacks(5)
		L.ignite_mob()

/obj/item/projectile/bullet/flamegun
	use_submunitions = 1
	only_submunitions = 1
	range = 0
	embed_chance = 0
	submunition_spread_max = 800
	submunition_spread_min = 200
	submunitions = list(/obj/item/projectile/energy/flamecrystal = 3)
	hud_state = "laser_heat"

/obj/item/projectile/bullet/flamegun/on_range()
	qdel(src)
