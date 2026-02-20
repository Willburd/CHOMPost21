#define NEEDLE_AMOUNT_CAP 20

/obj/machinery/needle_cleaner
	name = "needle cleaning centrifuge"
	desc = "Used to clean and recap needles."
	icon = 'modular_outpost/icons/obj/pandemic.dmi'
	icon_state = "pandemic0"
	circuit = /obj/item/circuitboard/needle_cleaner
	density = TRUE
	anchored = TRUE
	idle_power_usage = 20
	use_power = TRUE

/obj/machinery/needle_cleaner/examine(mob/user, infix, suffix)
	. = ..()
	var/needle_count = (length(contents)-1)
	if(needle_count == NEEDLE_AMOUNT_CAP)
		. += "It is full"
	else if(!needle_count)
		. += "It is empty"
	else
		. += "It has space for [NEEDLE_AMOUNT_CAP - needle_count] more."

/obj/machinery/needle_cleaner/attack_hand(mob/user)
	if(..())
		return
	if(stat & NOPOWER)
		return
	if(stat & BROKEN)
		return
	if(in_use)
		return
	add_fingerprint(user)

	var/needle_count = (length(contents)-1)
	if(needle_count == 0)
		to_chat(usr, span_warning("\The [src] is empty!"))
		return

	in_use = TRUE
	update_icon()
	playsound(src, 'sound/machines/buttonbeep.ogg', 50, 1)
	addtimer(CALLBACK(src, PROC_REF(finish_cleaning)), 10 SECONDS, TIMER_DELETE_ME)

/obj/machinery/needle_cleaner/attackby(obj/item/W, mob/user, attack_modifier, click_parameters)
	if(in_use)
		to_chat(usr, span_warning("\The [src] is currenty cleaning!"))
	if(istype(W,/obj/item/reagent_containers/syringe))
		var/needle_count = (length(contents)-1)
		if(needle_count < NEEDLE_AMOUNT_CAP)
			user.drop_from_inventory(W, src)
		return
	. = ..()

/obj/machinery/needle_cleaner/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject needles"

	if(usr.incapacitated())
		return
	if(in_use)
		to_chat(usr, span_warning("\The [src] is currenty cleaning!"))
		return

	add_fingerprint(usr)
	for(var/obj/item/reagent_containers/syringe/S in contents)
		S.forceMove(get_turf(src))
	update_icon()

/obj/machinery/needle_cleaner/proc/finish_cleaning()
	PRIVATE_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	in_use = FALSE
	for(var/obj/item/reagent_containers/syringe/S in contents)
		S.reagents.clear_reagents()
		S.sterilize()
		S.mode = initial(S.mode)
		S.update_icon()
		S.forceMove(get_turf(src))
	update_icon()
	playsound(src, 'sound/machines/ping.ogg', 30, TRUE)

/obj/machinery/needle_cleaner/update_icon()
	if(stat & BROKEN)
		icon_state = "pandemic[in_use]_b"
		return
	icon_state = "pandemic[in_use][!(stat & NOPOWER) ? "" : "_nopower"]"

#undef NEEDLE_AMOUNT_CAP
