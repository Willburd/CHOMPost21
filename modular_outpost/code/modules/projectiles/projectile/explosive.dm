/obj/item/projectile/bullet/srmrocket
	name ="SRM-8 Rocket"
	desc = "Boom"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "missile"
	damage = 30	//Meaty whack. *Chuckles*
	does_spin = 0
	hud_state = "rocket_he"
	hud_state_empty = "rocket_empty"

#define EXPLOSION_EVENT explosion(target, 1, 2, 2, 3)
/obj/item/projectile/bullet/srmrocket/on_hit(atom/target, blocked=0)
	EXPLOSION_EVENT
	return 1

/obj/item/projectile/bullet/srmrocket/throw_impact(atom/target, var/speed)
	EXPLOSION_EVENT
	qdel(src)
#undef EXPLOSION_EVENT


/obj/item/projectile/bullet/srmrocket/weak	//Used in the jury rigged one.
	damage = 10
	hud_state = "rocket_he"

#define EXPLOSION_EVENT explosion(target, 1, 1, 2, 2)
/obj/item/projectile/bullet/srmrocket/weak/on_hit(atom/target, blocked=0)
	EXPLOSION_EVENT
	return 1

/obj/item/projectile/bullet/srmrocket/weak/throw_impact(atom/target, var/speed)
	EXPLOSION_EVENT
	qdel(src)
#undef EXPLOSION_EVENT
