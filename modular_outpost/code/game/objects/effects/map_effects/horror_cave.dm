GLOBAL_LIST_EMPTY(horror_cave_entrances)
GLOBAL_LIST_EMPTY(horror_cave_exits)

// Wandering warp effect that sends you to a cave system on the vr map, there are more warps there that send you back. Making the UD even more maze-like
/obj/effect/abstract/horror_cave_warp
	name = "horror cave warp"
	icon = 'icons/effects/effects.dmi'
	icon_state = "redgate_hole"
	alpha = 0
	var/cooldown_time = 0

/obj/effect/abstract/horror_cave_warp/Initialize(mapload)
	. = ..()
	var/area/find_area = get_area(src)
	if(istype(find_area, /area/specialty/horror_cavern))
		GLOB.horror_cave_entrances.Add(src)
	else
		GLOB.horror_cave_exits.Add(src)
	random_move()

/obj/effect/abstract/horror_cave_warp/proc/random_move()
	var/turf/check = get_step(src, pick(ALL_CARDINALS))
	if(!check.density)
		forceMove(check)
	addtimer(CALLBACK(src, PROC_REF(random_move)), rand(60,300) SECONDS, TIMER_DELETE_ME)

/obj/effect/abstract/horror_cave_warp/Destroy()
	. = ..()
	var/area/find_area = get_area(src)
	if(istype(find_area, /area/specialty/horror_cavern))
		GLOB.horror_cave_entrances.Remove(src)
	else
		GLOB.horror_cave_exits.Remove(src)

/obj/effect/abstract/horror_cave_warp/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(world.time < cooldown_time)
		return
	if(isanimal(AM)) // Avoids simplemob crowding
		return
	if(!isliving(AM))
		return
	var/mob/living/check_mob = AM
	if(check_mob.stat != CONSCIOUS)
		return
	if(!length(GLOB.horror_cave_exits) || !length(GLOB.horror_cave_entrances))
		return
	var/obj/effect/abstract/horror_cave_warp/destination = null
	var/area/find_area = get_area(src)
	if(istype(find_area, /area/specialty/horror_cavern))
		destination = pick(GLOB.horror_cave_exits)
	else
		destination = pick(GLOB.horror_cave_entrances)
	var/turf/goal_spot = get_turf(destination)
	if(!goal_spot)
		return
	destination.cooldown_time = world.time + rand(1000,2000)
	cooldown_time = world.time + rand(1000,2000)
	spawn(1)
		check_mob.AdjustBlinded(2, TRUE)
		check_mob.Life()
		if(check_mob.pulling) // can bring pulled things with you
			check_mob.pulling.forceMove(goal_spot)
		check_mob.forceMove(goal_spot)
