//////////////////////////////////////////////////////////////////////////////////////
// HAUNTING DATUMS, Major spooky event time!
//////////////////////////////////////////////////////////////////////////////////////
/datum/station_haunt
	var/name = "BAD EVENT"

/datum/station_haunt/proc/init()
	return

/datum/station_haunt/proc/fire()
	return

/datum/station_haunt/proc/end()
	SShaunting.current_haunt = null
	qdel(src)


// Flicker somelights
/datum/station_haunt/light_flicker
	name = "Light Flicker"

/datum/station_haunt/light_flicker/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/light/L in targ_area)
			if(prob(15))
				L.flicker(rand(10,20))
	end()


// Ghost Spam
/datum/station_haunt/ghost_write
	name = "Ghost Writers"

/datum/station_haunt/ghost_write/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		targ_area.cult_spam()
	end()


// Haunt area
/datum/station_haunt/haunt_area
	name = "Haunt Area"
	var/start_time = 0
	var/dur = 5 MINUTES
	var/area/targ_area = null

/datum/station_haunt/haunt_area/init()
	start_time = world.time
	dur = rand(5,10) MINUTES
	targ_area = SShaunting.get_haunt_area()
	if(targ_area && !targ_area.haunted)
		targ_area.haunted = TRUE

/datum/station_haunt/haunt_area/fire()
	if(!targ_area)
		end()
	if(world.time > start_time + dur)
		end()

/datum/station_haunt/haunt_area/end()
	targ_area.haunted = FALSE
	. = ..()


// Vents scream at someone
/datum/station_haunt/screaming_vents
	name = "Screaming Vents"
	var/list/vents = list()

/datum/station_haunt/screaming_vents/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/SB in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(SB))
		for(var/obj/machinery/atmospherics/unary/vent_pump/PU in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(PU))

/datum/station_haunt/screaming_vents/fire()
	if(!vents.len)
		end()
		return
	var/datum/weakref/W = pick(vents)
	vents -= W
	var/obj/machinery/M = W?.resolve()
	if(M)
		M.visible_message("\The [M] [pick(list("Shrieks!","Screams!","Wails!"))]")
		SSmotiontracker.ping(M,100)


// Oh nosferatu~
/datum/station_haunt/lights_off
	name = "Light Switch"

/datum/station_haunt/lights_off/init()

/datum/station_haunt/lights_off/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/light_switch/L in targ_area)
			L.attack_hand(null) // boop
			break
	if(prob(40))
		end()


// Window banging
/datum/station_haunt/banging_windows
	name = "Banging Windows"
	var/list/windows = list()

/datum/station_haunt/banging_windows/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/structure/window/W in targ_area)
			if(prob(15))
				windows.Add(WEAKREF(W))

/datum/station_haunt/banging_windows/fire()
	if(!windows.len)
		end()
		return
	var/datum/weakref/W = pick(windows)
	windows -= W
	var/obj/structure/window/M = W.resolve()
	if(M)
		M.visible_message(span_notice("Unseen hands knock on \the [M]."))
		playsound(M, 'sound/effects/Glasshit.ogg', 50, 1)
		SSmotiontracker.ping(M,100)


// Watcher
/datum/station_haunt/watching_me
	name = "Watching Me"

/datum/station_haunt/watching_me/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		to_chat(M,span_cult("You feel like you are being watched."))
	end()


// Chills
/datum/station_haunt/chills
	name = "Chills"

/datum/station_haunt/chills/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		to_chat(M,span_cult("You feel a chill run down your spine."))
	end()


// Creepycrawlies
/datum/station_haunt/vent_bugs
	name = "Buggy Vents"
	var/list/vents = list()

/datum/station_haunt/vent_bugs/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/SB in targ_area)
			if(prob(25))
				vents.Add(WEAKREF(SB))
		for(var/obj/machinery/atmospherics/unary/vent_pump/PU in targ_area)
			if(prob(25))
				vents.Add(WEAKREF(PU))

/datum/station_haunt/vent_bugs/fire()
	if(!vents.len)
		end()
		return
	var/datum/weakref/W = pick(vents)
	vents -= W
	var/obj/machinery/M = W?.resolve()
	if(M)
		var/turf/T = get_turf(M)
		M.visible_message(span_warning("bugs crawl out of \the [M]"))
		SSmotiontracker.ping(M,100)
		new /mob/living/simple_mob/animal/passive/cockroach(T)
		new /mob/living/simple_mob/animal/passive/cockroach(T)
		if(prob(10))
			new /mob/living/simple_mob/animal/passive/cockroach(T)
		if(prob(10))
			new /mob/living/simple_mob/animal/passive/cockroach(T)
		if(prob(10))
			new /obj/effect/spider/spiderling/stunted(T)
		if(prob(10))
			new /obj/effect/spider/spiderling/stunted(T)


// Window smashing
/datum/station_haunt/smashing_windows
	name = "Smashing Windows"
	var/list/windows = list()

/datum/station_haunt/smashing_windows/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/structure/window/W in targ_area)
			if(prob(10))
				windows.Add(WEAKREF(W))

/datum/station_haunt/smashing_windows/fire()
	if(!windows.len)
		end()
		return
	var/datum/weakref/W = pick(windows)
	windows -= W
	var/obj/structure/window/M = W.resolve()
	if(M)
		SSmotiontracker.ping(M,100)
		if(prob(30))
			M.shatter(TRUE)
		else
			M.visible_message(span_notice("Unseen hands slam on \The [M]."))
			playsound(M, 'sound/effects/Glasshit.ogg', 50, 1)


// Vents whispers
/datum/station_haunt/whispering_vents
	name = "Whispering Vents"
	var/player_voice = "hello..."
	var/list/vents = list()

/datum/station_haunt/whispering_vents/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	var/mob/P = SShaunting.get_player_target()
	if(!isnull(P))
		player_voice = P.real_name
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/SB in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(SB))
		for(var/obj/machinery/atmospherics/unary/vent_pump/PU in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(PU))

/datum/station_haunt/whispering_vents/fire()
	if(!vents.len)
		end()
		return
	var/datum/weakref/W = pick(vents)
	vents -= W
	var/obj/machinery/M = W?.resolve()
	if(M)
		M.visible_message("\The [M] whispers, [pick(list("Follow us...","We need you...","Down here...",player_voice))]")
		SSmotiontracker.ping(M,50)


// Heard own name said
/datum/station_haunt/heard_name
	name = "Heard Name"

/datum/station_haunt/heard_name/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		to_chat(M,span_cult("[M]..."))
	end()


// Smash somelights
/datum/station_haunt/light_smash
	name = "Light Smash"

/datum/station_haunt/light_smash/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/light/L in targ_area)
			if(prob(25))
				L.broken()
			else
				L.flicker(12)
	end()


// Turn off APC
/datum/station_haunt/trip_apc
	name = "Trip Apc"

/datum/station_haunt/trip_apc/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		if(targ_area.apc)
			targ_area.apc.locked = FALSE
			targ_area.apc.toggle_breaker()
			targ_area.apc.visible_message("clicks","clicks")
			SSmotiontracker.ping(targ_area.apc,100)
	end()


// Lock doors
/datum/station_haunt/lock_doors
	name = "Lock Doors In Area"
	var/start_time = 0
	var/dur = 1 MINUTES
	var/area/targ_area

/datum/station_haunt/lock_doors/init()
	start_time = world.time
	dur = rand(1,3) MINUTES
	targ_area = SShaunting.get_haunt_area()
	if(targ_area && !targ_area.haunted)
		for(var/obj/machinery/door/airlock/A in targ_area)
			A.lock()

/datum/station_haunt/lock_doors/fire()
	if(!targ_area)
		end()
	if(world.time > start_time + dur)
		end()

/datum/station_haunt/lock_doors/end()
	for(var/obj/machinery/door/airlock/A in targ_area)
		A.unlock()
	. = ..()


// Rush at tesh with motion pings
/datum/station_haunt/tesh_rush
	name = "Tesh Rush"
	var/turf/goal_turf = null
	var/turf/current_turf = null

/datum/station_haunt/tesh_rush/init()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		goal_turf = get_turf(M)
		var/xx = rand(5,10) * (prob(50) ? 1 : -1)
		var/yy = rand(5,10) * (prob(50) ? 1 : -1)
		current_turf = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)

/datum/station_haunt/tesh_rush/fire()
	step_at()
	if(prob(40))
		step_at()
	if(prob(10))
		step_at()
	var/mob/M = SShaunting.get_player_target()
	if(!current_turf)
		end()

/datum/station_haunt/tesh_rush/proc/step_at()
	if(!current_turf || goal_turf == current_turf)
		current_turf = null
		end()
	var/d = get_dir(current_turf,goal_turf)
	if(d)
		SSmotiontracker.ping(current_turf,100)
		SSmotiontracker.ping(current_turf,60)
		SSmotiontracker.ping(current_turf,20)
		current_turf = get_step(current_turf,d)
	else
		current_turf = null
		end()


// Distant scream
/datum/station_haunt/distant_scream
	name = "Far Scream"

/datum/station_haunt/distant_scream/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/goal_turf = get_turf(M)
		var/xx = rand(5,10) * (prob(50) ? 1 : -1)
		var/yy = rand(5,10) * (prob(50) ? 1 : -1)
		var/turf/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(T)
			var/screm = pick(list('sound/voice/shriek1.ogg','sound/voice/teshscream.ogg','sound/voice/malescream_2.ogg','sound/hallucinations/far_noise.ogg'))
			M.playsound_local(T, screm, 20)
	end()


// open nearby door
/datum/station_haunt/open_nearby_door
	name = "Open Nearby Door"

/datum/station_haunt/open_nearby_door/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/T = get_turf(M)
		var/obj/machinery/door/airlock/A = locate() in orange(5,T)
		A.open()
	end()


// heavy breathing, quiet
/datum/station_haunt/heavy_breath
	name = "Heavy Breathing"

/datum/station_haunt/heavy_breath/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/goal_turf = get_turf(M)
		var/xx = rand(5,10) * (prob(50) ? 1 : -1)
		var/yy = rand(5,10) * (prob(50) ? 1 : -1)
		var/turf/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(T)
			var/screm = pick(list('sound/goonstation/spooky/Meatzone_BreathingSlow.ogg','sound/goonstation/spooky/Meatzone_BreathingFast.ogg'))
			M.playsound_local(T, screm, 15)
	end()


// small item thrown
/datum/station_haunt/throw_item
	name = "Throw Item"

/datum/station_haunt/throw_item/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/T = get_turf(M)
		var/obj/item/I = locate() in orange(6,T)
		if(I.anchored == FALSE && isturf(I.loc))
			I.throw_at(M,5,5,null,TRUE)
	end()


// small item thrown
/datum/station_haunt/hallucinate
	name = "Hallucinate"

/datum/station_haunt/hallucinate/fire()
	var/mob/living/M = SShaunting.get_player_target()
	if(isliving(M))
		M.hallucination += 10
	end()


// knock down
/datum/station_haunt/knock_down
	name = "Knock Down"

/datum/station_haunt/knock_down/fire()
	var/mob/living/M = SShaunting.get_player_target()
	if(isliving(M))
		visible_message(span_warning("something shoves \the [M] to the ground!"))
		M.Stun(8)
		M.Weaken(5)
	end()
