/mob/living/carbon/human/proc/equip_disability_items()
	//Gives glasses to the vision impaired
	if(disabilities & NEARSIGHTED)
		var/equipped = equip_to_slot_or_del(new /obj/item/clothing/glasses/regular(src), slot_glasses)
		if(equipped != 1)
			var/obj/item/clothing/glasses/G = glasses
			G.prescription = 1

	// store some extra things
	var/obj/item/weapon/storage/Bag
	for(var/obj/item/weapon/storage/S in contents)
		Bag = S
		break

	if(!isnull(Bag))
		//Gives medications for neurological disabilities
		if(disabilities & SCHIZOPHRENIA)
			var/perscrip = new /obj/item/weapon/storage/pill_bottle/lithium()
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(disabilities & DEPRESSION)
			var/perscrip = new /obj/item/weapon/storage/pill_bottle/paroxetine() // stronger meds for more dangerous cases
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(disabilities & DEPRESSION || disabilities & NERVOUS || disabilities & EPILEPSY || disabilities & TOURETTES)
			var/perscrip = new /obj/item/weapon/storage/pill_bottle/citalopram() // currently the only reasonable med, also one of the few with an actual pill bottle
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		// allergy meds!
		if(species.allergens & ALLERGEN_POLLEN)
			var/perscrip = new /obj/item/weapon/storage/pill_bottle/inaprovaline() // because anaphylactic shock from grass is overwhelming
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(!isnull(species.breath_type) && species.breath_type != "oxygen")
			// antitox pills
			var/perscrip = new /obj/item/weapon/storage/pill_bottle/dylovene() // anti-toxin for accidents
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip
	else
		to_chat(src, "<span class='danger'>Failed to locate a storage object for your medication on your mob, either you spawned with no arms and no backpack or this is a bug.</span>")
