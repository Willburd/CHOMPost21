
/*
 * Bladetrap.
 * Cuts off legs if standing, otherwise massive brute edge damage
 * Sprites by Whooshboom
 */

/obj/structure/blade_trap
	name = "blade trap"
	gender = PLURAL
	icon = 'modular_outpost/icons/obj/bladetrap.dmi'
	icon_state = "bladetrap_1"
	desc = "A mechanically activated blade trap. A single swing of this blade could cut bones made of steel."
	anchored = TRUE
	var/raw_damage = 35
	var/sprung = TRUE

/obj/structure/blade_trap/start_active
	icon_state = "bladetrap_0"
	sprung = FALSE

/obj/structure/blade_trap/attack_hand(mob/user)
	if(!sprung)
		user.visible_message(
			span_danger("[user] starts to disarm \the [src]."),
			span_notice("You begin disarming \the [src]!"),
			"You hear a latch click followed by the slow creaking of a spring."
			)
		playsound(src, 'sound/machines/click.ogg', 50, 1)

		if(do_after(user, 12 SECONDS, target = src))
			user.visible_message(
				span_danger("[user] has disarmed \the [src]."),
				span_notice("You have disarmed \the [src]!")
				)
			sprung = TRUE
			update_icon()
		else
			// Slice off active hand
			trigger( user, TRUE)
	else
		user.visible_message(
			span_danger("[user] starts to reset \the [src]."),
			span_notice("You begin resetting \the [src]!"),
			"You hear a latch click followed by the slow creaking of a spring."
			)

		if(do_after(user, 9 SECONDS, target = src))
			playsound(src, 'sound/machines/click.ogg', 50, 1)
			sprung = TRUE
			update_icon()

/obj/structure/blade_trap/proc/trigger(mob/living/target, is_hand)
	SSmotiontracker.ping(src,100) // Clunk!
	log_and_message_admins("has sprung a [name] at \the [get_area(loc)], last touched by [forensic_data?.get_lastprint()]", target)
	playsound(src, 'sound/machines/click.ogg', 50, 1)
	playsound(src, 'sound/items/drop/knife.ogg', 80, 1)

	visible_message(
		span_danger("[target] triggers \the [src]."),
		span_danger("You trigger \the [src]!"),
		span_infoplain(span_bold("You hear a loud metallic clunk!"))
		)

	// Get the mobs
	// Slay the mobs
	var/turf/T = get_turf(src)
	if(!T)
		return
	for(var/mob/living/sliced in (T.contents | target))
		var/always_cut = TRUE
		var/target_limb = pick(list(BP_L_LEG, BP_R_LEG)) // GET EM BY THE LEGS
		if(is_hand)
			// Don't mess this up
			target_limb = pick(list(BP_R_HAND, BP_L_HAND))
		else if(target.resting || target.lying)
			// THUNK
			target_limb = pick(list(BP_HEAD, BP_TORSO, BP_GROIN))
			always_cut = FALSE
			if(target_limb == BP_HEAD)
				always_cut = prob(10)

		// Add dna before damage, incase of gibbing
		var/hp_before = target.health
		if(ishuman(target) || isanimal(target))
			add_blooddna(target.dna,target)
		target.apply_damage( raw_damage * (is_hand ? 0.75 : 1), BRUTE, def_zone = target_limb, sharp = TRUE, edge = TRUE, used_weapon = src)
		target.Stun(10)
		target.Weaken(8)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(H.species)
				blood_color = H.species.blood_color
			if(always_cut)
				var/obj/item/organ/external/E = H.get_organ(check_zone(target_limb))
				if(E && !E.cannot_amputate && CONFIG_GET(flag/limbs_can_break))
					E.droplimb(TRUE, DROPLIMB_EDGE)
	sprung = TRUE
	update_icon()

/obj/structure/blade_trap/Crossed(atom/movable/AM)
	if(AM.is_incorporeal())
		return
	if(!sprung && isliving(AM))
		var/mob/living/L = AM
		if(L.mob_size > MOB_TINY && L.m_intent == I_RUN)
			trigger(L, FALSE)
	..()

/obj/structure/blade_trap/update_icon()
	cut_overlays()
	icon_state = "bladetrap_[sprung]"
	if(length(forensic_data?.has_blooddna()))
		var/image/bloody = image(icon, "[icon_state]b")
		bloody.color = blood_color ? blood_color : COLOR_BLOOD_HUMAN
		add_overlay(bloody)
