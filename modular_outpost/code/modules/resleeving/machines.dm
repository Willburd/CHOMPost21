////////////////////////////////
//// Machines required for body printing
//// and decanting into bodies
////////////////////////////////

/////// Grower Pod ///////
/obj/machinery/clonepod/transhuman/vox
	name = "vox regeneration pod"
	catalogue_data = list(/datum/category_item/catalogue/information/organization/vey_med,
						/datum/category_item/catalogue/technology/resleeving)
	circuit = /obj/item/circuitboard/transhuman_clonepod

	// file override, uses the same icon_states!
	icon = 'icons/obj/cloning.dmi'

/obj/machinery/clonepod/transhuman/vox/process()
	var/mob/living/occupant = get_occupant()
	if(stat & NOPOWER)
		if(occupant)
			locked = 0
			go_out()
		return

	if((occupant) && (occupant.loc == src))
		if(occupant.stat == DEAD)
			locked = 0
			go_out()
			connected_message("Clone Rejected: Deceased.")
			return

		else if(occupant.health < heal_level && occupant.getCloneLoss() > 0)

			//Slowly get that clone healed and finished.
			occupant.adjustCloneLoss(-2 * heal_rate)

			//Premature clones may have brain damage.
			occupant.adjustBrainLoss(-(CEILING((0.5*heal_rate), 1)))

			//So clones don't die of oxyloss in a running pod.
			if(occupant.reagents.get_reagent_amount(REAGENT_ID_PHORON) < 30)
				occupant.reagents.add_reagent(REAGENT_ID_PHORON, 60)

			//Also heal some oxyloss ourselves because inaprovaline is so bad at preventing it!!
			occupant.adjustOxyLoss(-4)

			use_power(7500) //This might need tweaking.
			return


		else if(((occupant.health == occupant.getMaxHealth())) && (!eject_wait))
			playsound(src, 'sound/machines/ding.ogg', 50, 1)
			audible_message("\The [src] signals that the growing process is complete.", runemessage = "ding")
			connected_message("Growing Process Complete.")
			locked = 0
			go_out()
			return

	else if((!occupant) || (occupant.loc != src))
		set_occupant(null)
		if(locked)
			locked = 0
		update_icon()
		return

	return
