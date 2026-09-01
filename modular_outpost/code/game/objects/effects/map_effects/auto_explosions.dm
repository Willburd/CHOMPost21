/obj/effect/map_effect/event_explosions
	anchored = TRUE
	invisibility = INVISIBILITY_BADMIN // So a badmin can go view these by changing their see_invisible.
	icon_state = "permalight"
	var/light_blast = 1
	var/heavy_blast = 1
	var/dev_blast = 1

///////////////////////////////////////////////////////////////////////////
// Auto explosion
///////////////////////////////////////////////////////////////////////////
/obj/effect/map_effect/event_explosions/start_explosion
	name = "Start explosion"
	desc = "Will explode shortly after spawning"

/obj/effect/map_effect/event_explosions/start_explosion/small
	name = "Start explosion small"
	light_blast = 3
	heavy_blast = 2
	dev_blast = 1

/obj/effect/map_effect/event_explosions/start_explosion/medium
	name = "Start explosion medium"
	light_blast = 5
	heavy_blast = 3
	dev_blast = 2

/obj/effect/map_effect/event_explosions/start_explosion/big
	name = "Start explosion big"
	light_blast = 8
	heavy_blast = 5
	dev_blast = 3

/obj/effect/map_effect/event_explosions/start_explosion/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(handle_explode)), 1 SECOND, TIMER_DELETE_ME)

/obj/effect/map_effect/event_explosions/start_explosion/proc/handle_explode()
	explosion(get_turf(src), dev_blast, heavy_blast, light_blast, light_blast)
	qdel(src)


///////////////////////////////////////////////////////////////////////////
// Chain-reaction explosions
///////////////////////////////////////////////////////////////////////////
/obj/effect/map_effect/event_explosions/chain_reaction
	name = "chain reaction explosion"
	desc = "Will explode shortly after spawning"

/obj/effect/map_effect/event_explosions/chain_reaction/small
	name = "chain reaction explosion small"
	light_blast = 3
	heavy_blast = 2
	dev_blast = 1

/obj/effect/map_effect/event_explosions/chain_reaction/medium
	name = "chain reaction explosion medium"
	light_blast = 5
	heavy_blast = 3
	dev_blast = 2

/obj/effect/map_effect/event_explosions/chain_reaction/big
	name = "chain reaction explosion big"
	light_blast = 8
	heavy_blast = 5
	dev_blast = 3

/obj/effect/map_effect/event_explosions/chain_reaction/ex_act()
	explosion(get_turf(src), dev_blast, heavy_blast, light_blast, light_blast)
	qdel(src)
