/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

/obj/item/projectile/bullet/proj_10mm
	fire_sound = 'sound/weapons/gunshot2.ogg'
	hud_state = "pistol"
	damage = 20
	matter = list(MAT_STEEL = PER_BULLET_MATERIAL_COST)

/obj/item/projectile/bullet/proj_10mm/practice
	damage = 5
	hud_state = "smg_light"

/obj/item/projectile/bullet/proj_10mm/rubber
	armor_penetration = -10
	damage = 10
	agony = 50
	embed_chance = 0
	sharp = FALSE
	check_armour = "melee"

/obj/item/projectile/bullet/proj_10mm/ap
	armor_penetration = 15
	hud_state = "pistol_ap"

/obj/item/projectile/bullet/proj_10mm/hp
	armor_penetration = -10
	hud_state = "pistol_hollow"
