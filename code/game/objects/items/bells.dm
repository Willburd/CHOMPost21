/obj/item/deskbell
	name = "desk bell"
	desc = "An annoying bell. Ring for service."
	icon = 'icons/obj/items.dmi'
	icon_state = "deskbell"
	force = 2
	throwforce = 2
	w_class = 2.0
	matter = list(MAT_STEEL = 50)
	var/broken
	attack_verb = list("annoyed")
	/* Outpost 21 edit begin - Remove radial menu
	var/static/radial_examine = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_examine")
	var/static/radial_use = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_use")
	var/static/radial_pickup = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_pickup")
	*/

/obj/item/deskbell/examine(mob/user)
	. = ..()
	if(broken)
		. += span_bold("It looks damaged, the ringer is stuck firmly inside.")

/obj/item/deskbell/attack_ai(mob/user)
	return

/obj/item/deskbell/attack_self(mob/user)
	if(!broken)
		ring(user)
		add_fingerprint(user)
	..()

/obj/item/deskbell/attack(mob/target as mob, mob/living/user as mob)
	if(!broken)
		ring(user)
		add_fingerprint(user)
	..()

/obj/item/deskbell/attack_hand(mob/user)
	// Outpost 21 edit begin - Remove radial menu
	if(!isturf(loc) || anchored)
		if(!broken && check_ability(user))
			ring(user)
			add_fingerprint(user)
	else
		return ..()
	/*
	//This defines the radials and what call we're assiging to them.
	var/list/options = list()
	options["examine"] = radial_examine
	options["pick up"] = radial_pickup
	if(!broken)
		options["use"] = radial_use


	// Just an example, if the bell had no options, due to conditionals, nothing would happen here.
	if(length(options) < 1)
		return

	// Right, if there's only one available radial...
	// For example, say, the bell's broken so you can only examine, it just does that (doesn't show radial)..
	var/list/choice = list()
	if(length(options) == 1)
		for(var/key in options)
			choice = key
	else
	// If we have other options, it will show the radial menu for the player to decide.
		choice = show_radial_menu(user, src, options, require_near = !issilicon(user))

	// Once the player has decided their option, choose the behaviour that will happen under said option.
	switch(choice)
		if("examine")
			user.examinate(src)

		if("use")
			if(check_ability(user))
				ring(user)
				add_fingerprint(user)

		if("pick up")
			..()
	*/
	// Outpost 21 edit end

/obj/item/deskbell/proc/ring(mob/user)
	if(user.a_intent == I_HURT)
		playsound(src, 'sound/effects/deskbell_rude.ogg', 50, 1)
		to_chat(user,span_notice("You hammer [src] rudely!"))
		if (prob(2))
			break_bell(user)
	else
		playsound(src, 'sound/effects/deskbell.ogg', 50, 1)
		to_chat(user,span_notice("You gracefully ring [src]."))

/obj/item/deskbell/proc/check_ability(mob/user)
	if (ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/external/temp = H.organs_by_name[BP_R_HAND]
		if (H.hand)
			temp = H.organs_by_name[BP_L_HAND]
		if(temp && !temp.is_usable())
			to_chat(H,span_notice("You try to move your [temp.name], but cannot!"))
			return 0
		return 1
	else
		to_chat(user,span_notice("You are not able to ring [src]."))
	return 0

/obj/item/deskbell/attackby(obj/item/W, mob/user, params)
	if(!istype(W))
		return
	// Outpost 21 edit begin - Remove radial menu, and actually disassembling this back to metal sheets
	if(isturf(loc))
		if(W.has_tool_quality(TOOL_WRENCH) && isturf(loc))
			anchored = !anchored
			playsound(src, W.usesound, 50, 1)
			to_chat(user, span_notice("You [anchored ? "secure" : "unsecure"] \the [src]."))
		else if(W.has_tool_quality(TOOL_SCREWDRIVER) && isturf(loc))
			if(do_after(5))
				if(!src) return
				to_chat(user, span_notice("You dissasemble the desk bell"))
				new /obj/item/stack/material/steel(get_turf(src), 1)
				qdel(src)
				return
		else if(!broken)
			ring(user)
	// Outpost 21 edit end

/obj/item/deskbell/proc/break_bell(mob/user)
	to_chat(user,span_notice("The ringing abruptly stops as [src]'s ringer gets jammed inside!"))
	broken = 1
