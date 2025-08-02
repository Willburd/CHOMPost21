/obj/machinery/bunsen_burner
	name = "bunsen burner"
	desc = "A flat, self-heating device designed for bringing chemical mixtures to boil."
	icon = 'icons/obj/device.dmi'
	icon_state = "bunsen0"
	var/heating = 0		//whether the bunsen is turned on
	var/obj/item/reagent_containers/held_container
	var/heat_time = 15
	var/current_temp = T0C

/obj/machinery/bunsen_burner/Initialize(mapload)
	. = ..()
	create_reagents(1,/datum/reagents/distilling)

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

/obj/machinery/bunsen_burner/verb/toggle()
	set src in view(1)
	set name = "Toggle bunsen burner"
	set category = "IC.Game"

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

		// Slosh and toss
		reagents.maximum_volume = held_container.reagents.maximum_volume
		held_container.reagents.trans_to_obj(src,held_container.reagents.total_volume)
		reagents.handle_reactions()
		reagents.trans_to_obj(held_container,reagents.total_volume)
		reagents.clear_reagents()

		// Increase temp till ended by 5 degrees
		current_temp += 10

/obj/machinery/bunsen_burner/update_icon()
	icon_state = "bunsen[heating]"
