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

	var/announced = 0
	timeleft = 60.0 * 10 // default (10 mins)
	var/self_destruct_cutoff = 60 * 5 //Seconds (5 mins)

/obj/machinery/nuclearbomb/station/Initialize()
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

/obj/machinery/nuclearbomb/station/attackby(obj/item/O as obj, mob/user as mob)
	if(O.is_wrench())
		return

/obj/machinery/nuclearbomb/station/Destroy()
	flash_tiles.Cut()
	return ..()

/obj/machinery/nuclearbomb/station/process()
	if(timing)
		bomb_set = 1 //So long as there is one nuke timing, it means one nuke is armed.
		timeleft--
		if(timeleft <= self_destruct_cutoff && !announced)
			// minimum 1 min before no going back!
			priority_announcement.Announce("The self-destruct sequence has reached terminal countdown, abort systems have been disabled.", "Self-Destruct Control Computer")
			announced = 1
		if(timeleft <= 0)
			explode()
		for(var/mob/M in viewers(1, src))
			if((M.client && M.machine == src))
				attack_hand(M)
	return

/obj/machinery/nuclearbomb/station/update_icon()
	var/target_icon_state
	if(timing == -1)
		target_icon_state = "rcircuitanim"
		icon_state = "exploding"
	else if(timing)
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


/obj/machinery/nuclearbomb/station/attack_hand(mob/user as mob)
	if(!user.IsAdvancedToolUser())
		return

	user.set_machine(src)
	var/dat = text("<TT><B>Nuclear Fission Explosive</B><BR>\nAuth. Disk: <A href='byond://?src=\ref[];auth=1'>[]</A><HR>", src, (auth ? "++++++++++" : "----------"))
	if(auth)
		if(yes_code)
			dat += text("\n<B>Status</B>: []-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] <A href='byond://?src=\ref[];timer=1'>Toggle</A><BR>\nTime: <A href='byond://?src=\ref[];time=-10'>-</A> <A href='byond://?src=\ref[];time=-1'>-</A> [] <A href='byond://?src=\ref[];time=1'>+</A> <A href='byond://?src=\ref[];time=10'>+</A><BR>\n<BR>\nSafety: [] <A href='byond://?src=\ref[];safety=1'>Toggle</A><BR>\n", (timing ? "Func/Set" : "Functional"), (safety ? "Safe" : "Engaged"), timeleft, (timing ? "On" : "Off"), src, src, src, timeleft, src, src, (safety ? "On" : "Off"), src)
		else
			dat += text("\n<B>Status</B>: Auth. S2-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\n[] Safety: Toggle<BR>\n", (safety ? "Safe" : "Engaged"), timeleft, (timing ? "On" : "Off"), timeleft, (safety ? "On" : "Off"))
	else
		if(timing)
			dat += text("\n<B>Status</B>: Set-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\nSafety: [] Toggle<BR>\n", (safety ? "Safe" : "Engaged"), timeleft, (timing ? "On" : "Off"), timeleft, (safety ? "On" : "Off"))
		else
			dat += text("\n<B>Status</B>: Auth. S1-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\nSafety: [] Toggle<BR>\n", (safety ? "Safe" : "Engaged"), timeleft, (timing ? "On" : "Off"), timeleft, (safety ? "On" : "Off"))
	var/message = "AUTH"
	if(auth)
		message = text("[]", code)
		if(yes_code)
			message = "*****"
	dat += text("<HR>\n>[]<BR>\n<A href='byond://?src=\ref[];type=1'>1</A>-<A href='byond://?src=\ref[];type=2'>2</A>-<A href='byond://?src=\ref[];type=3'>3</A><BR>\n<A href='byond://?src=\ref[];type=4'>4</A>-<A href='byond://?src=\ref[];type=5'>5</A>-<A href='byond://?src=\ref[];type=6'>6</A><BR>\n<A href='byond://?src=\ref[];type=7'>7</A>-<A href='byond://?src=\ref[];type=8'>8</A>-<A href='byond://?src=\ref[];type=9'>9</A><BR>\n<A href='byond://?src=\ref[];type=R'>R</A>-<A href='byond://?src=\ref[];type=0'>0</A>-<A href='byond://?src=\ref[];type=E'>E</A><BR>\n</TT>", message, src, src, src, src, src, src, src, src, src, src, src, src)
	user << browse(dat, "window=nuclearbomb;size=300x400")
	onclose(user, "nuclearbomb")
	return

/obj/machinery/nuclearbomb/station/Topic(href, href_list)
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(timeleft <= self_destruct_cutoff)
		to_chat(usr, span_warning("The self-destruct sequence has reached terminal countdown, system has been disabled."))
		return
	if((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))))
		usr.set_machine(src)
		if(href_list["auth"])
			if(auth)
				auth.loc = src.loc
				yes_code = 0
				auth = null
			else
				var/obj/item/I = usr.get_active_hand()
				if(istype(I, /obj/item/disk/nuclear))
					usr.drop_item()
					I.loc = src
					auth = I
					radiowarn( FALSE, FALSE)
		if(auth)
			if(href_list["type"])
				if(href_list["type"] == "E")
					if(code == r_code)
						yes_code = 1
						radiowarn( FALSE, FALSE)
						code = null
					else
						code = "ERROR"
				else
					if(href_list["type"] == "R")
						yes_code = 0
						code = null
					else
						code += text("[]", href_list["type"])
						if(length(code) > 5)
							code = "ERROR"
			if(yes_code)
				if(href_list["time"])
					var/time = text2num(href_list["time"])
					timeleft += time
					timeleft = min(max(round(timeleft), 60 * 10), 60 * 30) // different min timer( 10 min, 30 min )
				if(href_list["timer"])
					if(timing == -1.0)
						return
					if(safety)
						to_chat(usr, span_warning("The safety is still on."))
						timing = FALSE
						return
					for(var/inserter in inserters)
						var/obj/machinery/self_destruct/sd = inserter
						if(!sd || !sd.armed)
							to_chat(usr, span_warning("An inserter has not been armed or is damaged."))
							timing = FALSE
							return
					timing = !(timing)
					if(timing)
						if(!safety)
							bomb_set = 1 //There can still be issues with this reseting when there are multiple bombs. Not a big deal tho for Nuke/N
							// notify station
							if(get_security_level() != "delta")
								priority_announcement.Announce("Self destruct sequence has been activated. Self-destructing in [timeleft] seconds.", "Self-Destruct Control Computer")
							set_security_level("delta")
							update_icon()
						else
							bomb_set = 0
							update_icon()
					else
						if(get_security_level() == "delta")
							priority_announcement.Announce("Self destruct sequence has been cancelled.", "Self-Destruct Control Computer")
						set_security_level("red")
						bomb_set = 0
						update_icon()
				if(href_list["safety"])
					if(!bomb_set)
						safety = !(safety)
						if(safety)
							timing = 0
							bomb_set = 0
						update_icon()
					else
						to_chat(usr, span_warning("Cannot enable safety, self destruct is armed."))

		add_fingerprint(usr)
		for(var/mob/M in viewers(1, src))
			if((M.client && M.machine == src))
				attack_hand(M)
	else
		usr << browse(null, "window=nuclearbomb")
		return
	return

/obj/machinery/nuclearbomb/station/explode()
	update_icon()
	if(safety)
		timing = 0
		return
	timing = -1.0
	yes_code = 0
	safety = 1
	world << sound('sound/machines/Alarm.ogg') // force sound!
	if(ticker && ticker.mode)
		ticker.mode.explosion_in_progress = 1
	sleep(100)

	if(ticker)
		if(ticker.mode && ticker.mode.name == "Mercenary")
			ticker.mode:syndies_didnt_escape = TRUE
			ticker.mode:nuke_off_station = FALSE
		ticker.station_explosion_cinematic(FALSE,null)
		if(ticker.mode)
			ticker.mode.explosion_in_progress = 0
			to_world("<B>The station was destoyed by the nuclear blast!</B>")

			ticker.mode.station_was_nuked = FALSE
			if(!ticker.mode.check_finished())//If the mode does not deal with the nuke going off so just reboot because everyone is stuck as is
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
				global_announcer.autosay(message, "Primary System", "Command")
				global_announcer.autosay(message, "Primary System", "Security")
				global_announcer.autosay(message, "Primary System", "Common")

	if(yes_code)
		if(warningstage < 2)
			warningstage = 2
			message = "Warning! Terraformer Euthanizer has been armed, detonation is possible. If this is unauthorized, respond with all available force to stop the process immediately! E-Shui law prevents any usage of the Euthanizer that is not in compliance with SolGov Vs N.T. 443-72!"
			global_announcer.autosay(message, "Primary System", "Command")
			global_announcer.autosay(message, "Primary System", "Security")

	if(auth || storageopened)
		if(warningstage < 1)
			warningstage = 1
			message = "Warning! Utilization of the Terraformer Euthanizer detected. Respond with all available force to stop the process if this is unauthorized."
			global_announcer.autosay(message, "Security Subsystem", "Command")
