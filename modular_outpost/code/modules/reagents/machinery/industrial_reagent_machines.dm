/obj/machinery/reagent_refinery
	var/default_max_vol = 120
	var/amount_per_transfer_from_this = 120
	var/possible_transfer_amounts = list(0,1,2,5,10,15,20,25,30,40,60,80,100,120)

	// It's dumb that this needs to be copied here.
	var/climbable = TRUE
	var/list/climbers
	var/climb_delay = 3.5 SECONDS

/obj/machinery/reagent_refinery/Initialize(mapload)
	. = ..()
	// reagent control
	reagents = new/datum/reagents(default_max_vol)
	reagents.my_atom = src
	update_neighbours()

/obj/machinery/reagent_refinery/Moved(atom/old_loc, direction, forced)
	. = ..()
	update_icon()

/obj/machinery/reagent_refinery/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(O.has_tool_quality(TOOL_WRENCH))
		playsound(src, O.usesound, 75, 1)
		anchored = !anchored
		user.visible_message("[user.name] [anchored ? "secures" : "unsecures"] the bolts holding [src.name] to the floor.", \
					"You [anchored ? "secure" : "unsecure"] the bolts holding [src] to the floor.", \
					"You hear a ratchet.")
		update_neighbours()
		update_icon()
		return
	if(istype(O,/obj/item/weapon/reagent_containers/glass) || \
		istype(O,/obj/item/weapon/reagent_containers/food/drinks/glass2) || \
		istype(O,/obj/item/weapon/reagent_containers/food/drinks/shaker))
		// Transfer FROM internal beaker to this.
		if (reagents.total_volume <= 0)
			to_chat(usr,"\The [src] is empty. There is nothing to drain into \the [O].")
			return
		// Fill up the whole volume if we can, DUMP IT OUT
		var/obj/item/weapon/reagent_containers/C = O
		reagents.trans_to_obj(C, reagents.total_volume)
		playsound(src, 'sound/machines/reagent_dispense.ogg', 25, 1)
		to_chat(usr,"You drain \the [src] into \the [C].")
		update_icon()
		return
	if(default_deconstruction_screwdriver(user, O))
		return
	if(default_deconstruction_crowbar(user, O))
		return
	. = ..()

/obj/machinery/reagent_refinery/proc/update_neighbours()
	// Update icons and neighbour icons to avoid loss of sanity
	for(var/direction in cardinal)
		var/turf/T = get_step(get_turf(src),direction)
		var/obj/machinery/other = locate(/obj/machinery/reagent_refinery) in T
		if(other && other.anchored)
			other.update_icon()


/obj/machinery/reagent_refinery/verb/set_APTFT() //set amount_per_transfer_from_this
	set name = "Set transfer amount"
	set category = "Object"
	set src in view(1)
	var/N = tgui_input_list(usr, "Amount per transfer from this:","[src]", possible_transfer_amounts)
	if (N)
		amount_per_transfer_from_this = N
	update_icon()

/obj/machinery/reagent_refinery/proc/transfer_tank( var/obj/machinery/reagent_refinery/target, var/source_forward_dir, var/filter_id = "")
	if(reagents.total_volume <= 0|| !anchored || !target.anchored)
		return
	if(!can_use_power_oneoff(active_power_usage))
		return

	// no back/forth, filters don't use just their forward, they send the side too!
	if(dir == reverse_dir[source_forward_dir])
		return

	// pumps and filters can only be FED in a straight line
	if((istype(target,/obj/machinery/reagent_refinery/pump) || istype(target,/obj/machinery/reagent_refinery/filter)) && dir != source_forward_dir)
		return

	// Transfer to target in amounts every process tick!
	use_power_oneoff(active_power_usage)
	if(filter_id == "")
		var/amount = reagents.trans_to_obj(target, amount_per_transfer_from_this)
		if(amount > 0)
			target.update_icon()
			update_icon()
		return amount
	else
		// Split out reagent...
		// Yet another hack, because I refuse to rewrite base code for a module. It's a shame it can't just be forced.
		var/old_flags = target.flags
		target.flags |= OPENCONTAINER // trans_id_to expects an opencontainer flag, but this is closed plumbing...
		var/amount = reagents.trans_id_to(target, filter_id, amount_per_transfer_from_this)
		target.flags = old_flags
		// End hacky flag stuff
		if(amount > 0)
			target.update_icon()
			update_icon()
		return amount

// Climbing is kinda critical for these
/obj/machinery/reagent_refinery/verb/climb_on()
	set name = "Climb structure"
	set desc = "Climbs onto a structure."
	set category = "Object"
	set src in oview(1)

	do_climb(usr)

/obj/machinery/reagent_refinery/MouseDrop_T(mob/target, mob/user)
	var/mob/living/H = user
	if(istype(H) && can_climb(H) && target == user)
		do_climb(target)
	else
		return ..()

/obj/machinery/reagent_refinery/proc/can_climb(var/mob/living/user, post_climb_check=0)
	if (!climbable || !can_touch(user) || (!post_climb_check && (user in climbers)))
		return 0

	if (!user.Adjacent(src))
		to_chat(user, "<span class='danger'>You can't climb there, the way is blocked.</span>")
		return 0

	var/obj/occupied = turf_is_crowded()
	if(occupied)
		to_chat(user, "<span class='danger'>There's \a [occupied] in the way.</span>")
		return 0
	return 1

/obj/machinery/reagent_refinery/proc/turf_is_crowded()
	var/turf/T = get_turf(src)
	if(!T || !istype(T))
		return "empty void"
	if(T.density)
		return T
	for(var/obj/O in T.contents)
		if(istype(O,/obj/machinery/reagent_refinery))
			var/obj/machinery/reagent_refinery/S = O
			if(S.climbable) continue
		if(O && O.density && !(O.flags & ON_BORDER)) //ON_BORDER structures are handled by the Adjacent() check.
			return O
	return 0

/obj/machinery/reagent_refinery/proc/do_climb(var/mob/living/user)
	if (!can_climb(user))
		return

	usr.visible_message("<span class='warning'>[user] starts climbing onto \the [src]!</span>")
	LAZYDISTINCTADD(climbers, user)

	if(!do_after(user,(issmall(user) ? climb_delay * 0.6 : climb_delay)))
		LAZYREMOVE(climbers, user)
		return

	if (!can_climb(user, post_climb_check=1))
		LAZYREMOVE(climbers, user)
		return

	usr.forceMove(climb_to(user))

	if (get_turf(user) == get_turf(src))
		usr.visible_message("<span class='warning'>[user] climbs onto \the [src]!</span>")
	LAZYREMOVE(climbers, user)

/obj/machinery/reagent_refinery/proc/climb_to(var/mob/living/user)
	return get_turf(src)

/obj/machinery/reagent_refinery/proc/can_touch(var/mob/user)
	if (!user)
		return 0
	if(!Adjacent(user))
		return 0
	if (user.restrained() || user.buckled)
		to_chat(user, "<span class='notice'>You need your hands and legs free for this.</span>")
		return 0
	if (user.stat || user.paralysis || user.sleeping || user.lying || user.weakened)
		return 0
	if (isAI(user))
		to_chat(user, "<span class='notice'>You need hands for this.</span>")
		return 0
	return 1
