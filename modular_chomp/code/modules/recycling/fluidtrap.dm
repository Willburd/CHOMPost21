/obj/structure/garbage/fluidtrap
	//icon = 'modular_chomp/icons/obj/machines/other.dmi'
	//icon_state = "cronchy_off"

	icon = 'icons/obj/machines/reagent.dmi'
	icon_state = "distiller"

	name = "fluid trap"
	desc = "A storage trap that is fed by a garbage grinder. It usually contains a horrible concoction of liquid garbage."
	plane = TURF_PLANE
	layer = ABOVE_TURF_LAYER
	anchored = TRUE
	density = TRUE
	var/base_state	// The string var used in update icon for overlays, either set manually or initialized.

	var/obj/item/weapon/reagent_containers/stored_container = null

/obj/structure/garbage/fluidtrap/Initialize()
	. = ..()

	create_reagents(5000)

	if(!base_state)
		base_state = icon_state

	update_icon()

	// Link to garbage grinder
	var/obj/machinery/v_garbosystem/G = locate(/obj/machinery/v_garbosystem) in loc.contents
	if(!G)
		for(var/dir in cardinal)
			G = locate(/obj/machinery/v_garbosystem, get_step(src, dir))
			if(G)
				break
	if(G)
		G.sump = src

/obj/structure/garbage/fluidtrap/proc/reagent_feed(var/datum/reagents/reg,var/multiplier)
	var/volume_magic = reg.total_volume * multiplier
	volume_magic -= rand(2,10) // reagent tax
	if(volume_magic > 0)
		reg.trans_to_holder( reagents, volume_magic)
		make_sludge(rand(1,5))
		if(prob(10))
			visible_message("\The [src] gurgles.")

/obj/structure/garbage/fluidtrap/proc/make_sludge(var/amt)
	if(prob(10) || amt >= 5)
		reagents.add_reagent("toxin",amt)

/obj/structure/garbage/fluidtrap/proc/make_biojunk(var/amt)
	var/ratioA = FLOOR(amt*0.2,1)
	var/ratioB = FLOOR(amt*0.8,1)
	if(ratioA > 0)
		reagents.add_reagent("protein", ratioA)
	if(ratioB > 0)
		reagents.add_reagent("triglyceride", ratioB)

/obj/structure/garbage/fluidtrap/attackby(obj/item/O, mob/user)
	. = ..()
	if(istype(O,/obj/item/weapon/reagent_containers))
		stored_container = O
		user.drop_from_inventory(O,src)
		visible_message("\The [user] loads \the [O] into \the [src].")
		return

/obj/structure/garbage/fluidtrap/attack_hand(mob/user)
	unload_container()
	. = ..()

/obj/structure/garbage/fluidtrap/AltClick(mob/user)
	fill_container()

/obj/structure/garbage/fluidtrap/verb/unload_container()
	set name = "Unload Container"
	set category = "Object"
	set src in view(1)

	if(stored_container)
		visible_message("\The [usr] removes \the [stored_container] from \the [src].")
		stored_container.forceMove(loc) // drop it outside even if user fails to pick it up
		stored_container.attack_hand(usr) // Attempt pickup
		stored_container = null
		return

/obj/structure/garbage/fluidtrap/verb/fill_container()
	set name = "Fill Loaded Container"
	set category = "Object"
	set src in view(1)

	if(!stored_container)
		to_chat(usr,"No container loaded.")
		return
	if(reagents.total_volume <= 0)
		to_chat(usr,"\The [src] is empty.")
		return
	if(stored_container.reagents.total_volume >= stored_container.reagents.maximum_volume)
		to_chat(usr,"\The [stored_container] is full.")
		return
	// Worst coffee machine on Muriki
	playsound(src, 'sound/machines/reagent_dispense.ogg', 25, 1)
	to_chat(usr,"You drain \the [src] into the loaded [stored_container].")
	reagents.trans_to_holder( stored_container.reagents, stored_container.reagents.maximum_volume)

/obj/structure/garbage/fluidtrap/examine(mob/user, infix, suffix)
	. = ..()
	. += "The meter shows [FLOOR((reagents.total_volume / reagents.maximum_volume) * 100,1)]% full."
