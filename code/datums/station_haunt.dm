//////////////////////////////////////////////////////////////////////////////////////
// HAUNTING DATUMS, Major spooky event time!
//////////////////////////////////////////////////////////////////////////////////////
/datum/station_haunt
	var/name = "BAD EVENT"

/datum/station_haunt/New()
	. = ..()
	SShaunting.log_haunting(name,TRUE)

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
	var/max_lights = rand(2,7)
	if(targ_area)
		for(var/obj/machinery/light/L in targ_area)
			if(prob(25))
				L.flicker(rand(10,20))
				max_lights--
			if(max_lights <= 0)
				break
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

/datum/station_haunt/haunt_area/New()
	. = ..()
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
	if(targ_area)
		targ_area.haunted = FALSE
	. = ..()


// Vents scream at someone
/datum/station_haunt/screaming_vents
	name = "Screaming Vents"
	var/list/vents = list()

/datum/station_haunt/screaming_vents/New()
	. = ..()
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

/datum/station_haunt/lights_off/fire()
	var/area/targ_area = SShaunting.get_haunt_area()
	if(targ_area)
		for(var/obj/machinery/light_switch/L in targ_area)
			L.attack_hand(null) // boop
			break
	end()


// Window banging
/datum/station_haunt/banging_windows
	name = "Banging Windows"
	var/list/windows = list()

/datum/station_haunt/banging_windows/New()
	. = ..()
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

/datum/station_haunt/vent_bugs/New()
	. = ..()
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

/datum/station_haunt/smashing_windows/New()
	. = ..()
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

/datum/station_haunt/whispering_vents/New()
	. = ..()
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

/datum/station_haunt/lock_doors/New()
	. = ..()
	start_time = world.time
	dur = rand(1,3) MINUTES
	targ_area = SShaunting.get_haunt_area()
	if(targ_area && !targ_area.haunted)
		for(var/obj/machinery/door/airlock/A in targ_area)
			A.lock()

/datum/station_haunt/lock_doors/fire()
	if(world.time > (start_time + dur))
		end()
		return
	if(!targ_area)
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

/datum/station_haunt/tesh_rush/New()
	. = ..()
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


// tesh encircle
/datum/station_haunt/tesh_encircle
	name = "Echo Encircle"
	var/start_time = 0
	var/dur = 6 SECONDS
	var/mob/living/carbon/human/target_mob = null

/datum/station_haunt/tesh_encircle/New()
	. = ..()
	start_time = world.time
	dur = rand(6,16) SECONDS
	target_mob = SShaunting.get_player_target()

/datum/station_haunt/tesh_encircle/fire()
	if(world.time > (start_time + dur))
		end()
		return
	if(!target_mob || QDELING(target_mob))
		end()
		return
	for(var/i = 0 to rand(1,3))
		var/turf/goal_turf = get_turf(target_mob)
		var/xx = rand(1,8) * (prob(50) ? 1 : -1)
		var/yy = rand(1,8) * (prob(50) ? 1 : -1)
		var/turf/simulated/floor/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(istype(T))
			SSmotiontracker.ping(T,80)


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
			M.playsound_local(T, screm, 40)
	end()


// Distant alarm
/datum/station_haunt/distant_alarm
	name = "Far Alarm"

/datum/station_haunt/distant_alarm/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/goal_turf = get_turf(M)
		var/xx = rand(8,14) * (prob(50) ? 1 : -1)
		var/yy = rand(8,14) * (prob(50) ? 1 : -1)
		var/turf/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(T)
			var/screm = pick(list('sound/effects/alarms/fire_alarm/fire_alarm_mid.ogg','sound/effects/alarms/decon_alarm.ogg','sound/effects/alarms/engineering_alarm.ogg','sound/effects/alarms/crit_alarm.ogg','sound/effects/alarms/causality_alarm.ogg'))
			M.playsound_local(T, screm, 40)
	end()


// open nearby door
/datum/station_haunt/open_nearby_door
	name = "Open Nearby Door"

/datum/station_haunt/open_nearby_door/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/T = get_turf(M)
		var/obj/machinery/door/airlock/A = locate() in orange(5,T)
		if(A)
			A.open()
	end()


// change status display
/datum/station_haunt/change_nearby_display
	name = "Change Nearby Display"

/datum/station_haunt/change_nearby_display/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/T = get_turf(M)

		var/obj/machinery/status_display/A = locate() in orange(8,T)
		if(A)
			A.mode = A.STATUS_DISPLAY_MESSAGE
			A.visible_message("clicks","clicks")

			var/list/mess = list("HATE YOU","WE SEE YOU","IN OUR FLESH","CURSES UPON YOU","[M]","[M]...","[M]!","NO ESCAPE","FOLLOW DOWN")
			A.message1 = pick(mess)
			A.message2 = pick(mess)
			A.update_display(A.message1, A.message2)
	end()


// camera stareing
/datum/station_haunt/camera_stare
	name = "Camera Stare"

/datum/station_haunt/camera_stare/fire()
	var/mob/M = SShaunting.get_player_target()
	if(M)
		var/turf/T = get_turf(M)
		var/obj/machinery/camera/A = locate() in orange(8,T)
		if(A)
			A.visible_message("\The [A] stops moving, and focuses on \the [M]")
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
			M.playsound_local(T, screm, 65)
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


// Spawn a hallucination attacker
/datum/station_haunt/hallucinate
	name = "Hallucinate"

/datum/station_haunt/hallucinate/fire()
	var/mob/living/M = SShaunting.get_player_target()
	if(isliving(M))
		M.hallucination += 80
		// Retry spawning the hallucination attacker until we get one.
		for(var/i = 0 to 5)
			if(M.create_hallucination_attacker(forced_type = /obj/effect/fake_attacker/human/attacker))
				break
	end()


// knock down
/datum/station_haunt/knock_down
	name = "Knock Down"

/datum/station_haunt/knock_down/fire()
	var/mob/living/M = SShaunting.get_player_target()
	if(isliving(M))
		M.visible_message(span_warning("something shoves \the [M] to the ground!"))
		playsound(M, get_sfx("punch"), 50, 1)
		M.Stun(8)
		M.Weaken(5)
	end()


// Bang nearby vents
/datum/station_haunt/vent_crawler
	name = "Vent Crawler"
	var/start_time = 0
	var/dur = 1 MINUTES

/datum/station_haunt/vent_crawler/New()
	. = ..()
	start_time = world.time
	dur = rand(1,3) MINUTES

/datum/station_haunt/vent_crawler/fire()
	if(world.time > (start_time + dur))
		end()
		return
	var/mob/M = SShaunting.get_player_target()
	var/turf/check_T = get_turf(M)
	if(!check_T)
		return
	if(prob(5))
		var/obj/machinery/atmospherics/P = locate() in orange(3,check_T)
		if(!P)
			return
		var/turf/T = get_turf(P)
		if(!T)
			return
		SSmotiontracker.ping(T,40) // Teshari rattler
		playsound(T, 'sound/machines/ventcrawl.ogg', 50, 1, -3)
		var/message = pick(
			prob(90);"* clunk *",
			prob(90);"* thud *",
			prob(90);"* clatter *",
			prob(1);"* " + span_giganteus("ඞ") + " *"
		)
		T.runechat_message(message)


// bleeding
/datum/station_haunt/bleeding
	name = "Bleeding"
	var/start_time = 0
	var/dur = 1 MINUTES

/datum/station_haunt/bleeding/New()
	. = ..()
	start_time = world.time
	dur = rand(10,60) SECONDS

/datum/station_haunt/bleeding/fire()
	if(world.time > (start_time + dur))
		end()
		return
	if(prob(60))
		var/mob/living/carbon/human/H = SShaunting.get_player_target()
		if(ishuman(H) && !H.isSynthetic())
			H.drip(1)
			H.adjustHalLoss(1)


// blood rain
/datum/station_haunt/blood_rain
	name = "Blood Rain"
	var/start_time = 0
	var/dur = 2 SECONDS
	var/mob/living/carbon/human/target_mob = null

/datum/station_haunt/blood_rain/New()
	. = ..()
	start_time = world.time
	dur = rand(6,10) SECONDS
	target_mob = SShaunting.get_player_target()
	if(target_mob)
		to_chat(target_mob,span_danger("Something starts to drip from above."))

/datum/station_haunt/blood_rain/fire()
	if(world.time > (start_time + dur))
		end()
		return
	if(!target_mob || QDELING(target_mob))
		end()
		return
	if(!ishuman(target_mob) || target_mob.isSynthetic())
		end()
		return
	for(var/i = 0 to rand(3,5))
		var/turf/goal_turf = get_turf(target_mob)
		var/xx = rand(1,4) * (prob(50) ? 1 : -1)
		var/yy = rand(1,4) * (prob(50) ? 1 : -1)
		var/turf/simulated/floor/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(istype(T,/turf/simulated/floor))
			target_mob.adjustHalLoss(0.25)
			target_mob.hallucination += 0.05
			blood_splatter(T,target_mob)


// launch a shuttle to a random destination
/datum/station_haunt/shuttle_move
	name = "Shuttle Move"

/datum/station_haunt/shuttle_move/fire()
	var/list/viable_shuttles = list()
	for(var/key in SSshuttles.shuttles)
		var/datum/shuttle/autodock/multi/check = SSshuttles.shuttles[key]
		if(istype(check,/datum/shuttle/autodock/multi))
			if(!check.can_be_haunted)
				continue
			viable_shuttles.Add(check)
	if(viable_shuttles.len)
		var/datum/shuttle/autodock/multi/end_shuttle = pick(viable_shuttles)
		if(end_shuttle.destinations_cache.len)
			var/dest_key = pick(end_shuttle.destinations_cache)
			end_shuttle.set_destination(dest_key, null)
			end_shuttle.launch(null)
	end()


// sabotage a shuttle if possible
/datum/station_haunt/shuttle_sabotage
	name = "Shuttle Sabotage"

/datum/station_haunt/shuttle_sabotage/fire()
	var/list/viable_shuttles = list()
	for(var/key in SSshuttles.shuttles)
		var/datum/shuttle/autodock/multi/check = SSshuttles.shuttles[key]
		if(istype(check,/datum/shuttle/autodock/multi))
			if(!check.can_be_haunted && LAZYLEN(check.crash_locations))
				continue
			viable_shuttles.Add(check)
	if(viable_shuttles.len)
		var/datum/shuttle/autodock/multi/end_shuttle = pick(viable_shuttles)
		end_shuttle.emagged_crash = TRUE // We choose violence
	end()


// lurker
/datum/station_haunt/lurker
	name = "Lurking Spirit"
	var/start_time = 0
	var/dur = 1 MINUTES
	var/mob/observer/dead/ghost = null
	var/visible_chance = 0
	var/spawn_fire = FALSE
	var/has_burned_floor = FALSE
	var/use_player_chance = 90

/datum/station_haunt/lurker/can_appear
	visible_chance = 2
	use_player_chance = 70

/datum/station_haunt/lurker/will_appear
	visible_chance = 70
	use_player_chance = 50

/datum/station_haunt/lurker/pyromanic
	visible_chance = 20
	use_player_chance = 40
	spawn_fire = TRUE

/datum/station_haunt/lurker/New()
	. = ..()
	start_time = world.time
	dur = rand(1,3) MINUTES
	var/mob/M = null
	if(prob(use_player_chance))
		// spawn a player ghost
		M = SShaunting.get_random_player()
		if(!ishuman(M) || M.isSynthetic())
			return
		ghost = new(M)
		ghost.name = M.dna.real_name
		ghost.desc = "?"
		ghost.timeofdeath = world.time
	else
		// spawn a custom demon
		var/list/demons = list(
			/mob/living/simple_mob/clowns/big/normal,
			/mob/living/simple_mob/clowns/big/cluwne,
			/mob/living/simple_mob/shadekin/red/dark,
			/mob/living/simple_mob/vore/demon,
			/mob/living/simple_mob/vore/demon/wendigo,
			/mob/living/simple_mob/vore/demon/engorge
		)
		var/path = pick(demons)
		M = new path(null)
		ghost = new(M)
		ghost.name = M.name
		ghost.desc = "?"
		ghost.timeofdeath = world.time
		qdel(M)

/datum/station_haunt/lurker/fire()
	if(world.time > (start_time + dur))
		end()
		return
	if(!ghost || QDELING(ghost))
		end()
		return
	var/mob/living/carbon/human/target_mob = SShaunting.get_player_target()
	if(!target_mob)
		end()
		return
	// Follow player
	var/turf/T1 = get_turf(ghost)
	var/turf/T2 = get_turf(target_mob)
	if(T1.Distance(T2) >= 6)
		var/turf/goal_turf = get_turf(target_mob)
		var/xx = rand(3,5) * (prob(50) ? 1 : -1)
		var/yy = rand(3,5) * (prob(50) ? 1 : -1)
		var/turf/simulated/floor/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
		if(T)
			ghost.forceMove(T)
	ghost.dir = get_dir(T1,T2)
	// Say things
	if(prob(2))
		if(!has_burned_floor)
			T1.visible_message(pick(list("\The [ghost] whispers, [target_mob]...","\The [ghost] Screams!","\The [ghost] Shrieks!")))
		else
			T1.visible_message(pick(list("\The [ghost] screams, [target_mob]!","\The [ghost] screams, Burn!","\The [ghost] screams, Die!")))
	if(ghost.is_manifest && prob(3) && spawn_fire && !has_burned_floor)
		T1.lingering_fire(0.25)
		has_burned_floor = TRUE
		dur -= rand(10,20) SECONDS
	if(!ghost.is_manifest && prob(visible_chance))
		ghost.manifest(null)

/datum/station_haunt/lurker/end()
	qdel(ghost)
	. = ..()

//////////////////////////////////////////////////////////////////////////////////////
// HAUNTING ENITIES, Things that go bump in the night!
//////////////////////////////////////////////////////////////////////////////////////
/datum/station_haunt/entity_spawn
	name = "Entity"
	var/datum/weakref/entity = null

/datum/station_haunt/entity_spawn/New()
	. = ..()
	var/list/ent_list = subtypesof(/datum/haunting_entity) - SShaunting.used_haunt_entities // Don't allow repeats
	if(!ent_list.len)
		return
	var/ent = pick(ent_list)
	entity = WEAKREF(new ent())

/datum/station_haunt/entity_spawn/fire()
	if(entity?.resolve()) // Still active
		return
	end()

/datum/station_haunt/entity_spawn/end()
	SShaunting.reset_world_haunt() // Tension release
	. = ..()

// Entities are datums that are added to the process() loop and persue a targetted player
// Causing general havok and panic while they break things or cause distress through some means
// Entities are expected to despawn after a set amount of time, so they release control of the haunting subsystem
// Entities are NOT MOBS,they cannot be killed, they are ENVIRONMENTAL beasts, your choices are to run or die
/datum/haunting_entity
	var/name = "BAD ENTITY"
	var/start_time = 0
	var/dur = 1 MINUTE
	var/datum/weakref/target_mob = null
	var/atom/loc = null
	var/use_only_once = TRUE

/datum/haunting_entity/New()
	. = ..()
	START_PROCESSING(SSfastprocess, src)
	if(use_only_once)
		SShaunting.used_haunt_entities.Add(type)
	var/mob/targeting_actual = SShaunting.get_player_target()
	if(!targeting_actual)
		qdel(src)
		return
	var/turf/goal_turf = get_turf(targeting_actual)
	var/xx = rand(8,20) * (prob(50) ? 1 : -1)
	var/yy = rand(8,20) * (prob(50) ? 1 : -1)
	var/turf/T = locate(goal_turf.x + xx,goal_turf.y + yy,goal_turf.z)
	if(!T)
		qdel(src)
		return
	// We're prepped and ready
	target_mob = WEAKREF(targeting_actual)
	loc = T

/datum/haunting_entity/Destroy(force)
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/datum/haunting_entity/proc/validate_existance()
	if(!loc)
		return FALSE
	if(!get_target())
		return FALSE
	if(world.time > (start_time + dur))
		return FALSE
	return TRUE

/datum/haunting_entity/proc/get_target()
	return target_mob?.resolve()

/datum/haunting_entity/process()
	return



// TODO - entity plans:
// -Wandering light that proclaims you have gazed upon its beauty and then ashes you in 5 minutes after saying your time in this world is limited, blindness counters
// -Chasing flesh wall for one person to run from, despawns the flesh eventually
// -Lighting void somewhere that hurts you
// -Lyrac moving toward you through walls
