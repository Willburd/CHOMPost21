/obj/item/orb_that_kills_old_people
	name = "orb that kills old people"
	desc = "dated shut up boomer meme here"
	icon = 'modular_shitpost/icons/obj/orb.dmi'
	icon_state = "orb"
	item_icons = list(
		slot_l_hand_str = 'modular_shitpost/icons/mob/items/orb_left.dmi',
		slot_r_hand_str = 'modular_shitpost/icons/mob/items/orb_right.dmi'
	)

	throwforce = 5 //it still hurts even if you're not old

	// For the 'bus
	var/too_old = 60
	var/bell_tolls_remaining = 1

/obj/item/orb_that_kills_old_people/proc/r_u_old(mob/living/zoomer)
	if(!ishuman(zoomer))
		return FALSE
	var/mob/living/carbon/human/boomer = zoomer
	if(boomer.age >= too_old)
		playsound(src, 'sound/effects/lightningbolt.ogg') //was going to use supermatter, but lightning sounds funnier in my head
		boomer.dust()
		bell_tolls_remaining--
		if(bell_tolls_remaining >= 0)
			playsound(src, 'sound/effects/Glassbr2.ogg')
			visible_message("\The [src] suddenly shudders, before cracking, and imploding on itself, leaving nothing behind.")
			QDEL(src)	//Our job is complete.
		return TRUE
	return FALSE

/obj/item/orb_that_kills_old_people/equipped(mob/living/user, slot_equipped) //Generally i'd expect it to get caught by attack_hand(), but just incase it ends up in someone's hands through other means (someone putting it in their hands?), this should handle it.
	. = ..()
	if(r_u_old(user))
		user.visible_message("[user] suddenly flashes into a pile of ash and bones as [user.they()] attempt to hold \the [src]!")

/obj/item/orb_that_kills_old_people/attack_hand(mob/living/user)
	if(r_u_old(mob))
		user.visible_message("[user] tries to pick up \the [src], but as soon as [user.they()] touch it, [user.they()] instantaneously flash into a pile of ash and bones!")
		return
	return ..()

/obj/item/orb_that_kills_old_people/apply_hit_effect(mob/living/target, mob/living/user, hit_zone, attack_modifier)
	if(r_u_old(target))
		user.visible_message("[user] strikes [target] with \the [src], and [target.they()] instantaneously flash into a pile of ash and bones!")
		return
	. = ..()

/obj/item/orb_that_kills_old_people/throw_impact(atom/hit_atom)
	. = ..()
	if(r_u_old(hit_atom))
		visible_message("[src] hits [hit_atom], and [hit_atom.they()] instantaneously flash into a pile of ash and bones!")

/obj/item/orb_that_kills_old_people/Crossed(mob/living/M)
	. = ..()
	if(r_u_old(M))
		visible_message("[M] steps on \the [src] and [M.they()] instantaneously flashes into a pile of ash and bones!")
