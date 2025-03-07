/obj/item/arrow/standard
	name = "arrow"
	desc = "It's got a tip for you - get the point?"
	icon = 'icons/obj/guns/projectile/bows.dmi'
	icon_state = "arrow"
	item_state = "bolt"
	throwforce = 8
	w_class = ITEMSIZE_NORMAL
	sharp = TRUE
	edge = FALSE

/obj/item/arrow/energy
	name = "hardlight arrow"
	desc = "An arrow made out of energy! Classic?"
	icon = 'icons/obj/guns/projectile/bows.dmi'
	icon_state = "hardlight"
	item_state = "bolt"
	throwforce = 10
	w_class = ITEMSIZE_NORMAL
	sharp = TRUE
	edge = TRUE
	embed_chance = 0 // it fizzles!
	catchable = FALSE // oh god

/obj/item/arrow/energy/throw_impact(atom/hit_atom)
	. = ..()
	qdel(src)

/obj/item/arrow/energy/equipped()
	if(isliving(loc))
		var/mob/living/L = loc
		L.drop_from_inventory(src)
	qdel(src) // noh

/obj/item/gun/launcher/crossbow/bow
	name = "shortbow"
	desc = "A common shortbow, capable of firing arrows at high speed towards a target. Useful for hunting while keeping quiet."
	icon = 'icons/obj/guns/projectile/bows.dmi'
	icon_override = 'icons/obj/guns/projectile/bows.dmi'
	icon_state = "bow"
	item_state = "bow"
	fire_sound = 'sound/weapons/punchmiss.ogg' // TODO: Decent THWOK noise.
	fire_sound_text = "a solid thunk"
	fire_delay = 25
	slot_flags = SLOT_BACK
	release_force = 20
	release_speed = 15
	var/drawn = FALSE

/obj/item/gun/launcher/crossbow/bow/update_release_force(obj/item/projectile)
	return 0

/obj/item/gun/launcher/crossbow/bow/proc/unload(mob/user)
	var/obj/item/arrow/A = bolt
	bolt = null
	drawn = FALSE
	A.forceMove(get_turf(user))
	user.put_in_hands(A)
	update_icon()

/obj/item/gun/launcher/crossbow/bow/consume_next_projectile(mob/user)
	if(!drawn)
		to_chat(user, span_warning("\The [src] is not drawn back!"))
		return null
	return bolt

/obj/item/gun/launcher/crossbow/bow/handle_post_fire(mob/user, atom/target)
	bolt = null
	drawn = FALSE
	update_icon()
	..()

/obj/item/gun/launcher/crossbow/bow/attack_hand(mob/living/user)
	if(loc == user && bolt && !drawn)
		user.visible_message(span_infoplain(span_bold("[user]") + " removes [bolt] from [src]."),span_infoplain("You remove [bolt] from [src]."))
		unload(user)
	else
		return ..()

/obj/item/gun/launcher/crossbow/bow/attack_self(mob/living/user)
	if(drawn)
		user.visible_message(span_infoplain(span_bold("[user]") + " relaxes the tension on [src]'s string."),span_infoplain("You relax the tension on [src]'s string."))
		drawn = FALSE
		update_icon()
	else
		draw(user)

/obj/item/gun/launcher/crossbow/bow/draw(var/mob/user)
	if(!bolt)
		to_chat(user, span_infoplain("You don't have anything nocked to [src]."))
		return

	if(user.restrained())
		return

	current_user = user
	user.visible_message(span_infoplain(span_bold("[user]") + " begins to draw back the string of [src]."),span_notice("You begin to draw back the string of [src]."))
	if(do_after(user, 25, src, exclusive = TASK_ALL_EXCLUSIVE))
		drawn = TRUE
		user.visible_message(span_infoplain(span_bold("[user]") + "draws the string on [src] back fully!"), span_infoplain("You draw the string on [src] back fully!"))
	update_icon()

/obj/item/gun/launcher/crossbow/bow/attackby(obj/item/W as obj, mob/user)
	if(!bolt && istype(W,/obj/item/arrow/standard))
		user.drop_from_inventory(W, src)
		bolt = W
		user.visible_message(span_infoplain("[user] slides [bolt] into [src]."),span_infoplain("You slide [bolt] into [src]."))
		update_icon()

/obj/item/gun/launcher/crossbow/bow/update_icon()
	if(drawn)
		icon_state = "[initial(icon_state)]_firing"
	else if(bolt)
		icon_state = "[initial(icon_state)]_loaded"
	else
		icon_state = "[initial(icon_state)]"



/obj/item/gun/launcher/crossbow/bow/hardlight
	name = "hardlight bow"
	icon_state = "bow_hardlight"
	item_state = "bow_hardlight"
	desc = "An energy bow, capable of producing arrows from an internal power supply."

/obj/item/gun/launcher/crossbow/bow/hardlight/unload(mob/user)
	qdel_null(bolt)
	update_icon()

/obj/item/gun/launcher/crossbow/bow/hardlight/attack_self(mob/living/user)
	if(drawn)
		user.visible_message(span_infoplain(span_bold("[user]") + " relaxes the tension on [src]'s string."),span_infoplain("You relax the tension on [src]'s string."))
		drawn = FALSE
		update_icon()
	else if(!bolt)
		user.visible_message(span_infoplain(span_bold("[user]") + " fabricates a new hardlight projectile with [src]."),span_infoplain("You fabricate a new hardlight projectile with [src]."))
		bolt = new /obj/item/arrow/energy(src)
		update_icon()
	else
		draw(user)

/obj/item/gun/launcher/crossbow/bow/glamour
	name = "glamour bow"
	desc = "A glamour bow, capable of firing arrows at high speed towards a target. Useful for hunting while keeping quiet."
	icon = 'icons/obj/guns/projectile/bows.dmi'
	icon_override = 'icons/obj/guns/projectile/bows.dmi'
	icon_state = "gbow"
	item_state = "gbow"

/obj/item/arrow/standard/glamour
	name = "glamour arrow"
	icon = 'icons/obj/guns/projectile/bows.dmi'
	icon_state = "garrow"
	edge = TRUE
