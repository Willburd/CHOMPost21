#define SLOW_DELAY 1.2 SECONDS
#define SPEED_CHANGE 0.2 SECONDS
#define FAST_DELAY 0.1 SECONDS



// TODO - This isn't finished AT ALL



/obj/item/skateboard
	name = "Skateboard"
	desc = "Skate or die!"
	icon = 'modular_outpost/icons/obj/skateboard.dmi'
	icon_state = "skateboard"

	var/current_speed = SLOW_DELAY
	var/lingering_speed_timer = null
	can_buckle = FALSE

/obj/item/skateboard/Destroy(force, ...)
	. = ..()
	kill_timer()

/obj/item/skateboard/update_icon()
	cut_overlays()
	icon_state = initial(icon_state) + (can_buckle ? "_deployed" : "")

/obj/item/skateboard/relaymove(mob/user, direction)
	. = ..()
	if(world.time < (l_move_time + current_speed))
		return TRUE

	// Slowdown
	if(direction == reverse_direction(dir))
		current_speed += (SPEED_CHANGE * 2)
		if(current_speed >= SLOW_DELAY)
			kill_timer()
			return TRUE
	else
		// Increase speed
		if(direction == dir)
			current_speed -= SPEED_CHANGE
		// face direction if not reversing
		dir = direction

	// Apply movement
	current_speed = CLAMP(current_speed, FAST_DELAY, SLOW_DELAY)

	// Lingering rolling
	if(!lingering_speed_timer)
		lingering_speed_timer = addtimer(CALLBACK(src, PROC_REF(drifting_movement)), current_speed, TIMER_STOPPABLE | TIMER_LOOP)
		return TRUE

	// Reset the timer until we actually let go
	updatetimedelay(lingering_speed_timer, current_speed)
	return TRUE

/obj/item/skateboard/proc/drifting_movement()
	if(!can_buckle)
		kill_timer()
		return
	current_speed = CLAMP(current_speed - SPEED_CHANGE, FAST_DELAY, SLOW_DELAY)
	if(current_speed >= SLOW_DELAY)
		deltimer(lingering_speed_timer)
		return
	var/next_turf = get_step(src, dir)
	if(!Move(next_turf, dir, current_speed))
		bonk()

/obj/item/skateboard/proc/bonk()
	current_speed = SLOW_DELAY
	kill_timer()
	if(length(buckled_mobs))
		playsound(src, pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg'))
		var/mob/living/hit = buckled_mobs[1]
		hit.AdjustStunned(2)
		hit.adjustBruteLoss(rand(5,13))
	unbuckle_all_mobs()
	can_buckle = FALSE
	update_icon()

/obj/item/skateboard/proc/kill_timer()
	if(lingering_speed_timer)
		deltimer(lingering_speed_timer)

/obj/item/skateboard/dropped(mob/living/user)
	. = ..()
	can_buckle = isturf(loc)
	update_icon()

/obj/item/attack_hand(mob/living/user as mob)
	if(length(buckled_mobs))
		unbuckle_all_mobs()
		return
	. = ..()

/obj/item/skateboard/pickup(mob/user)
	. = ..()
	can_buckle = FALSE
	kill_timer()
	update_icon()
