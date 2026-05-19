/*
 *	Airtunnel -- the airtunnel computer
 *				 Controls extention and retraction of the tunnel, and regulation of the atmosphere in it.
 *
 */

/obj/machinery/computer/airtunnel
	name = "Air Tunnel Control"
	var/area/airtunnel/current_controller = null

/obj/machinery/computer/airtunnel/Initialize(mapload)
	. = ..()
	current_controller = get_area(src)

/obj/machinery/computer/airtunnel/Destroy()
	current_controller = null
	. = ..()

/// Update icon_state depending on computer and airtunnel status
/obj/machinery/computer/airtunnel/proc/update_icon()
	if(stat & BROKEN)
		icon_state = "broken"
		return

	if(stat & NOPOWER)
		icon_state = "c_unpowered"
		return

	var/status = 0
	if (current_controller.operating == 1)
		status = "r"
	else if (current_controller.operating == 2)
		status = "e"
	else
		var/obj/structure/airtunnel/connector/C = pick(current_controller.connectors)

		if (C.current == C)
			status = 0
		else if (!( C.current.next ))
			status = 2
		else
			status = 1

	icon_state = "console[current_controller.siphon_status >= 2 ? "1" : "0"][status]"

// Update the icon, use power, and update interaction window for viewers
/obj/machinery/computer/airtunnel/process()
	update_icon()
	if(stat & (NOPOWER|BROKEN) )
		return
	use_power(250)

// Monkey interct same as human
/obj/machinery/computer/airtunnel/attack_paw(mob/user)
	return attack_hand(user)

// AI interact
/obj/machinery/computer/airtunnel/attack_ai(mob/user)
	return attack_hand(user)

// Human interact
// Show airtunnel status and interaction window
/obj/machinery/computer/airtunnel/attack_hand(mob/user)
	if(stat & (NOPOWER|BROKEN) )
		return

	var/dat = "<HTML><BODY><TT><B>Air Tunnel Controls</B><BR>"
	if (current_controller.operating == 1)
		dat += "<B>Status:</B> RETRACTING<BR>"

	else  if (current_controller.operating == 2)
		dat += "<B>Status:</B> EXPANDING<BR>"

	else
		var/obj/structure/airtunnel/connector/C = pick(current_controller.connectors)

		if (C.current == C)
			dat += "<B>Status:</B> Fully Retracted<BR>"
		else if (!( C.current.next ))
			dat += "<B>Status:</B> Fully Extended<BR>"
		else
			dat += "<B>Status:</B> Stopped Midway<BR>"

	dat += "<A href='?src=\ref[src];retract=1'>Retract</A> <A href='?src=\ref[src];stop=1'>Stop</A> <A href='?src=\ref[src];extend=1'>Extend</A><BR>"
	dat += "<BR><B>Air Level:</B> [(current_controller.air_stat ? "Acceptable" : "DANGEROUS")]<BR>"
	dat += "<B>Air System Status:</B> "

	switch(current_controller.siphon_status)
		if(0.0)
			dat += "Stopped "
		if(1.0)
			dat += "Siphoning (Siphons only) "
		if(2.0)
			dat += "Regulating (BOTH) "
		if(3.0)
			dat += "RELEASING MAX (Siphons only) "

	dat += "<A href='?src=\ref[src];refresh=1'>(Refresh)</A><BR>"
	dat += "<A href='?src=\ref[src];release=1'>RELEASE (Siphons only)</A> <A href='?src=\ref[src];siphon=1'>Siphon (Siphons only)</A> <A href='?src=\ref[src];stop_siph=1'>Stop</A> <A href='?src=\ref[src];auto=1'>Regulate</A><BR>"
	dat += "<BR><BR><A href='?src=\ref[user];mach_close=computer'>Close</A></TT></BODY></HTML>"

	user.client_mob() << browse(dat, "window=computer;size=400x500")


// Handle topic links from interaction window
// Control the airtunnel through the global datum
/obj/machinery/computer/airtunnel/Topic(href, href_list)
	..()

	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		if (!istype(usr, /mob/ai))
			if (!istype(usr, /mob/drone))
				usr.client_mob() << "\red You don't have the dexterity to do this!"
				return
	if ((usr.stat || usr.restrained()))
		if (!istype(usr, /mob/ai))
			return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(loc, /turf)) || (istype(usr, /mob/ai))))
		usr.machine = src

		if (href_list["retract"])
			current_controller.retract()
		else if (href_list["stop"])
			current_controller.operating = 0
		else if (href_list["extend"])
			current_controller.extend()
		else if (href_list["release"])
			current_controller.siphon_status = 3
			current_controller.siphons()
		else if (href_list["siphon"])
			current_controller.siphon_status = 1
			current_controller.siphons()
		else if (href_list["stop_siph"])
			current_controller.siphon_status = 0
			current_controller.siphons()
		else if (href_list["auto"])
			current_controller.siphon_status = 2
			current_controller.siphons()
		else if (href_list["refresh"])
			current_controller.siphons()

		add_fingerprint(usr)
