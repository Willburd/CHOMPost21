/turf/proc/shovel_dig_trench(mob/user, obj/item/shovel/our_shovel)
	if(length(contents))
		to_chat(user, span_warning("You can't dig here!"))
		return
	// Make a trench
	to_chat(user, span_notice("\The [user] begins digging into \the [src] with \the [our_shovel]."))
	var/delay = (5 SECONDS * our_shovel.toolspeed)
	user.setClickCooldown(delay)
	if(do_after(user, delay, target = src))
		if(!(locate(/obj/structure/trench) in contents))
			new /obj/structure/trench(src)
		to_chat(user, span_notice("You dug a trench!"))
