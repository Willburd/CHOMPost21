// Mice enter mouseholes
/mob/living/simple_mob/animal/passive
	ai_holder_type = /datum/ai_holder/simple_mob/passive/mouse

/datum/ai_holder/simple_mob/passive/mouse/handle_wander_movement()
	if(!holder)
		return
	if(isturf(holder.loc) && can_act())
		if((wander_delay - 1) <= 0 && attempt_mouse_hole_warp(holder))
			return
	. = ..()

/proc/attempt_mouse_hole_warp(var/mob/mob_doing_warp)
	var/obj/structure/micro_tunnel/hole = locate() in mob_doing_warp.loc
	if(!hole || prob(90)) // low chance to warp
		return FALSE

	var/list/possible_holes = GLOB.micro_tunnels.Copy()
	possible_holes -= hole
	if(!length(possible_holes))
		return FALSE

	var/obj/structure/micro_tunnel/goal_hole = pick(possible_holes)
	if(QDELETED(goal_hole))
		return FALSE

	mob_doing_warp.visible_message("\The [mob_doing_warp] crawls into \the [hole] and vanishes!")
	mob_doing_warp.forceMove(get_turf(goal_hole))
	mob_doing_warp.visible_message("\The [mob_doing_warp] scrambles out of \the [goal_hole]!")
	return TRUE
