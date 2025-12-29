/obj/structure/hookah
	name = "hookah"
	desc = "A method of smoking substances with the boys, by pulling hot air past coals and your reagent, into a diffuser of water at the base."
	icon = 'modular_outpost/icons/obj/hookah.dmi'
	icon_state = "hookah"
	var/base_icon_state = "hookah"

	density = TRUE
	opacity = FALSE
	var/hoses_taken = 0
	var/lit = FALSE
	flags = REMOTEVIEW_ON_ENTER

	var/mob/living/occupant // micro abuse

/obj/structure/hookah/Initialize(mapload)
	. = ..()
	create_reagents(120)
	flags |= OPENCONTAINER
	update_icon()

/obj/structure/hookah/attack_hand(mob/user)
	// Remove hookah pipe
	if(hoses_taken < 4)
		hoses_taken++
		var/obj/item/hookah_pipe/P = new(src)
		P.owner = src
		user.visible_message(span_notice("\The [user] takes a pipe from \the [src]!"))
		user.put_in_active_hand(P)
		P.pickup(user)
		update_icon()
	else
		to_chat(user,span_warning("There are no pipes left!"))

/obj/structure/hookah/update_icon()
	cut_overlays()
	. = ..()
	if(!reagents.reagent_list.len)
		icon_state = "[base_icon_state]"
	else
		var/reagent_state
		if(!lit)
			icon_state = "[base_icon_state]_loaded"
			reagent_state = "[base_icon_state]_r"
		else
			icon_state = "[base_icon_state]_lit"
			reagent_state = "[base_icon_state]_rl"

		var/image/goo = image(icon, src, reagent_state)
		goo.appearance_flags = (RESET_COLOR|PIXEL_SCALE|KEEP_APART)
		goo.plane = OBJ_PLANE
		goo.layer = OBJ_LAYER-0.01
		goo.color += reagents.get_color()
		add_overlay(goo)
	for(var/i=1; i<5; i++)
		if(hoses_taken < i)
			var/image/hose = image(icon, src, "[base_icon_state]_h[i]")
			hose.appearance_flags = (RESET_COLOR|PIXEL_SCALE|KEEP_APART)
			hose.plane = OBJ_PLANE
			hose.layer = OBJ_LAYER+0.01
			add_overlay(hose)

/obj/structure/hookah/attackby(obj/item/O, mob/user)
	if(istype(O,/obj/item/holder))
		var/obj/item/holder/H = O
		if(!occupant)
			// place micros inside it
			occupant = H.held_mob
			H.held_mob = null
			user.drop_from_inventory(H)
			occupant.forceMove(src)
			qdel(H)
			user.visible_message(span_warning("\The [user] places \the [occupant] inside \the [src]!"))
			if(occupant.client)
				occupant.client.perspective = EYE_PERSPECTIVE
				occupant.client.eye = src
		else
			to_chat(user,span_warning("\The [occupant] is already inside!"))
	if(O.is_hot())
		if(!lit)
			lit = TRUE
			user.visible_message(span_notice("\The [user] lights \the [src]!"))
			update_icon()
		return
	if(istype(O,/obj/item/hookah_pipe))
		var/obj/item/hookah_pipe/P = O
		if(P.owner == src)
			user.drop_from_inventory(P,src)
		return
	. = ..()

/obj/structure/hookah/container_resist(var/mob/living)
	if(occupant != living)
		return FALSE
	to_chat(occupant, span_warning("You manage to pull yourself free of \the [src]."))
	occupant.forceMove(get_turf(src))
	occupant = null

/obj/structure/hookah/proc/puff_micro(mob/user)
	if(!occupant)
		return
	if(!iscarbon(occupant))
		return
	var/mob/living/carbon/C = occupant
	var/str = "Gasses billow around you"
	if(reagents && reagents.total_volume) // check if it has any reagents at all
		// Take a drag, but with your whole body.
		if(C.check_has_mouth())
			reagents.trans_to_mob(C, 0.5, CHEM_INGEST)
		reagents.trans_to_mob(C, 1, CHEM_TOUCH)
	// Sucking out the micro!
	if(user && prob(2))
		str += ", and you're sucked away with them"
		to_chat(C, span_danger("[str]!"))
		if(user.food_vore && user.vore_selected)
			if(!C.can_be_drop_prey || !C.food_vore)
				to_chat(C, span_warning("You manage to pull yourself free of \the [src] at the last second!"))
				to_chat(user, span_notice("[C] barely escapes from your [user.vore_selected]!"))
				C.forceMove(get_turf(src))
			else
				C.forceMove(user.vore_selected)
			occupant = null
	else
		to_chat(C, span_danger("[str]!"))


/obj/structure/hookah/on_reagent_change(changetype)
	. = ..()
	if(!reagents.reagent_list.len && lit)
		lit = FALSE
		visible_message(span_warning("\The [src] extinguishes!"))
	update_icon()

/obj/structure/hookah/examine(var/mob/user)
	. = ..()
	if(get_dist(user, src) <= 2)
		if(reagents && reagents.reagent_list.len)
			. += span_notice("It contains [reagents.total_volume] units of liquid.")
		else
			. += span_notice("It is empty.")
	if(occupant)
		. += span_warning("\The [occupant] is inside it!")


/obj/item/hookah_pipe
	name = "hookah pipe"
	desc = "The part of a hookah used to deliver the goods straight to your body!"
	icon = 'modular_outpost/icons/obj/hookah.dmi'
	icon_state = "hookah_hose"
	var/obj/structure/hookah/owner
	var/drag_amount = 1.5 // reagent transfered when smoked
	w_class = ITEMSIZE_NO_CONTAINER //nope, no stealing it silly!

/obj/item/hookah_pipe/Destroy()
	if(owner)
		owner.hoses_taken-- // Try to always keep these in sync
		owner.update_icon()
	visible_message(span_notice("\The [src] retracts!")) // Always retracts into host when destroyed
	. = ..()

/obj/item/hookah_pipe/attack_self(mob/user)
	. = ..(user)
	if(.)
		return TRUE
	smoke(user,user)

/obj/item/hookah_pipe/proc/check_retract()
	if(QDELETED(src) || QDELETED(loc))
		return TRUE
	if(!owner || QDELETED(owner))
		qdel(src)
		return TRUE
	// Must be in mob's hand
	if(!istype(loc,/mob))
		qdel(src)
		return TRUE
	// Prevent micros bringing their own pipes into the hookah
	if(loc.loc == owner)
		qdel(src)
		return TRUE
	// Check next to turf
	var/turf/T = get_turf(src)
	var/turf/owner_T = get_turf(owner)
	if(!T || !owner_T)
		qdel(src)
		return TRUE
	if(!T.Adjacent(owner_T) && owner.pulledby != loc) // adjacency doesn't matter if you're pulling the hookah itself around
		qdel(src)
		return TRUE
	return FALSE

/obj/item/hookah_pipe/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return
	smoke(M,user)

/obj/item/hookah_pipe/proc/smoke(mob/target, mob/user)
	if(check_retract())
		return
	// Use the pipe
	if(!owner.lit)
		to_chat(user,span_warning("\The [owner] isn't lit!"))
		return
	if(!owner.reagents.reagent_list.len)
		to_chat(user,span_warning("\The [owner] is empty!"))
		return
	if(user == target)
		target.visible_message(span_notice("\The [target] takes a drag from \the [owner]."))
	else
		user.visible_message(span_notice("\The [user] makes \the [target] take a drag from \the [owner]."))
	// puff micros first
	owner.puff_micro(target)
	// reagent processing mobs get it, otherwise just burn it
	if(!iscarbon(target))
		reagents.remove_any(drag_amount)
		return
	var/mob/living/carbon/C = target
	if(owner.reagents && owner.reagents.total_volume) // check if it has any reagents at all
		if(C.check_has_mouth())
			owner.reagents.trans_to_mob(C, drag_amount, CHEM_INGEST)

/obj/item/hookah_pipe/Moved(atom/old_loc, direction, forced, movetime)
	. = ..()
	if(ismob(old_loc))
		UnregisterSignal(old_loc, list(COMSIG_MOVABLE_MOVED,COMSIG_QDELETING))
	if(ismob(loc))
		RegisterSignal(loc, COMSIG_MOVABLE_MOVED, PROC_REF(check_retract))
		RegisterSignal(loc, COMSIG_QDELETING, PROC_REF(check_retract))
	// Explaining this:
	// I have to delay this, because giving something to a mob (even your other hand)
	// runs Drop from user -> Move to turf -> Pickup -> Move to user. There is no way
	// to check for being dropped to turf alone, without also breaking the give verb.
	spawn(0)
		check_retract()
