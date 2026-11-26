/obj/structure/trench
	name = "trench"
	desc = "Deep dirt. Almost philosophical really."
	icon = 'modular_outpost/icons/obj/trench.dmi'
	icon_state = "hole"
	anchored = TRUE

/obj/structure/trench/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/trench/Destroy()
	for(var/check in GLOB.cardinal)
		var/turf/B = get_step(src, check)
		if(!B)
			continue
		var/obj/structure/trench/check_trench = locate() in B
		if(!check_trench)
			continue
		check_trench.link_trenches(TRUE)
	. = ..()

/obj/structure/trench/update_icon()
	link_trenches(FALSE)

/obj/structure/trench/proc/link_trenches(is_from_other)
	cut_overlays()
	for(var/check in GLOB.cardinal)
		var/turf/B = get_step(src, check)
		if(!B)
			continue
		var/obj/structure/trench/check_trench = locate() in B
		if(QDELETED(check_trench))
			continue
		var/image/im = image(icon, "[icon_state]-o", dir = check)
		add_overlay(im)
		if(!is_from_other) // Only update the ones around us, instead of creating recursive hell
			check_trench.link_trenches(TRUE)


/obj/structure/trench/attack_hand(mob/user as mob)
	visible_message(span_notice("[user] starts to climb into \the [src.name]."), \
					span_notice("You start to lower yourself into \the [src.name]."))
	if(do_after(user, 5 SECONDS, target = src))
		user.forceMove(src.loc)
		visible_message(span_notice("[user] climbs into \the [src.name]."), \
						span_notice("You climb into \the [src.name]."))
	else
		visible_message(span_notice("[user] decides not to climb into \the [src.name]."), \
						span_notice("You stop climbing into \the [src.name]."))

/obj/structure/trench/CanPass(atom/movable/mover, turf/target)
	if(ismob(mover))
		var/mob/M = mover
		add_fingerprint(M)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.m_intent == I_WALK)
				to_chat(H, span_warning("You stop at the edge of \the [src.name]."))
				return FALSE
			else
				to_chat(H, span_warning("You fall into \the [src.name]!"))
				fall_in(H)
				return TRUE
		if(isrobot(M))
			var/mob/living/silicon/robot/R = M
			if(R.a_intent == I_HELP)
				to_chat(R, span_warning("You stop at the edge of \the [src.name]."))
				return FALSE
			else
				to_chat(R, span_warning("You enter \the [src.name]."))
				return TRUE
	return TRUE	//Everything else can move over the trench

/obj/structure/trench/proc/fall_in(mob/living/L)	//Only called on humans for now, but still
	L.Weaken(5)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/limb_damage = rand(5,25)
		H.adjustBruteLoss(limb_damage)

/obj/structure/trench/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/shovel))
		user.visible_message(span_notice("[user] piles dirt into \the [src.name]."), \
								span_notice("You start to pile dirt into \the [src.name]."), \
								span_notice("You hear dirt being moved."))
		if(do_after(user, 4 SECONDS * W.toolspeed, target = src))
			user.visible_message(span_notice("[user] pats down the dirt on top of \the [src.name]."), \
								span_notice("You finish filling in \the [src.name]."))
			qdel(src)
			return
		else
			user.visible_message(span_notice("[user] stops filling in \the [src.name]."), \
								span_notice("You change your mind and stop filling in \the [src.name]."))
			return
	. = ..()

/obj/structure/trench/bullet_act(obj/item/projectile/P)
	return PROJECTILE_CONTINUE	// It's a hole in the ground, doesn't usually stop or even care about bullets
