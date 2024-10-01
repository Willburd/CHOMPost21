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

/obj/item/storage/box/solution_trays/New()
	..()
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )
	new /obj/item/reagent_containers/glass/solution_tray( src )

/obj/item/reagent_containers/glass/beaker/tungsten
	name = "beaker 'tungsten'"

/obj/item/reagent_containers/glass/beaker/tungsten/New()
	..()
	reagents.add_reagent("tungsten",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/oxygen
	name = "beaker 'oxygen'"

/obj/item/reagent_containers/glass/beaker/oxygen/New()
	..()
	reagents.add_reagent("oxygen",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/sodium
	name = "beaker 'sodium'"

/obj/item/reagent_containers/glass/beaker/sodium/New()
	..()
	reagents.add_reagent("sodium",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/lithium
	name = "beaker 'lithium'"

/obj/item/reagent_containers/glass/beaker/lithium/New()
	..()
	reagents.add_reagent("lithium",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/water
	name = "beaker 'water'"

/obj/item/reagent_containers/glass/beaker/water/New()
	..()
	reagents.add_reagent("water",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/water
	name = "beaker 'water'"

/obj/item/reagent_containers/glass/beaker/water/New()
	..()
	reagents.add_reagent("water",50)
	update_icon()

/obj/item/reagent_containers/glass/beaker/fuel
	name = "beaker 'fuel'"

/obj/item/reagent_containers/glass/beaker/fuel/New()
	..()
	reagents.add_reagent("fuel",50)
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
			user << "<span class='warning'>You must remove the [held_container] first.</span>"
		else
			user.drop_item(src)
			held_container = W
			held_container.loc = src
			user << "<span class='notice'>You put the [held_container] onto the [src].</span>"
			var/image/I = image("icon"=W, "layer"=FLOAT_LAYER)
			underlays += I
	else
		user << "<span class='warning'>You can't put the [W] onto the [src].</span>"

/obj/machinery/bunsen_burner/AltClick(var/mob/user)
	. = ..()
	toggle()

/obj/machinery/bunsen_burner/attack_ai()
    return

/obj/machinery/bunsen_burner/attack_hand(mob/user as mob)
	if(held_container)
		underlays = null
		user << "<span class='notice'>You remove the [held_container] from the [src].</span>"
		held_container.loc = src.loc
		held_container.attack_hand(user)
		held_container = null
	else
		user << "<span class='warning'>There is nothing on the [src].</span>"

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
