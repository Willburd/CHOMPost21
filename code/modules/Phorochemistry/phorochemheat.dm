//chemistry stuff here so that it can be easily viewed/modified

/obj/item/reagent_containers/glass/solution_tray
	name = "solution tray"
	desc = "A small, open-topped glass container for delicate research samples. It sports a re-useable strip for labelling with a pen."
	icon = 'icons/obj/device.dmi'
	icon_state = "solution_tray"
	matter = list(MAT_GLASS = 5)
	w_class = 2.0
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 2)
	volume = 2
	flags = OPENCONTAINER
	unacidable = 1

/obj/item/storage/box/solution_trays
	name = "solution tray box"
	icon_state = "solution_trays"

/obj/item/storage/box/solution_trays/Initialize(mapload)
	. = ..()
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )

/obj/item/reagent_containers/glass/beaker/tungsten
	name = "beaker '" + REAGENT_ID_TUNGSTEN + "'"

/obj/item/reagent_containers/glass/beaker/tungsten/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_TUNGSTEN,50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/oxygen
	name = "beaker '" + REAGENT_ID_OXYGEN + "'"

/obj/item/reagent_containers/glass/beaker/oxygen/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_OXYGEN,50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/sodium
	name = "beaker '" + REAGENT_ID_SODIUM + "'"

/obj/item/reagent_containers/glass/beaker/sodium/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_SODIUM,50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/lithium
	name = "beaker '" + REAGENT_ID_LITHIUM + "'"

/obj/item/reagent_containers/glass/beaker/lithium/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_LITHIUM,50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/water
	name = "beaker '" + REAGENT_ID_WATER + "'"

/obj/item/reagent_containers/glass/beaker/water/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_WATER,50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/fuel
	name = "beaker '" + REAGENT_ID_FUEL + "'"

/obj/item/reagent_containers/glass/beaker/fuel/Initialize(mapload)
	. = ..()
	reagents.add_reagent(REAGENT_ID_FUEL,50)
	update_icon()


/obj/machinery/bunsen_burner
	name = "bunsen burner"
	desc = "A flat, self-heating device designed for bringing chemical mixtures to boil."
	icon = 'icons/obj/device.dmi'
	icon_state = "bunsen0"
	var/heating = 0		//whether the bunsen is turned on
	var/obj/item/reagent_containers/held_container
	var/heat_time = 15
	var/current_temp = T0C

/obj/machinery/bunsen_burner/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/reagent_containers))
		if(held_container)
			user << span_warning("You must remove the [held_container] first.")
		else
			user.drop_item(src)
			held_container = W
			held_container.loc = src
			user << span_notice("You put the [held_container] onto the [src].")
			var/image/I = image("icon"=W, "layer"=FLOAT_LAYER)
			underlays += I
	else
		user << span_warning("You can't put the [W] onto the [src].")

/obj/machinery/bunsen_burner/AltClick(var/mob/user)
	. = ..()
	toggle()

/obj/machinery/bunsen_burner/attack_ai()
	return

/obj/machinery/bunsen_burner/attack_hand(mob/user as mob)
	if(held_container)
		underlays = null
		user << span_notice("You remove the [held_container] from the [src].")
		held_container.loc = src.loc
		held_container.attack_hand(user)
		held_container = null
	else
		user << span_warning("There is nothing on the [src].")

/*
/obj/machinery/bunsen_burner/proc/try_heating()
	src.visible_message(span_notice(" icon[src] [src] hisses."))
	if(held_container && heating)
		heated = 1
		held_container.reagents.handle_reactions()
		heated = 0
		spawn(heat_time)
			try_heating()
*/

/obj/machinery/bunsen_burner/verb/toggle()
	set src in view(1)
	set name = "Toggle bunsen burner"
	set category = "IC.Game" //CHOMPEdit

	heating = !heating

	var/datum/gas_mixture/GM = return_air()
	if(GM)
		current_temp = GM.temperature // Reset gas on start
	else
		current_temp = T0C
	update_icon()

/obj/machinery/bunsen_burner/process()
	if(heating)
		if(held_container == null || held_container.reagents == null || held_container.reagents.reagent_list.len <= 0)
			src.visible_message("<span class='danger'>\The [src] clicks.</span>")
			heating = FALSE
			update_icon()
			return

		if((current_temp - T0C) % 25 == 0) // every 25 degree step
			if(current_temp < T0C + 50)
				src.visible_message("<span class='notice'>\The [src] sloshes.</span>")
			else if(current_temp <  T0C + 100)
				src.visible_message("<span class='notice'>\The [src] hisses.</span>")
			else if(current_temp <  T0C + 200)
				src.visible_message("<span class='notice'>\The [src] boils.</span>")
			else if(current_temp <  T0C + 400)
				src.visible_message("<span class='notice'>\The [src] bubbles aggressively.</span>")
			else if(current_temp <  T0C + 600)
				src.visible_message("<span class='warning'>\The [src] violently shakes.</span>")
			else
				src.visible_message("<span class='danger'>\The [src] clicks.</span>")
				heating = FALSE
				update_icon()
				return

		held_container.reagents.handle_distilling()

		// Increase temp till ended by 5 degrees
		current_temp += 10

/obj/machinery/bunsen_burner/update_icon()
	icon_state = "bunsen[heating]"
