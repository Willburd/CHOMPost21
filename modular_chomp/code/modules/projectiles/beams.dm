//
// Energy Net alternate projectile
//
/obj/item/projectile/energy/energy_net
	name = "energy net projection"
	icon_state = "bola_energy"
	nodamage = 1
	agony = 5
	speed = 1.5
	damage_type = HALLOSS
	light_color = "#00CC33"
	hud_state = "flame_green"
	hud_state_empty = "flame_empty"
	var/net_type = /obj/item/energy_net

/obj/item/projectile/energy/energy_net/on_hit(atom/netted)
	do_net(netted)
	..()

/obj/item/projectile/energy/energy_net/proc/do_net(mob/M)
	var/obj/item/energy_net/net = new net_type(get_turf(M))
	net.throw_impact(M, throwing)

//
// Shrinking Energy Net alternate projectile
//
/obj/item/projectile/energy/energy_net/shrink
	name = "compactor energy net projection"
	hud_state = "flame_blue"
	hud_state_empty = "flame_empty"
	net_type = /obj/item/energy_net/shrink
