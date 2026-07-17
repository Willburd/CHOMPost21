// stolen from holodeck
/obj/structure/fitness/basketballhoop
	name = "basketball hoop"
	desc = "Boom, Shakalaka!"
	icon = 'icons/obj/32x64.dmi'
	icon_state = "hoop"
	anchored = TRUE
	density = FALSE // Don't block players
	unacidable = TRUE
	throwpass = 1

/obj/structure/fitness/basketballhoop/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/grab) && get_dist(src,user)<2)
		var/obj/item/grab/G = W
		if(G.state<2)
			to_chat(user, span_warning("You need a better grip to do that!"))
			return
		G.affecting.loc = src.loc
		G.affecting.Weaken(5)
		visible_message(span_warning("[G.assailant] dunks [G.affecting] into the [src]!"), 3)
		qdel(W)
		return
	else if (istype(W, /obj/item) && get_dist(src,user)<2)
		user.drop_item(src.loc)
		visible_message(span_notice("[user] dunks [W] into the [src]!"), 3)
		return

/obj/structure/fitness/basketballhoop/CanPass(atom/movable/mover, turf/target)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/item/projectile))
			return TRUE
		if(prob(50))
			I.forceMove(loc)
			visible_message(span_notice( "Swish! \the [I] lands in \the [src]."), 3)
		else
			visible_message(span_warning( "\The [I] bounces off of \the [src]'s rim!"), 3)
		return FALSE
	return ..()
