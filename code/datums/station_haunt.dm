/datum/controller/subsystem/haunting
	var/static/list/hauntings = list(
		MODE_CALM = list(
			/datum/station_haunt/light_flicker,
			/datum/station_haunt/lights_off,
			/datum/station_haunt/watching_me,
			/datum/station_haunt/chills
			),
		MODE_CONCERN = list(
			/datum/station_haunt/light_flicker,
			/datum/station_haunt/lights_off,
			/datum/station_haunt/watching_me,
			/datum/station_haunt/chills,
			/datum/station_haunt/whispering_vents
			),
		MODE_UNNERVING = list(
			/datum/station_haunt/light_flicker,
			/datum/station_haunt/ghost_write,
			/datum/station_haunt/lights_off,
			/datum/station_haunt/banging_windows,
			/datum/station_haunt/watching_me,
			/datum/station_haunt/vent_bugs,
			/datum/station_haunt/whispering_vents
			),
		MODE_SPOOKY = list(
			/datum/station_haunt/light_flicker,
			/datum/station_haunt/ghost_write,
			/datum/station_haunt/haunt_area,
			/datum/station_haunt/screaming_vents,
			/datum/station_haunt/banging_windows,
			/datum/station_haunt/vent_bugs,
			/datum/station_haunt/whispering_vents
			),
		MODE_SCARY = list(
			/datum/station_haunt/ghost_write,
			/datum/station_haunt/haunt_area,
			/datum/station_haunt/screaming_vents,
			/datum/station_haunt/banging_windows,
			/datum/station_haunt/watching_me,
			/datum/station_haunt/chills,
			/datum/station_haunt/vent_bugs,
			/datum/station_haunt/smashing_windows
			),
		MODE_SUPERSPOOKY = list(
			/datum/station_haunt/ghost_write,
			/datum/station_haunt/screaming_vents,
			/datum/station_haunt/banging_windows,
			/datum/station_haunt/watching_me,
			/datum/station_haunt/chills,
			/datum/station_haunt/smashing_windows
			)
	)

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
	var/area/targ_area

/datum/station_haunt/haunt_area/init()
	start_time = world.time
	dur = rand(5,10) MINUTES
	targ_area = SShaunting.get_haunt_area()
	if(targ_area && !targ_area.haunted)
		targ_area.haunted

/datum/station_haunt/haunt_area/fire()
	if(!targ_area)
		end()
	if(world.time > start_time + dur)
		targ_area.haunted = FALSE
		end()


// Vents scream at someone
/datum/station_haunt/screaming_vents
	name = "Screaming Vents"
	var/player_scream = "Scree!"
	var/list/vents = list()

/datum/station_haunt/screaming_vents/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	var/mob/P = SShaunting.current_player_target?.resolve()
	if(!isnull(P))
		player_scream = P.real_name
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/S in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(S))
		for(var/obj/machinery/atmospherics/unary/vent_pump/P in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(P))

/datum/station_haunt/screaming_vents/fire()
	if(!vents.len)
		end()
		return
	var/datum/weakref/W = pick(vents)
	vents -= W
	var/obj/machinery/M = W?.resolve()
	if(M)
		M.visible_message(pick(list("Shriek!","Scream!","Wail!",player_scream)))
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
		M.visible_message(span_notice("Unseen hands knock on [src]."))
		playsound(M, 'sound/effects/Glasshit.ogg', 50, 1)
		SSmotiontracker.ping(M,100)



// Watcher
/datum/station_haunt/watching_me
	name = "Watching Me"

/datum/station_haunt/watching_me/fire()
	var/mob/M = SShaunting.current_player_target?.resolve()
	if(M && M.client)
		to_chat(M,span_cult("You feel like you are being watched."))
	end()



// Chills
/datum/station_haunt/chills
	name = "Chills"

/datum/station_haunt/chills/fire()
	var/mob/M = SShaunting.current_player_target?.resolve()
	if(M && M.client)
		to_chat(M,span_cult("You feel a chill run down your spine."))
	end()


// Creepycrawlies
/datum/station_haunt/vent_bugs
	name = "Buggy Vents"
	var/list/vents = list()

/datum/station_haunt/vent_bugs/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/S in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(S))
		for(var/obj/machinery/atmospherics/unary/vent_pump/P in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(P))

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
			M.visible_message(span_notice("Unseen hands slam on [src]."))
			playsound(M, 'sound/effects/Glasshit.ogg', 50, 1)



// Vents whispers
/datum/station_haunt/whispering_vents
	name = "Whispering Vents"
	var/player_voice = "hello..."
	var/list/vents = list()

/datum/station_haunt/whispering_vents/init()
	var/area/targ_area = SShaunting.get_haunt_area()
	var/mob/P = SShaunting.current_player_target?.resolve()
	if(!isnull(P))
		player_voice = P.real_name
	if(targ_area)
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/S in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(S))
		for(var/obj/machinery/atmospherics/unary/vent_pump/P in targ_area)
			if(prob(15))
				vents.Add(WEAKREF(P))

/datum/station_haunt/whispering_vents/fire()
	if(!vents.len)
		end()
		return
	var/datum/weakref/W = pick(vents)
	vents -= W
	var/obj/machinery/M = W?.resolve()
	if(M)
		M.visible_message(pick(list("Follow us...","We need you...","Down here...",player_voice)))
		SSmotiontracker.ping(M,50)
