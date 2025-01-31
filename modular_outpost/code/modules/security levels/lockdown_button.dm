/obj/machinery/lockdown_console
	name = "Lockdown Control Console"
	desc = "This device is used to control various lockdown shutters across the station."
	icon = 'modular_outpost/icons/obj/monitors.dmi'
	icon_state = "lockdown"
	layer = ABOVE_WINDOW_LAYER
	circuit = /obj/item/circuitboard/lockdown_console
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 6
	power_channel = ENVIRON
	VAR_PRIVATE/unlocked = FALSE
	VAR_PRIVATE/list/linked_lockdowns = list("Example Name" = "blast_tag")
	VAR_PRIVATE/list/linked_jokes = list("Example Name" = "Joke here.")

/obj/machinery/lockdown_console/attack_ai(mob/user as mob)
	attack_hand(user)
	return

/obj/machinery/lockdown_console/attackby(obj/item/W as obj, mob/user as mob)
	if(stat & (NOPOWER|BROKEN))
		to_chat(user, "This device is not powered.")
		return
	if(istype(W,/obj/item/card/id))
		var/obj/item/card/id/ID = W
		if(access_keycard_auth in ID.access)
			unlocked = !unlocked
			updateUsrDialog()
		else
			// Nope!
			to_chat(user, "<span class='warning'>Access denied.</span>")
			flick("lockdown_reject",src)

	if(W.is_screwdriver())
		to_chat(user, "You begin removing the faceplate from the [src]")
		playsound(src, W.usesound, 50, 1)
		if(do_after(user, 10 * W.toolspeed))
			to_chat(user, "You remove the faceplate from the [src]")
			var/obj/structure/frame/A = new /obj/structure/frame(loc)
			var/obj/item/circuitboard/M = new circuit(A)
			A.frame_type = M.board_type
			A.need_circuit = 0
			A.pixel_x = pixel_x
			A.pixel_y = pixel_y
			A.set_dir(dir)
			A.circuit = M
			A.anchored = TRUE
			for (var/obj/C in src)
				C.forceMove(loc)
			A.state = 3
			A.update_icon()
			M.deconstruct(src)
			qdel(src)
			return

/obj/machinery/lockdown_console/power_change()
	..()
	if(stat &NOPOWER)
		icon_state = "lockdown_off"
	else
		icon_state = "lockdown"

/obj/machinery/lockdown_console/attack_hand(mob/user as mob)
	if(!Adjacent(usr) && !isAI(usr))
		return
	if(user.stat || stat & (NOPOWER|BROKEN))
		to_chat(user, "This device is not powered.")
		return
	if(!user.IsAdvancedToolUser())
		return 0

	user.set_machine(src)

	var/dat = "<h1>Lockdown Control Console</h1>"
	if(!unlocked && !isAI(user) && !issilicon(user))
		dat += "Swipe ID card to unlock."
		dat += "<br><hr><br>"
	else
		if(!isAI(user) && !issilicon(user))
			dat += "Swipe ID card to lock."
		else
			dat += "AI ACCESS MODE."
		dat += "<br><hr><br>"
		dat += "Select an lockdown to trigger:<ul>"
		for(var/link in linked_lockdowns)
			dat += "<li><A href='byond://?src=\ref[src];triggerevent=[link]' title='[linked_jokes[link]]'>[link]</A></li>"
		dat += "</ul>"
	user << browse(dat, "window=lockdown_console;size=500x250")
	return

/obj/machinery/lockdown_console/Topic(href, href_list)
	..()
	if(!Adjacent(usr) && !isAI(usr) && !issilicon(usr))
		return
	if(usr.stat || stat & (BROKEN|NOPOWER))
		to_chat(usr, "This device is without power.")
		return

	playsound(src, 'sound/machines/button.ogg', 100, 1)
	if(!unlocked && !isAI(usr) && !issilicon(usr))
		to_chat(usr, "<span class='warning'>Access denied.</span>")
		flick("lockdown_reject",src)
		return
	if(href_list["triggerevent"])
		trigger_event(href_list["triggerevent"])

	updateUsrDialog()
	add_fingerprint(usr)
	return

/obj/machinery/lockdown_console/proc/trigger_event(var/event)
	PRIVATE_PROC(TRUE)
	var/counter = 0
	for(var/link in linked_lockdowns)
		counter += 1
		if(counter >= 19) // clamp with number of icon's buttons
			counter = 1
		if(link == event)
			use_power(5)
			var/obj/machinery/door/blast/last_door = null
			flick("lockdown_[counter]",src)
			var/id_door = linked_lockdowns[link]
			var/is_operating = FALSE
			for(var/obj/machinery/door/blast/M in machines)
				if(M.id == id_door)
					last_door = M
					if(M.operating)
						is_operating = TRUE
					if(M.density)
						spawn(0)
							M.open()
							return
					else
						spawn(0)
							M.close()
							return
			// Feedback
			spawn(1)
				if(is_operating)
					to_chat(usr, "<span class='warning'>[event] still cycling... Please wait.</span>")
				else if(last_door.density)
					to_chat(usr, "<span class='warning'>[event] locked down.</span>")
				else
					to_chat(usr, "<span class='warning'>[event] unlocked.</span>")
			return
