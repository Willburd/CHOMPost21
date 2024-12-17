/obj/structure/extinguisher_cabinet/process()
	// Refill extinguisher while loaded
	if(!has_extinguisher || has_extinguisher.reagents.total_volume >= has_extinguisher.reagents.maximum_volume)
		STOP_PROCESSING(SSobj, src)
		visible_message("\The [src] clicks as it finishes filling \the [has_extinguisher] ","click")
		playsound(src, 'sound/machines/click.ogg', 50, 1)
		return
	// slowly refill it with the foam
	has_extinguisher.reagents.add_reagent(REAGENT_ID_FIREFOAM, 1)

/obj/structure/extinguisher_cabinet/proc/connected_extinguisher(var/mob/user, var/obj/item/extinguisher/O)
	O.safety = TRUE // Don't spray if put back in
	O.update_icon()
	user.remove_from_mob(O)
	contents += O
	has_extinguisher = O
	// We refill ours!
	if(has_extinguisher.reagents.total_volume < has_extinguisher.reagents.maximum_volume)
		START_PROCESSING(SSobj, src)
		visible_message("\The [src] clicks as it starts filling \the [has_extinguisher] ","click")
		playsound(src, 'sound/machines/click.ogg', 50, 1)

/obj/structure/extinguisher_cabinet/proc/removed_extinguisher()
	has_extinguisher = null
	STOP_PROCESSING(SSobj, src)
