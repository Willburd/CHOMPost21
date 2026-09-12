#define CREATE_PROJECTILE_BASE(id) /obj/item/projectile/bullet/proj_ ##id
#define CREATE_PROJECTILE_PRACTICE(id) /obj/item/projectile/bullet/proj_ ##id/practice
#define CREATE_PROJECTILE_RUBBER(id) /obj/item/projectile/bullet/proj_ ##id/rubber
#define CREATE_PROJECTILE_ARMORPIERCING(id) /obj/item/projectile/bullet/proj_ ##id/ap
#define CREATE_PROJECTILE_HOLLOWPOINT(id) /obj/item/projectile/bullet/proj_ ##id/hp

/////////////////////////////////////////////////////////////////////////////////////////
// 10mm
/////////////////////////////////////////////////////////////////////////////////////////

CREATE_PROJECTILE_BASE(tenmm)
	damage = BULLET_DAMAGE_MODERATE
	BULLET_DEFINE_HUD("pistol")
	fire_sound = 'sound/weapons/gunshot2.ogg'
	BULLET_DEFINE_STANDARD_MATERIALS

CREATE_PROJECTILE_PRACTICE(tenmm)
	damage = BULLET_DAMAGE_LOW
	BULLET_DEFINE_HUD("smg_light")
	BULLET_DEFINE_BLUNT

CREATE_PROJECTILE_RUBBER(tenmm)
	armor_penetration = BULLET_PENETRATION_POOR
	damage = BULLET_DAMAGE_MILD
	agony = BULLET_DAMAGE_HIGH
	check_armour = "melee"
	BULLET_DEFINE_BLUNT

CREATE_PROJECTILE_ARMORPIERCING(tenmm)
	armor_penetration = BULLET_PENETRATION_GREAT
	BULLET_DEFINE_HUD("pistol_ap")

CREATE_PROJECTILE_HOLLOWPOINT(tenmm)
	armor_penetration = BULLET_PENETRATION_POOR
	BULLET_DEFINE_HUD("pistol_hollow")

/////////////////////////////////////////////////////////////////////////////////////////
// next size
/////////////////////////////////////////////////////////////////////////////////////////









#undef CREATE_PROJECTILE_BASE
#undef CREATE_PROJECTILE_PRACTICE
#undef CREATE_PROJECTILE_RUBBER
#undef CREATE_PROJECTILE_ARMORPIERCING
#undef CREATE_PROJECTILE_HOLLOWPOINT
