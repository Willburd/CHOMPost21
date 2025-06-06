/obj/structure/ladder
	name = "ladder"
	desc = "A ladder. You can climb it up and down."
	icon_state = "ladder01"
	icon = 'icons/obj/structures/multiz.dmi'
	density = FALSE
	opacity = 0
	anchored = TRUE

	var/allowed_directions = DOWN
	var/obj/structure/ladder/target_up
	var/obj/structure/ladder/target_down

	var/climb_time = 2 SECONDS

/obj/structure/ladder/Initialize(mapload)
	. = ..()
	// the upper will connect to the lower
	if(allowed_directions & DOWN) //we only want to do the top one, as it will initialize the ones before it.
		for(var/obj/structure/ladder/L in GetBelow(src))
			if(L.allowed_directions & UP)
				target_down = L
				L.target_up = src
				return
	update_icon()

/obj/structure/ladder/Destroy()
	if(target_down)
		target_down.target_up = null
		target_down = null
	if(target_up)
		target_up.target_down = null
		target_up = null
	return ..()

/obj/structure/ladder/attack_generic(mob/user)
	//Simple Animal
	if(isanimal(user))
		attack_hand(user)
	else
		return ..()

/obj/structure/ladder/attackby(obj/item/C as obj, mob/user as mob)
	// Outpost 21 edit begin - Deconstructing ladder
	if(C.has_tool_quality(TOOL_WELDER))
		var/obj/item/weldingtool/WT = C.get_welder()
		if(WT.remove_fuel(0, user))
			playsound(src, 'sound/items/Welder2.ogg', 50, 1)
			user.visible_message("\The [user] starts to deconstruct \the [src].", \
				"You start to deconstruct \the [src].", \
				"You hear welding")
			if(do_after(user, 2 SECONDS))
				if(QDELETED(src) || !WT.isOn()) return
				var/obj/structure/ladder_assembly/A
				to_chat(user, "You deconstruct \the [src].")
				if(target_up)
					target_up.visible_message("\The [target_up] deconstructs from below")
					A = new /obj/structure/ladder_assembly(target_up.loc)
					A.state = 2 // CONSTRUCTION_WELDED in code\modules\multiz\ladder_assembly_vr.dm
					A.anchored = TRUE
					qdel(target_up)
				if(target_down)
					target_down.visible_message("\The [target_down] deconstructs from above")
					A = new /obj/structure/ladder_assembly(target_down.loc)
					A.state = 2 // CONSTRUCTION_WELDED in code\modules\multiz\ladder_assembly_vr.dm
					A.anchored = TRUE
					qdel(target_down)
				A = new /obj/structure/ladder_assembly(loc)
				A.state = 1 // CONSTRUCTION_WRENCHED in code\modules\multiz\ladder_assembly_vr.dm
				A.anchored = TRUE
				qdel(src)
			return
	// Outpost 21 edit end
	attack_hand(user)
	return

/obj/structure/ladder/attack_hand(var/mob/M)
	if(!M.may_climb_ladders(src))
		return

	var/obj/structure/ladder/target_ladder = getTargetLadder(M)
	if(!target_ladder)
		return
	if(!(M.loc == loc) && !M.Move(get_turf(src)))
		to_chat(M, span_notice("You fail to reach \the [src]."))
		return

	climbLadder(M, target_ladder)

/obj/structure/ladder/attack_ghost(var/mob/M)
	var/target_ladder = getTargetLadder(M)
	if(target_ladder)
		M.forceMove(get_turf(target_ladder))

/obj/structure/ladder/attack_robot(var/mob/M)
	attack_hand(M)
	return

/obj/structure/ladder/proc/getTargetLadder(var/mob/M)
	if((!target_up && !target_down) || (target_up && !istype(target_up.loc, /turf) || (target_down && !istype(target_down.loc,/turf))))
		to_chat(M, span_notice("\The [src] is incomplete and can't be climbed."))
		return
	if(target_down && target_up)
		var/direction = tgui_alert(M,"Do you want to go up or down?", "Ladder", list("Up", "Down", "Cancel"))

		if(!direction || direction == "Cancel")
			return

		if(!M.may_climb_ladders(src))
			return

		switch(direction)
			if("Up")
				return target_up
			if("Down")
				return target_down
	else
		return target_down || target_up

/mob/proc/may_climb_ladders(var/ladder)
	if(!Adjacent(ladder))
		to_chat(src, span_warning("You need to be next to \the [ladder] to start climbing."))
		return FALSE
	if(incapacitated())
		to_chat(src, span_warning("You are physically unable to climb \the [ladder]."))
		return FALSE
	return TRUE

/mob/observer/dead/may_climb_ladders(var/ladder)
	return TRUE

/obj/structure/ladder/proc/climbLadder(var/mob/M, var/obj/target_ladder)
	var/direction = (target_ladder == target_up ? "up" : "down")
	M.visible_message(span_infoplain(span_bold("\The [M]") + " begins climbing [direction] \the [src]!"),
		span_info("You begin climbing [direction] \the [src]!"),
		span_info("You hear the grunting and clanging of a metal ladder being used."))

	target_ladder.audible_message(span_notice("You hear something coming [direction] \the [src]"), runemessage = "clank clank")

	var/climb_modifier = 1
	if(ishuman(M))
		var/mob/living/carbon/human/MS = M
		climb_modifier = MS.species.climb_mult

	if(do_after(M, (climb_time * climb_modifier), src))
		// Outpost 21 edit begin - Deconstructing ladder
		if(QDELETED(target_ladder) || QDELETED(src) || QDELETED(M))
			return
		// Outpost 21 edit end
		var/turf/T = get_turf(target_ladder)
		for(var/atom/A in T)
			if(!A.CanPass(M, M.loc, 1.5, 0))
				to_chat(M, span_notice("\The [A] is blocking \the [src]."))
				return FALSE
		return M.forceMove(T) //VOREStation Edit - Fixes adminspawned ladders

/obj/structure/ladder/CanPass(obj/mover, turf/source, height, airflow)
	return airflow || !density

/obj/structure/ladder/update_icon()
	icon_state = "ladder[!!(allowed_directions & UP)][!!(allowed_directions & DOWN)]"

/obj/structure/ladder/up
	allowed_directions = UP
	icon_state = "ladder10"

/obj/structure/ladder/updown
	allowed_directions = UP|DOWN
	icon_state = "ladder11"
