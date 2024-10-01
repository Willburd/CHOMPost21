/obj/machinery/nuke_cylinder_dispenser
	name = "nuclear cylinder storage"
	desc = "It's a secure, armored storage unit embedded into the floor for storing the nuclear cylinders."
	icon = 'icons/obj/machines/self_destruct.dmi'
	icon_state = "base"
	anchored = TRUE
	density = FALSE
	req_access = list(access_heads_vault)

	var/locked = TRUE
	var/open = FALSE

/obj/machinery/nuke_cylinder_dispenser/Initialize()
	. = ..()
	for(var/i in 1 to 6)
		new /obj/item/nuclear_cylinder(src)
	update_icon()

/obj/machinery/nuke_cylinder_dispenser/emag_act(var/remaining_charges, var/mob/user)
	to_chat(user, SPAN_NOTICE("The card fails to do anything. It seems this device has an advanced encryption system."))
	return 0

/obj/machinery/nuke_cylinder_dispenser/attack_hand(mob/user as mob)
	if(powered() && locked && check_access(user))
		locked = FALSE
		user.visible_message("[user] unlocks \the [src].", "You unlock \the [src].")
		update_icon()
		add_fingerprint(user)
		return TRUE
	if(!locked)
		open = !open
		user.visible_message("[user] [open ? "opens" : "closes"] \the [src].", "You [open ? "open" : "close"] \the [src].")
		update_icon()
		add_fingerprint(user)
	return TRUE

/obj/machinery/nuke_cylinder_dispenser/attackby(obj/item/O, mob/user)
	if(!open && powered() && istype(O,/obj/item/card/id))
		var/obj/item/card/id/id = O
		if(check_access(id))
			locked = !locked
			if(!locked)
				var/obj/machinery/nuclearbomb/station/computer = locate(/obj/machinery/nuclearbomb/station) in get_area(src)
				computer.radiowarn( TRUE, FALSE )
			user.visible_message("[user] [locked ? "locks" : "unlocks"] \the [src].", "You [locked ? "lock" : "unlock"] \the [src].")
			update_icon()
		else
			to_chat(user, SPAN_WARNING("Access denied."))
		return
	if(open && istype(O, /obj/item/nuclear_cylinder) && (contents.len < 6))
		user.visible_message("[user] begins inserting \the [O] into storage.", "You begin inserting \the [O] into storage.")
		if(do_after(user, 80, src) && open && (contents.len < 6) && user.unEquip(O, src))
			user.visible_message("[user] places \the [O] into storage.", "You place \the [O] into storage.")
			O.forceMove(src)
			update_icon()
		add_fingerprint(user)

/obj/machinery/nuke_cylinder_dispenser/MouseDrop(atom/over)
	if(!CanMouseDrop(over, usr))
		return
	if(over == usr && open && contents.len)
		var/obj/item/nuclear_cylinder/C = (locate() in contents)
		usr.visible_message("[usr] begins to extract \the [C].", "You begin to extract \the [C].")
		if(do_after(usr, 70, src) && open && contents.len)
			usr.visible_message("[usr] picks up \the [C].", "You pick up \the [C].")

			usr.put_in_hands(C)
			update_icon()
		add_fingerprint(usr)

/obj/machinery/nuke_cylinder_dispenser/update_icon()
	overlays.Cut()
	if(contents.len)
		overlays += "rods_[contents.len]"
	if(!open)
		overlays += "hatch"
	if(powered())
		if(locked)
			overlays += "red_light"
		else
			overlays += "green_light"



/obj/machinery/self_destruct
	name = "\improper Nuclear Cylinder Inserter"
	desc = "A hollow space used to insert nuclear cylinders for arming the self destruct."
	icon = 'icons/obj/machines/self_destruct.dmi'
	icon_state = "empty"
	density = FALSE
	anchored = TRUE
	var/obj/item/nuclear_cylinder/cylinder
	var/armed = 0
	var/damaged = 0

/obj/machinery/self_destruct/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weldingtool))
		if(damaged)
			user.visible_message("[user] begins to repair [src].", "You begin repairing [src].")
			if(do_after(usr, 100, src))
				var/obj/item/weldingtool/W = I
				if(W.remove_fuel(10,user))
					damaged = 0
					user.visible_message("[user] repairs [src].", "You repair [src].")
				return
	if(istype(I, /obj/item/nuclear_cylinder))
		if(damaged)
			to_chat(user, "<span class='warning'>[src] is damaged, you cannot place the cylinder.</span>")
			return
		if(cylinder)
			to_chat(user, "There is already a cylinder here.")
			return
		user.visible_message("[user] begins to carefully place [I] onto the Inserter.", "You begin to carefully place [I] onto the Inserter.")
		if(do_after(user, 80, src) && user.unEquip(I, src))
			cylinder = I
			cylinder.loc = src
			set_density(TRUE)
			user.visible_message("[user] places [I] onto the Inserter.", "You place [I] onto the Inserter.")
			playsound(src.loc, "sound/machines/vending/vending_drop.ogg", 50, 1, 5)
			update_icon()
			return
	..()

/obj/machinery/self_destruct/attack_hand(mob/user as mob)
	if(cylinder)
		. = TRUE
		if(armed)
			if(damaged)
				to_chat(user, "<span class='warning'>The inserter has been damaged, unable to disarm.</span>")
				return
			var/obj/machinery/nuclearbomb/nuke = locate(/obj/machinery/nuclearbomb/station) in get_area(src)
			if(!nuke)
				to_chat(user, "<span class='warning'>Unable to interface with the self destruct terminal, unable to disarm.</span>")
				return
			if(nuke.timing)
				to_chat(user, "<span class='warning'>The self destruct sequence is in progress, unable to disarm.</span>")
				return
			user.visible_message("[user] begins extracting [cylinder].", "You begin extracting [cylinder].")
			if(do_after(user, 40, src))
				if(!nuke.timing)
					user.visible_message("[user] extracts [cylinder].", "You extract [cylinder].")
					armed = 0
					set_density(TRUE)
					flick("unloading", src)
				else
					to_chat(user, "<span class='warning'>The self destruct sequence is in progress, unable to disarm.</span>")
					return
		else if(!damaged)
			user.visible_message("[user] begins to arm [cylinder].", "You begin to arm [cylinder].")
			if(do_after(user, 40, src))
				armed = 1
				set_density(FALSE)
				user.visible_message("[user] arms [cylinder].", "You arm [cylinder].")
				flick("loading", src)
				playsound(src.loc,'modular_outpost/sound/effects/caution.ogg',50,1,5)
				var/obj/machinery/nuclearbomb/station/computer = locate(/obj/machinery/nuclearbomb/station) in get_area(src)
				computer.radiowarn( FALSE, TRUE )
		update_icon()
		src.add_fingerprint(user)

/obj/machinery/self_destruct/MouseDrop(atom/over)
	if(!CanMouseDrop(over, usr))
		return
	if(over == usr && cylinder)
		if(armed)
			to_chat(usr, "Disarm the cylinder first.")
		else
			usr.visible_message("[usr] beings to carefully pick up [cylinder].", "You begin to carefully pick up [cylinder].")
			if(do_after(usr, 70, src))
				usr.put_in_hands(cylinder)
				usr.visible_message("[usr] picks up [cylinder].", "You pick up [cylinder].")
				set_density(FALSE)
				cylinder = null
		update_icon()
		src.add_fingerprint(usr)
	..()

/obj/machinery/self_destruct/ex_act(severity)
	switch(severity)
		if(1)
			set_damaged()
		if(2)
			if(prob(50))
				set_damaged()
		if(3)
			if(prob(25))
				set_damaged()

/obj/machinery/self_destruct/proc/set_damaged()
		src.visible_message("<span class='warning'>[src] dents and chars.</span>")
		damaged = 1

/obj/machinery/self_destruct/examine(mob/user)
	. = ..()
	if(damaged)
		to_chat(user, "<span class='warning'>[src] is damaged, it needs repairs.</span>")
		return
	if(armed)
		to_chat(user, "[src] is armed and ready.")
		return
	if(cylinder)
		to_chat(user, "[src] is loaded and ready to be armed.")

/obj/machinery/self_destruct/update_icon()
	if(armed)
		icon_state = "armed"
	else if(cylinder)
		icon_state = "loaded"
	else
		icon_state = "empty"
