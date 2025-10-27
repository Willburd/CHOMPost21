////////////////////////////////////////////////////////////////////////////////
// View consoles

/obj/machinery/computer/vehicle_interior_console
	name = "Vehicle Console"
	desc = "Exterior camera console."

	icon_keyboard = "security_key"
	icon_screen = "cameras"
	light_color = "#a91515"
	circuit = /obj/item/circuitboard/security

	VAR_PRIVATE/list/viewers // Weakrefs to mobs in direct-view mode.
	var/obj/vehicle/has_interior/controller/interior_controller = null
	var/obj/structure/bed/chair/vehicle_interior_seat/paired_seat = null
	var/controls_weapon_index = 0 // if above 0, controls weapons in interior_controller.internal_weapon_list

/obj/machinery/computer/vehicle_interior_console/Destroy()
	SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)
	return ..()

/obj/machinery/computer/vehicle_interior_console/tgui_interact(mob/user, datum/tgui/ui = null)
	// nothing

/obj/machinery/computer/vehicle_interior_console/attack_ai(mob/user)
	to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")

/obj/machinery/computer/vehicle_interior_console/attack_robot(mob/user)
	attack_hand(user)

/obj/machinery/computer/vehicle_interior_console/attack_generic(mob/user)
	attack_hand(user)

/obj/machinery/computer/vehicle_interior_console/attack_hand(mob/user)
	add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return
	if(!interior_controller)
		to_chat(user, span_danger("Something is very wrong! Inform a coder that the vehicle you were in was deleted!"))
		return
	if(isrobot(user) || isAI(user))
		to_chat(user, span_warning("A firewall prevents you from interfacing with this device!"))
		return
	// remove all others...
	if(is_viewing_tank())
		SEND_SIGNAL(src,COMSIG_REMOTE_VIEW_CLEAR)
		return
	if(interior_controller.health <= 0)
		to_chat(user, span_notice("It's not functional!"))
		return
	if(check_eye(user) < 0)
		return
	// EXPECTS you to be in the pilot seat!
	if(!paired_seat || !paired_seat.has_buckled_mobs() || paired_seat.buckled_mobs[1] != user)
		to_chat(user, span_notice("You need to buckle into the seat to use this console!"))
		return
	// Start view
	playsound(src, "keyboard", 40) // into console
	if(!viewers) viewers = list() // List must exist for pass by reference to work
	start_coordinated_remoteview(user, interior_controller, viewers)

/obj/machinery/computer/vehicle_interior_console/look(var/mob/user)
	if(!interior_controller)
		return
	if(!user.check_current_machine(src))
		user.set_machine(src)
	user.set_viewsize(world.view + interior_controller.extra_view)
	if(isliving(user))
		var/mob/living/L = user
		L.handle_vision()

/obj/machinery/computer/vehicle_interior_console/unlook(var/mob/user)
	interior_controller.stop_move_sound()
	user.unset_machine()
	user.set_viewsize() // reset to default
	if(isliving(user))
		var/mob/living/L = user
		L.handle_vision()

/obj/machinery/computer/vehicle_interior_console/check_eye(var/mob/user)
	if(!get_dist(user, src) > 1 || user.blinded || !interior_controller)
		user.reset_perspective()
		return -1
	else
		return 0

/obj/machinery/computer/vehicle_interior_console/proc/is_viewing_tank()
	return LAZYLEN(viewers)

/obj/machinery/computer/vehicle_interior_console/ex_act(severity)
	return // nothing

/obj/machinery/computer/vehicle_interior_console/computer/update_icon()
	if(!interior_controller.on)
		// power off in vehicle
		cut_overlays()
		if(icon_keyboard)
			return add_overlay("[icon_keyboard]_off")
	else
		. = ..()

////////////////////////////////////////////////////////////////////////////////
// Pilot console

/obj/machinery/computer/vehicle_interior_console/helm
	name = "Vehicle Helm"
	desc = "Use ctrl-click to quickly toggle the engine if you're adjacent (only when vehicle is stationary). Alt-click will grab the keys, if present."

/obj/machinery/computer/vehicle_interior_console/helm/examine(mob/user)
	. = ..()
	if(ishuman(user) && Adjacent(user))
		. += "The power light is [interior_controller.on ? "on" : "off"].\nThere are[interior_controller.key ? "" : " no"] keys in the ignition."
		. += "The charge meter reads [interior_controller.cell? round(interior_controller.cell.percent(), 0.01) : 0]%"

/obj/machinery/computer/vehicle_interior_console/helm/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, interior_controller.key_type))
		if(!interior_controller.key)
			user.drop_item()
			W.forceMove(src)
			interior_controller.key = W
			verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key
		return
	..()

/obj/machinery/computer/vehicle_interior_console/helm/CtrlClick(var/mob/user)
	// helm expects pilot seat
	if(Adjacent(user))
		if(interior_controller.on)
			stop_engine()
		else
			start_engine()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/helm/AltClick(var/mob/user)
	// helm expects pilot seat
	if(Adjacent(user))
		remove_key()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/helm/verb/start_engine()
	set name = "Start engine"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(interior_controller.on)
		to_chat(usr, "The engine is already running.")
		return

	interior_controller.remote_turn_on()
	if (interior_controller.on)
		to_chat(usr, "You start [interior_controller]'s engine.")
	else
		if(!interior_controller.cell)
			to_chat(usr, "[interior_controller] doesn't appear to have a power cell!")
		else if(interior_controller.cell.charge < interior_controller.charge_use)
			to_chat(usr, "[interior_controller] is out of power.")
		else
			to_chat(usr, "[interior_controller]'s engine won't start.")

/obj/machinery/computer/vehicle_interior_console/helm/verb/stop_engine()
	set name = "Stop engine"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(!interior_controller.on)
		to_chat(usr, "The engine is already stopped.")
		return

	interior_controller.remote_turn_off()
	if (!interior_controller.on)
		to_chat(usr, "You stop [interior_controller]'s engine.")

/obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key()
	set name = "Remove key"
	set category = "Object.Vehicle"
	set src in oview(1)

	if(!interior_controller.key)
		return

	if(interior_controller.on)
		interior_controller.remote_turn_off()

	interior_controller.key.loc = usr.loc
	if(!usr.get_active_hand())
		usr.put_in_hands(interior_controller.key)
	interior_controller.key = null

	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/remove_key

/obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on()
	set name = "Headlights on"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.headlights_enabled = TRUE
	playsound(src, "switch", 40)

	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off

/obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off()
	set name = "Headlights off"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.headlights_enabled = FALSE
	playsound(src, "switch", 40)

	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_on
	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/headlights_off


/obj/machinery/computer/vehicle_interior_console/helm/verb/lock_interior()
	set name = "Lock hatch"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.entrance_hatch.lock()
	playsound(src, "switch", 40)

	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/lock_interior
	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/unlock_interior

/obj/machinery/computer/vehicle_interior_console/helm/verb/unlock_interior()
	set name = "Unlock hatch"
	set category = "Object.Vehicle"
	set src in oview(1)

	interior_controller.entrance_hatch.unlock()
	playsound(src, "switch", 40)

	verbs += /obj/machinery/computer/vehicle_interior_console/helm/verb/lock_interior
	verbs -= /obj/machinery/computer/vehicle_interior_console/helm/verb/unlock_interior

////////////////////////////////////////////////////////////////////////////////
// Gunner console

/obj/machinery/computer/vehicle_interior_console/gunner
	name = "Gunner Periscope"
	desc = "Targeting cameras for onboard weaponry."
