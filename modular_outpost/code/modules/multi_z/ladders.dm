/obj/structure/ladder/top_hatch
	name = "deck hatch"
	desc = "A metal hatch that leads down to a lower deck."
	description_info = "alt-click to open and close, it will close automatically if left open."
	icon = 'modular_outpost/icons/obj/structures.dmi'
	icon_state = "hatchdown"
	var/is_open = FALSE
	var/hatch_timer = null
	plane = TURF_PLANE
	layer = ABOVE_TURF_LAYER

/obj/structure/ladder/top_hatch/proc/open_hatch()
	if(!is_open)
		playsound(src, 'sound/machines/door/windowdoor.ogg', 100, 1)
		flick("hatchdown-opening", src)
		is_open = TRUE
		update_icon()
	// Reset timer each time it's called
	if(hatch_timer)
		deltimer(hatch_timer)
	hatch_timer = addtimer(CALLBACK(src, PROC_REF(close_hatch)), 10 SECONDS, TIMER_DELETE_ME|TIMER_STOPPABLE)

/obj/structure/ladder/top_hatch/Destroy()
	hatch_timer = null
	. = ..()

/obj/structure/ladder/top_hatch/proc/close_hatch()
	if(!is_open)
		return
	playsound(src, 'sound/machines/door/windowdoor.ogg', 100, 1)
	flick("hatchdown-close", src)
	is_open = FALSE
	update_icon()

/obj/structure/ladder/top_hatch/update_icon()
	if(is_open)
		icon_state = "hatchdown-open"
		return
	icon_state = "hatchdown"

/obj/structure/ladder/top_hatch/click_alt(mob/user)
	if(user.is_incorporeal())
		return
	if(!is_open)
		open_hatch()
		return
	close_hatch()

/obj/structure/ladder/top_hatch/attack_hand(mob/M)
	if(!is_open)
		return
	. = ..()

// Blocked normally, but if a mob tries to use it this skips attack_hand, just automagically open for them
/mob/may_climb_ladders(var/ladder)
	if(istype(ladder, /obj/structure/ladder/top_hatch))
		var/obj/structure/ladder/top_hatch/hatch = ladder
		hatch.open_hatch()
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////
// Construction
//////////////////////////////////////////////////////////////////////////////////////

/obj/structure/ladder/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/stack/material/steel))
		var/obj/item/stack/material/steel/S = C
		if(target_up)
			to_chat(user, span_warning("Only the top of a ladder can become a hatch."))
			return
		if(S.get_amount() < 5)
			to_chat(user, span_warning("You need five sheets of steel to convert \the [src] into a hatch."))
			return
		user.visible_message("\The [user] starts to assemble a hatch over \the [src].", \
							"You start a assemble a hatch over \the [src].")
		if(do_after(user, 8 SECONDS, target = src))
			if(!S.use(5))
				return
			user.visible_message("\The [user] finishes assembling \the [src].", \
								"You finish assembling \the [src].")
			become_hatch()
		return
	. = ..()

/obj/structure/ladder/proc/become_hatch()
	if(target_up)
		return
	var/turf/ladder_turf = get_turf(src)
	var/obj/structure/ladder/lower_ladder = target_down
	target_down.target_up = null // Clear it for connection when the new hatch is created
	target_down = null // clear it before Destroy() runs so it doesn't deconstruct the lower ladder
	qdel(src)
	// Create hatch
	var/obj/structure/ladder/top_hatch/new_hatch = new /obj/structure/ladder/top_hatch(ladder_turf)
	new_hatch.is_open = TRUE
	new_hatch.close_hatch()
