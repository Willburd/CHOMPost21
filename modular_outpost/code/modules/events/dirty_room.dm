/datum/event/dirty_room
	var/force_cult = FALSE

/datum/event/dirty_room/cult
	force_cult = TRUE

/datum/event/dirty_room/start()
	if(!GLOB.machines.len)
		return
	// Find a disposal bin and use that for area, or to blow out dirt all around it
	var/list/disposals = list()
	for(var/obj/machinery/M in GLOB.machines)
		if(istype(M,/obj/machinery/disposal))
			var/obj/machinery/disposal/D = M
			var/turf/T = get_turf(D)
			if(!T || !(T.z in using_map.station_levels)) // Not centcom!
				continue
			if(!(D.stat & BROKEN) && D.mode != 3 && D.anchored)
				disposals.Add(M)
	if(!disposals.len)
		return

	var/obj/machinery/disposal/D = pick(disposals)
	if(D)
		if(prob(4) || force_cult)
			// CULT TIME
			var/area/A = get_area(D)
			A.cult_spam()
		else
			var/safe = rand(3,8)
			while(safe-- > 0)
				// MAKE DORTY
				if(D)
					D.malfunction()
					playsound(D, 'sound/machines/hiss.ogg', 50, 0, 0)
					disposals.Remove(D)
					// Really need to make a nice mess cloud
					var/datum/effect/effect/system/smoke_spread/bad/disposal_dust/smoke = new
					smoke.set_up(rand(3,6),0, D.loc, 0)
					smoke.start()
					for(var/dir in GLOB.alldirs)
						smoke = new
						smoke.set_up(rand(1,3),0, D.loc, dir)
						smoke.start()
				if(!disposals.len)
					break
				D = pick(disposals)

// For admin abuse
/area/proc/cult_spam( var/list/text_set = null, var/turf/T = null)
	if(T)
		var/num_doodles = 0
		for(var/obj/effect/decal/cleanable/blood/writing/W in T)
			num_doodles++
		if(num_doodles >= 4)
			return
		for(var/i=1, i<rand(0,3), i++)
			var/obj/effect/decal/cleanable/blood/writing/W = new(T)
			W.basecolor = "#A10808"
			W.update_icon()
			W.message = pick(text_set)
			if(prob(3))
				W.visible_message(span_filter_notice(span_red("Invisible fingers crudely paint something in blood on [T]...")))
		return

	// These ghosts are pretty mean
	var/cursed_text = list(
						list("It's your fault","You did this","You let me die","You killed us","You killed them all"),
						list("Die!","You're worthless!","Everyone hates you!","Die already!","We all hate you!"),
						list("Die with us","Die!","We need you to die!","Come die with us!","We love you","Stay with us forever"),
						list("DEATH","DIE","KILL"),
						list("It hurts","The pain","PAIN","HELP"),
						list("HAHA","HAH","HA","HAHAHAHA"),
						list("SIN","SIN","YOUR THOUGHTS ARE UNCLEAN","UNCLEAN","HATE")
					)
	text_set = pick(cursed_text)
	if(prob(2)) // Secret merps
		text_set = list("merp","merp","merp","mip")

	var/list/TL = get_area_turfs(type)
	for(var/turf/simulated/TR in TL)
		if(TR.is_outdoors())
			continue
		if(TR.density) // Not on walls
			continue
		addtimer(CALLBACK(src, PROC_REF(cult_spam), text_set, TR), rand(1,10) SECONDS)

// Dirtcloud effects
/datum/effect/effect/system/smoke_spread/bad/disposal_dust
	smoke_type = /obj/effect/effect/smoke/bad/disposal_dust

/obj/effect/effect/smoke/bad/disposal_dust
	color = "#70593f"
	time_to_live = 120

/obj/effect/effect/smoke/bad/disposal_dust/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	var/turf/simulated/T = get_turf(src)
	if(istype(T,/turf/simulated))
		if(T.can_dirty)
			T.dirt += rand(90,160)
		T.update_dirt()

/obj/effect/effect/smoke/bad/disposal_dust/affect(var/mob/living/L) // This stuff is extra-vile.
	if (!..())
		return 0
	if(L.needs_to_breathe())
		L.emote("cough")
