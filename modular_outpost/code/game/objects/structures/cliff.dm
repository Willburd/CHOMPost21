GLOBAL_LIST_EMPTY(cliff_icon_cache_upper)
GLOBAL_LIST_EMPTY(cliff_icon_cache_lower)

/*
Cliffs give a visual illusion of depth by seperating two places while presenting a 'top' and 'bottom' side.

Mobs moving into a cliff from the bottom side will simply bump into it and be denied moving into the tile,
where as mobs moving into a cliff from the top side will 'fall' off the cliff, forcing them to the bottom, causing significant damage and stunning them.

Mobs can climb this while wearing climbing equipment by clickdragging themselves onto a cliff, as if it were a table.

Flying mobs can pass over all cliffs with no risk of falling.

Projectiles and thrown objects can pass, however if moving upwards, there is a chance for it to be stopped by the cliff.
This makes fighting something that is on top of a cliff more challenging.

As a note, dir points upwards, e.g. pointing WEST means the left side is 'up', and the right side is 'down'.

When mapping these in, be sure to give at least a one tile clearance, as NORTH facing cliffs expand to
two tiles on initialization, and which way a cliff is facing may change during maploading.
*/

/obj/structure/cliff
	name = "cliff"
	desc = "A steep rock ledge. You might be able to climb it if you feel bold enough."
	description_info = "Walking off the edge of a cliff while on top will cause you to fall off, causing severe injury.<br>\
	You can climb this cliff if wearing special climbing equipment, by click-dragging yourself onto the cliff.<br>\
	Projectiles traveling up a cliff may hit the cliff instead, making it more difficult to fight something \
	on top."
	icon = 'modular_outpost/icons/obj/flora/cliffs.dmi'
	icon_state = "planner"

	anchored = TRUE
	density = TRUE
	opacity = FALSE
	climbable = TRUE
	climb_delay = 1 SECOND // Ignore this, is set in the actual climb check based on your boots
	unacidable = TRUE
	block_turf_edges = TRUE // Don't want turf edges popping up from the cliff edge.
	plane = TURF_PLANE

	var/uphill_penalty = 30 // Odds of a projectile not making it up the cliff.

/obj/structure/cliff/corner
	icon_state = "planner-corner"

/obj/structure/cliff/corner/Initialize()
	icon_state = "cliff-corner"
	. = INITIALIZE_HINT_LATELOAD
	register_dangerous_to_step()
	update_icon()

/obj/structure/cliff/Initialize()
	icon_state = "cliff"
	. = INITIALIZE_HINT_LATELOAD
	register_dangerous_to_step()
	update_icon()

/obj/structure/cliff/Destroy()
	unregister_dangerous_to_step()
	. = ..()

/obj/structure/cliff/update_icon()
	// Now for making the top-side look like a different turf.
	cut_overlays()
	var/turf/upperT = get_step(src, dir)
	if(!istype(upperT))
		return

	var/cache_string = "[icon_state]-[dir]"
	var/obj/structure/cliff/abovecliff = null
	var/obj/structure/cliff/undercliff = null

	// check cliffs in tiles for overlays
	for(var/obj/structure/cliff/C in upperT.contents)
		abovecliff = C
		break

	// Make overlay for top of cliff
	if(!((cache_string+"-[upperT.name]") in GLOB.cliff_icon_cache_upper))
		// upper side
		var/icon/underlying_ground = icon(upperT.icon, upperT.icon_state, upperT.dir)
		var/icon/subtract = icon(icon, "cliff-" + (istype(src,/obj/structure/cliff/corner) ? "bottom" : "top") + "-subtract", istype(src,/obj/structure/cliff/corner) ? reverse_dir[dir] : dir)
		underlying_ground.Blend(subtract, ICON_SUBTRACT)
		var/image/final = image(underlying_ground)
		GLOB.cliff_icon_cache_upper[cache_string+"-[upperT.name]"] = final

	// Check for cliffs under this one
	var/turf/lowerT = get_step(src, reverse_dir[dir])
	if(istype(lowerT))
		for(var/obj/structure/cliff/C in lowerT.contents)
			undercliff = C
			break

	// Make overlay for bottom of cliff
	var/turf/underT = get_turf(src.loc)
	if(istype(underT))
		if(!((cache_string+"-[underT.name]") in GLOB.cliff_icon_cache_lower))
			// lower side
			var/icon/underlying_ground = icon(underT.icon, underT.icon_state, underT.dir)
			var/icon/subtract = icon(icon, "cliff-" + (istype(src,/obj/structure/cliff/corner) ? "top" : "bottom") + "-subtract", istype(src,/obj/structure/cliff/corner) ? reverse_dir[dir] : dir)
			underlying_ground.Blend(subtract, ICON_SUBTRACT)
			var/image/final = image(underlying_ground)
			GLOB.cliff_icon_cache_lower[cache_string+"-[underT.name]"] = final

	if(isnull(abovecliff))
		add_overlay(GLOB.cliff_icon_cache_upper[cache_string+"-[upperT.name]"])
	if(isnull(undercliff))
		add_overlay(GLOB.cliff_icon_cache_lower[cache_string+"-[underT.name]"])

/obj/structure/cliff/Moved(atom/oldloc)
	. = ..()
	if(.)
		var/turf/old_turf = get_turf(oldloc)
		var/turf/new_turf = get_turf(src)
		if(old_turf != new_turf)
			old_turf.unregister_dangerous_object(src)
			new_turf.register_dangerous_object(src)

/obj/structure/cliff/set_dir(new_dir)
	..()

// Movement-related code.
/obj/structure/cliff/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover))
		var/mob/living/L = mover
		if(L.hovering || L.flying || L.is_incorporeal()) // Flying mobs can always pass.
			return TRUE
		return ..()

	// Projectiles and objects flying 'upward' have a chance to hit the cliff instead, wasting the shot.
	else if(istype(mover, /obj))
		var/obj/O = mover
		if(check_shield_arc(src, dir, O)) // This is actually for mobs but it will work for our purposes as well.
			if(prob(uphill_penalty)) // Firing upwards facing NORTH means it will likely have to pass through two cliffs, so the chance is halved.
				return FALSE
		return TRUE

/obj/structure/cliff/Bumped(atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(should_fall(L))
			fall_off_cliff(L)
			return
	..()

/obj/structure/cliff/proc/should_fall(mob/living/L)
	if(L.hovering || L.flying || L.is_incorporeal())
		return FALSE

	var/turf/T = get_turf(L)
	if(T && get_dir(T, loc) & reverse_dir[dir]) // dir points 'up' the cliff, e.g. cliff pointing NORTH will cause someone to fall if moving SOUTH into it.
		return TRUE
	return FALSE

/obj/structure/cliff/proc/fall_off_cliff(mob/living/L)
	if(!istype(L))
		return FALSE
	var/turf/T = get_step(src, reverse_dir[dir])
	if(istype(T))
		var/safe_fall = FALSE
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			safe_fall = H.species.handle_falling(H, T, silent = TRUE, planetary = FALSE)

		if(safe_fall)
			visible_message(span_notice( "\The [L] glides down from \the [src]."))
		else
			visible_message(span_danger( "\The [L] falls off \the [src]!"))
		L.forceMove(T)

		if(!safe_fall)
			// Do the actual hurting. Double cliffs do halved damage due to them most likely hitting twice.
			if(istype(L.buckled, /obj/vehicle)) // People falling off in vehicles will take less damage, but will damage the vehicle severely.
				var/obj/vehicle/vehicle = L.buckled
				vehicle.adjust_health(20)
				to_chat(L, span_warning( "\The [vehicle] absorbs some of the impact, damaging it."))

			playsound(L, 'sound/effects/break_stone.ogg', 70, 1)
			L.Weaken(2)

		var/fall_time = 3
		sleep(fall_time) // A brief delay inbetween the two sounds helps sell the 'ouch' effect.

		if(safe_fall)
			visible_message(span_notice( "\The [L] lands on \the [T]."))
			playsound(L, "rustle", 25, 1)
			return

		playsound(L, "punch", 70, 1)
		shake_camera(L, 1, 1)

		visible_message(span_danger( "\The [L] hits \the [T]!"))

		// The bigger they are, the harder they fall.
		// They will take at least 20 damage at the minimum, and tries to scale up to 40% of their max health.
		// This scaling is capped at 100 total damage, which occurs if the thing that fell has more than 250 health.
		var/damage = between(20, L.getMaxHealth() * 0.4, 100)
		var/target_zone = ran_zone()
		var/blocked = L.run_armor_check(target_zone, "melee")
		var/soaked = L.get_armor_soak(target_zone, "melee")

		L.apply_damage(damage, BRUTE, target_zone, blocked, soaked, used_weapon=src)

		// Now fall off more cliffs below this one if they exist.
		var/obj/structure/cliff/bottom_cliff = locate() in T
		if(bottom_cliff)
			visible_message(span_danger( "\The [L] rolls down towards \the [bottom_cliff]!"))
			sleep(5)
			bottom_cliff.fall_off_cliff(L)

/obj/structure/cliff/can_climb(mob/living/user, post_climb_check = FALSE)
	// Cliff climbing requires climbing gear.
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/clothing/shoes/shoes = H.shoes
		if(shoes && shoes.rock_climbing)
			climb_delay = 8 SECONDS
			return ..() // Do the other checks too.
		else
			climb_delay = 25 SECONDS
			return ..() // Do the other checks too.

	to_chat(user, span_warning( "\The [src] is too steep to climb."))
	return FALSE

// This tells AI mobs to not be dumb and step off cliffs willingly.
/obj/structure/cliff/is_safe_to_step(mob/living/L)
	if(should_fall(L))
		return FALSE
	return ..()

/obj/structure/cliff/CanPass(atom/movable/mover, turf/target)
	return mover.z > z // Allow falling from above





/obj/structure/cliff_end
	name = "cliff"
	desc = "A steep rock ledge. You might be able to climb it if you feel bold enough."
	description_info = "Walking off the edge of a cliff while on top will cause you to fall off, causing severe injury.<br>\
	You can climb this cliff if wearing special climbing equipment, by click-dragging yourself onto the cliff.<br>\
	Projectiles traveling up a cliff may hit the cliff instead, making it more difficult to fight something \
	on top."
	icon = 'modular_outpost/icons/obj/flora/cliffs.dmi'
	icon_state = "planner-end"

	anchored = TRUE
	density = FALSE
	opacity = FALSE
	climbable = FALSE
	unacidable = TRUE
	block_turf_edges = FALSE
	plane = TURF_PLANE
	var/fadedir = NORTH // direction originally placed in

/obj/structure/cliff_end/Initialize()
	icon_state = "cliff-end"
	. = INITIALIZE_HINT_LATELOAD
	fadedir = dir
	update_icon()

/obj/structure/cliff_end/update_icon()
	// Copy the cliff in the direction we face, and add a fadeout overlay
	cut_overlays()
	var/turf/T = get_step(src, fadedir)
	if(istype(T))
		var/obj/structure/cliff/foundcliff = null
		for(var/obj/structure/cliff/C in T.contents)
			foundcliff = C
			break

		if(!isnull(foundcliff))
			icon = foundcliff.icon
			icon_state = foundcliff.icon_state
			if(icon_state == "planner")
				icon_state = "cliff"
			if(icon_state == "planner-corner")
				icon_state = "cliff-corner"
			dir = foundcliff.dir

			// add fade overlay to discovered cliff icon!
			var/cache_string = "cliff-end-[fadedir]"
			T = get_turf(src.loc) // use the turf under us!
			if(istype(T))
				if(!((cache_string+"-[T.name]") in GLOB.cliff_icon_cache_upper))
					var/icon/underlying_ground = icon(T.icon, T.icon_state, T.dir)
					var/icon/subtract = icon(icon, "cliff-end-subtract", fadedir)
					underlying_ground.Blend(subtract, ICON_SUBTRACT)
					var/image/final = image(underlying_ground)
					GLOB.cliff_icon_cache_upper[cache_string+"-[T.name]"] = final
				add_overlay(GLOB.cliff_icon_cache_upper[cache_string+"-[T.name]"])
