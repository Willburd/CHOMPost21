//====vessel self-destruct system====
/obj/machinery/nuclearbomb/station
	name = "self-destruct terminal"
	desc = "For when it all gets too much to bear. Do not taunt."
	icon = 'icons/obj/machines/nuke_station.dmi'
	icon_state = "idle"
	anchored = TRUE
	deployable = 1
	extended = 1

	var/list/flash_tiles = list()
	var/list/inserters = list()
	var/last_turf_state
	var/warningstage = 0

	var/announced = FALSE
	var/countdown_start_minutes = 10 // default (10 mins)
	var/self_destruct_cutoff = 60 * 5 //Seconds (5 mins)

	var/countdown_timer = null
	var/cache_full_time = 0 // This is agonizing, but the value you put in should be retained
	var/exploding = FALSE

/obj/machinery/nuclearbomb/station/Initialize(mapload)
	. = ..()
	verbs -= /obj/machinery/nuclearbomb/verb/make_deployable
	for(var/turf/simulated/floor/T in get_area(src))
		flash_tiles += T
	update_icon() // this updates the flasher tiles too!
	for(var/obj/machinery/self_destruct/ch in get_area(src))
		inserters += ch

	// spawn the disk and paper!
	if(nukeitems.len)
		var/paper_spawn_loc = pick(nukeitems)
		if(paper_spawn_loc)
			// Create and pass on the bomb code paper.
			var/obj/item/paper/P = new(paper_spawn_loc)
			P.info = "The nuclear authorization code is: <b>[r_code]</b>"
			P.name = "nuclear bomb code"
			log_world("Nuclear codes paper spawned, location [P.loc.x] [P.loc.y] [P.loc.z]")

		nukeitems -= paper_spawn_loc
		var/nukedisk_spawn_loc = paper_spawn_loc
		if(nukeitems.len > 0)
			nukedisk_spawn_loc = pick(nukeitems)
		var/obj/item/disk/nuclear/disk = new /obj/item/disk/nuclear(nukedisk_spawn_loc)
		log_world("Nuclear disk spawned, location [disk.loc.x] [disk.loc.y] [disk.loc.z]")
	else
		error("No nuclear landmarks defined")

/obj/machinery/nuclearbomb/station/Destroy()
	flash_tiles.Cut()
	. = ..()

/obj/machinery/nuclearbomb/station/attack_hand(mob/user as mob)
	if(!user.IsAdvancedToolUser())
		return
	add_fingerprint(user)
	user.set_machine(src)
	tgui_interact(user)

/obj/machinery/nuclearbomb/station/tgui_interact(mob/user, datum/tgui/ui)
	if(stat & (BROKEN|NOPOWER))
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NukeConsole", name)
		ui.open()

/obj/machinery/nuclearbomb/station/attackby(obj/item/O as obj, mob/user as mob)
	if(O.is_wrench())
		return
	if(istype(O, /obj/item/disk/nuclear))
		insert_disk(O, user)
		return
	. = ..()

/obj/machinery/nuclearbomb/station/proc/insert_disk(var/obj/item/disk/nuclear/O, mob/user as mob)
	user.drop_item(src)
	auth = O
	radiowarn( FALSE, FALSE)

/obj/machinery/nuclearbomb/station/proc/eject_disk()
	if(!auth)
		return
	auth.forceMove(get_turf(src))
	yes_code = 0
	auth = null

/obj/machinery/nuclearbomb/station/proc/safety_toggle(mob/user as mob)
	if(exploding)
		return
	if(!GLOB.bomb_set)
		safety = !(safety)
		if(safety)
			abort_timer()
		update_icon()
	else
		to_chat(user, span_warning("Cannot enable safety, self destruct is armed."))

/obj/machinery/nuclearbomb/station/proc/start_timer(mob/user as mob)
	if(exploding)
		return
	if(safety)
		to_chat(user, span_warning("The safety is still on."))
		return
	if(has_timer())
		return
	for(var/inserter in inserters)
		var/obj/machinery/self_destruct/sd = inserter
		if(!sd || !sd.armed)
			to_chat(user, span_warning("An inserter has not been armed or is damaged."))
			return
	GLOB.bomb_set = 1 //There can still be issues with this reseting when there are multiple bombs. Not a big deal tho for Nuke/N
	// notify station
	if(get_security_level() != SEC_LEVEL_DELTA)
		priority_announcement.Announce("Self destruct sequence has been activated. Self-destructing in [timeleft] seconds.", "Self-Destruct Control Computer")
	set_security_level(SEC_LEVEL_DELTA)
	if(countdown_timer)
		deltimer(countdown_timer, SStimer)
	countdown_timer = addtimer(CALLBACK(src, PROC_REF(explode)), countdown_start_minutes MINUTES, TIMER_DELETE_ME|TIMER_STOPPABLE)
	cache_full_time = timeleft(countdown_timer, SStimer) // we need to do this for dumb reasons
	update_icon()
	announced = FALSE

/obj/machinery/nuclearbomb/station/proc/abort_timer()
	if(exploding)
		return
	if(!has_timer())
		return
	if(get_security_level() == SEC_LEVEL_DELTA)
		priority_announcement.Announce("Self destruct sequence has been cancelled.", "Self-Destruct Control Computer")
		set_security_level(SEC_LEVEL_RED)
	if(has_timer())
		deltimer(countdown_timer, SStimer)
		countdown_timer = null
	GLOB.bomb_set = 0
	update_icon()

/obj/machinery/nuclearbomb/station/process()
	if(has_timer())
		GLOB.bomb_set = 1 //So long as there is one nuke timing, it means one nuke is armed.
		if(countdown_too_far_gone() && !announced)
			priority_announcement.Announce("The self-destruct sequence has reached terminal countdown, abort systems have been disabled.", "Self-Destruct Control Computer")
			announced = TRUE
	return 0

/obj/machinery/nuclearbomb/station/proc/has_timer()
	return exploding || countdown_timer

/obj/machinery/nuclearbomb/station/proc/get_time_remaining()
	if(exploding)
		return 0
	var/remaining = (countdown_start_minutes MINUTES) / (1 SECOND) // deci to seconds
	if(has_timer())
		remaining = timeleft(countdown_timer, SStimer) SECONDS
	return remaining

/// This is ugly. But without doing this the input time of Xminutes jumps up to show the real time it would take with server lag factored in... 10 mins to 13 for example
/obj/machinery/nuclearbomb/station/proc/get_compensating_time()
	if(exploding)
		return (countdown_start_minutes MINUTES) / (1 SECOND) // deci to seconds
	if(!cache_full_time)
		return (countdown_start_minutes MINUTES) / (1 SECOND) // deci to seconds
	return ((countdown_start_minutes MINUTES) * (get_time_remaining() / cache_full_time)) / (1 SECOND) // Solve the percent of the alarm remaining and solve off of the start minutes

/obj/machinery/nuclearbomb/station/proc/countdown_too_far_gone()
	return exploding || (get_compensating_time() <= self_destruct_cutoff)

/obj/machinery/nuclearbomb/station/update_icon()
	var/target_icon_state
	if(exploding)
		target_icon_state = "rcircuitanim"
		icon_state = "exploding"
	else if(has_timer())
		target_icon_state = "rcircuitanim"
		icon_state = "urgent"
	else if(!safety)
		target_icon_state = "rcircuit"
		icon_state = "greenlight"
	else
		target_icon_state = "rcircuitanim_broken"
		icon_state = "idle"

	if(!last_turf_state || target_icon_state != last_turf_state)
		for(var/thing in flash_tiles)
			var/turf/simulated/floor/T = thing
			if(!istype(T, /turf/simulated/floor/redgrid))
				flash_tiles -= T
				continue
			T.icon_state = target_icon_state
		last_turf_state = target_icon_state

/obj/machinery/nuclearbomb/station/tgui_act(action, params, datum/tgui/ui)
	if(..())
		return TRUE
	if(!ui.user.canmove || ui.user.stat || ui.user.restrained())
		return FALSE

	add_fingerprint(ui.user)
	if(countdown_too_far_gone())
		to_chat(ui.user, span_warning("The self-destruct sequence has reached terminal countdown, system has been disabled."))
		return FALSE

	update_icon()
	switch(action)
		if("ejectDisk")
			if(auth)
				eject_disk()
				return TRUE

		if("armingCode")
			if(auth)
				if(yes_code)
					code = "DISARMED"
					yes_code = FALSE
					safety = TRUE
					update_icon()
					return TRUE

				var/max_code = 99999
				var/new_code = tgui_input_number(ui.user,"Enter arming code","Arming Code", 0, max_code,0)
				if(new_code)
					code = "[between(0, new_code, max_code)]"

					if(code == r_code)
						yes_code = TRUE
						radiowarn( FALSE, FALSE)
					else
						code = "ERROR"
					return TRUE

		if("time")
			if(auth && yes_code)
				var/min_time = 10
				var/max_time = 30
				var/new_time = tgui_input_number(ui.user,"Enter minutes until detonation","Set Timer", 0, max_time, min_time)
				countdown_start_minutes = between(min_time, new_time, max_time) // different min timer( 10 min, 30 min )
				return TRUE

		if("timer")
			if(!has_timer() && auth && yes_code)
				start_timer(ui.user)
				return TRUE

		if("abort")
			if(has_timer())
				abort_timer()
				return TRUE

		if("safety")
			if(auth && yes_code)
				safety_toggle(ui.user)
				return TRUE

/obj/machinery/nuclearbomb/station/tgui_data(mob/user)
	// this is the data which will be sent to the ui
	var/list/data = list(
		"auth" = !isnull(auth),
		"code" = code,
		"yes_code" = yes_code,
		"safety" = safety,
		"timeleft" = get_compensating_time(),
		"timing" = has_timer(),
		"critical" = countdown_too_far_gone(),
		"start_minutes" = countdown_start_minutes
	)

	return data

/obj/machinery/nuclearbomb/station/explode()
	update_icon()
	if(!has_timer() || safety || !auth || !yes_code)
		abort_timer()
		return
	exploding = TRUE
	yes_code = 0
	safety = 1
	world << sound('sound/machines/Alarm.ogg') // force sound!
	if(ticker && SSticker.mode)
		SSticker.mode.explosion_in_progress = 1
	sleep(100)

	if(ticker)
		if(SSticker.mode && SSticker.mode.name == "Mercenary")
			SSticker.mode:syndies_didnt_escape = TRUE
			SSticker.mode:nuke_off_station = FALSE
		SSticker.station_explosion_cinematic(FALSE,null)
		if(SSticker.mode)
			SSticker.mode.explosion_in_progress = 0
			to_world("<B>The station was destroyed by the nuclear blast!</B>")

			SSticker.mode.station_was_nuked = FALSE
			if(!SSticker.mode.check_finished())//If the mode does not deal with the nuke going off so just reboot because everyone is stuck as is
				to_world("<B>Resetting in 30 seconds!</B>")

				feedback_set_details("end_error","nuke - unhandled ending")

				if(blackbox)
					blackbox.save_all_data_to_sql()
				sleep(300)
				log_game("Rebooting due to nuclear detonation")
				world.Reboot()
				return

/obj/machinery/nuclearbomb/station/proc/radiowarn( storageopened, tube_inserted )
	var/message = ""
	if(tube_inserted || yes_code)
		var/tubefailed = FALSE
		for(var/inserter in inserters)
			var/obj/machinery/self_destruct/sd = inserter
			if(!sd || !sd.armed)
				tubefailed = TRUE
				break
		if(!tubefailed && yes_code)
			if(warningstage < 3)
				warningstage = 3
				message = "DANGER! The Terraformer Euthanizer is now armed and ready to fire! Destroy any unauthorized usage of the Terraformer Euthanizer with extreme prejudice immediately! All non-security crew must retreat to minimum safe distance incase of detonation! This is a Delta-Level Hazard!"
				GLOB.global_announcer.autosay(message, "Primary System", CHANNEL_COMMAND)
				GLOB.global_announcer.autosay(message, "Primary System", CHANNEL_SECURITY)
				GLOB.global_announcer.autosay(message, "Primary System", CHANNEL_COMMON)

	if(yes_code)
		if(warningstage < 2)
			warningstage = 2
			message = "Warning! Terraformer Euthanizer has been armed, detonation is possible. If this is unauthorized, respond with all available force to stop the process immediately! E-Shui law prevents any usage of the Euthanizer that is not in compliance with SolGov Vs N.T. 443-72!"
			GLOB.global_announcer.autosay(message, "Primary System", CHANNEL_COMMAND)
			GLOB.global_announcer.autosay(message, "Primary System", CHANNEL_SECURITY)

	if(auth || storageopened)
		if(warningstage < 1)
			warningstage = 1
			message = "Warning! Utilization of the Terraformer Euthanizer detected. Respond with all available force to stop the process if this is unauthorized."
			GLOB.global_announcer.autosay(message, "Security Subsystem", CHANNEL_COMMAND)
