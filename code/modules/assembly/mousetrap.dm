/obj/item/assembly/mousetrap
	name = "mousetrap"
	desc = "A handy little spring-loaded trap for catching pesty rodents."
	icon_state = "mousetrap"
	origin_tech = list(TECH_COMBAT = 1)
	matter = list(MAT_STEEL = 100)
	var/armed = 0


/obj/item/assembly/mousetrap/examine(var/mob/user)
	. = ..(user)
	if(armed)
		. += "It looks like it's armed."

/obj/item/assembly/mousetrap/update_icon()
	if(armed)
		icon_state = "mousetraparmed"
	else
		icon_state = "mousetrap"
	if(holder)
		holder.update_icon()

/obj/item/assembly/mousetrap/proc/triggered(var/mob/target, var/type = "feet")
	if(!armed)
		return
	var/obj/item/organ/external/affecting = null
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		switch(type)
			if("feet")
				if(!H.shoes)
					affecting = H.get_organ(pick(BP_L_LEG, BP_R_LEG))
					H.Weaken(3)
			if(BP_L_HAND, BP_R_HAND)
				if(!H.gloves)
					affecting = H.get_organ(type)
					H.Stun(3)
		if(affecting)
			if(affecting.take_damage(1, 0))
				H.UpdateDamageIcon()
			H.updatehealth()
	else if(ismouse(target))
		var/mob/living/simple_mob/animal/passive/mouse/M = target
		visible_message(span_bolddanger("SPLAT!"))
		M.splat()
	// Outpost 21 edit begin - Jils get snapped too
	else if(istype(target,/mob/living/simple_mob/vore/alienanimals/jil))
		var/mob/living/simple_mob/vore/alienanimals/jil/J = target
		if(J.getMaxHealth() <= 5) // incase of jillioth
			visible_message("<font color='red'><b>SPLAT!</b></font>")
			J.splat()
	// Outpost 21 edit end
	playsound(target, 'sound/effects/snap.ogg', 50, 1)
	layer = MOB_LAYER - 0.2
	armed = 0
	update_icon()
	pulse(0)

/obj/item/assembly/mousetrap/attack_self(var/mob/living/user)
	if(!armed)
		to_chat(user, span_notice("You arm [src]."))
	else
		if((CLUMSY in user.mutations) && prob(20)) // Outpost 21 edit - Made clumsy less obnoxious
			var/which_hand = BP_L_HAND
			if(!user.hand)
				which_hand = BP_R_HAND
			triggered(user, which_hand)
			user.visible_message(span_warning("[user] accidentally sets off [src], breaking their fingers."), \
									span_warning("You accidentally trigger [src]!"))
			return

		to_chat(user, span_notice("You disarm [src]."))
	armed = !armed
	update_icon()
	playsound(user, 'sound/weapons/handcuffs.ogg', 30, 1, -3)

/obj/item/assembly/mousetrap/attack_hand(var/mob/living/user)
	if(armed)
		if((CLUMSY in user.mutations) && prob(20)) // Outpost 21 edit - Made clumsy less obnoxious
			var/which_hand = BP_L_HAND
			if(!user.hand)
				which_hand = BP_R_HAND
			triggered(user, which_hand)
			user.visible_message(span_warning("[user] accidentally sets off [src], breaking their fingers."), \
									span_warning("You accidentally trigger [src]!"))
			return
	..()

/obj/item/assembly/mousetrap/Crossed(var/atom/movable/AM)
	if(AM.is_incorporeal())
		return
	if(armed)
		if(ishuman(AM))
			var/mob/living/carbon/H = AM
			if(H.m_intent == I_RUN)
				triggered(H)
				H.visible_message(span_warning("[H] accidentally steps on [src]."), \
								  span_warning("You accidentally step on [src]"))
		if(ismouse(AM) || istype(AM,/mob/living/simple_mob/vore/alienanimals/jil)) // Outpost 21 edit begin - Jils get snapped too
			triggered(AM)
	..()

/obj/item/assembly/mousetrap/on_found(var/mob/living/finder)
	if(armed)
		finder.visible_message(span_warning("[finder] accidentally sets off [src], breaking their fingers."), \
							   span_warning("You accidentally trigger [src]!"))
		triggered(finder, finder.hand ? BP_L_HAND : BP_R_HAND)
		return 1	//end the search!
	return 0

/obj/item/assembly/mousetrap/hitby(var/atom/movable/A)
	if(!armed)
		return ..()
	visible_message(span_warning("[src] is triggered by [A]."))
	triggered(null)

/obj/item/assembly/mousetrap/armed
	icon_state = "mousetraparmed"
	armed = 1

/obj/item/assembly/mousetrap/verb/hide_under()
	set src in oview(1)
	set name = "Hide"
	set category = "Object"

	if(usr.stat)
		return

	layer = HIDING_LAYER
	to_chat(usr, span_notice("You hide [src]."))
