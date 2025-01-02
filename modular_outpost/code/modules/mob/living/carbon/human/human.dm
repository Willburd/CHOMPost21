/mob/living/carbon/human
	var/gutdeathpressure = 0 // for superfart and gibbing

/mob/living/carbon/human/proc/equip_disability_items()
	//Gives glasses to the vision impaired
	if(disabilities & NEARSIGHTED)
		var/equipped = equip_to_slot_or_del(new /obj/item/clothing/glasses/regular(src), slot_glasses)
		if(equipped != 1)
			var/obj/item/clothing/glasses/G = glasses
			G.prescription = 1

	// store some extra things
	var/obj/item/storage/Bag
	for(var/obj/item/storage/S in contents)
		Bag = S
		break

	if(!isnull(Bag))
		//Gives medications for neurological disabilities
		if(disabilities & SCHIZOPHRENIA)
			var/perscrip = new /obj/item/storage/pill_bottle/lithium()
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(disabilities & DEPRESSION)
			var/perscrip = new /obj/item/storage/pill_bottle/paroxetine() // stronger meds for more dangerous cases
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(disabilities & DEPRESSION || disabilities & NERVOUS || disabilities & EPILEPSY || disabilities & TOURETTES)
			var/perscrip = new /obj/item/storage/pill_bottle/citalopram() // currently the only reasonable med, also one of the few with an actual pill bottle
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		// allergy meds!
		if(species.allergens & ALLERGEN_POLLEN)
			var/perscrip = new /obj/item/storage/pill_bottle/inaprovaline() // because anaphylactic shock from grass is overwhelming
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		if(!isnull(species.breath_type) && species.breath_type != GAS_O2)
			// antitox pills
			var/perscrip = new /obj/item/storage/pill_bottle/dylovene() // anti-toxin for accidents
			to_chat(src, "<span class='notice'>Placing \the [perscrip] medication in your [Bag.name]!</span>")
			Bag.contents += perscrip

		// Sustinance addiction... They REALLY need this one, so make sure they get it...
		if(addiction_counters[REAGENT_ID_ASUSTENANCE] && addiction_counters[REAGENT_ID_ASUSTENANCE] > 0)
			var/obj/item/reagent_containers/glass/beaker/vial/perscrip = new /obj/item/reagent_containers/glass/beaker/vial/sustenance()
			perscrip.flags ^= OPENCONTAINER // Close the container
			to_chat(src, "<span class='notice'>Placing \the [perscrip] in your [Bag.name]!</span>")
			Bag.contents += perscrip
	else
		to_chat(src, "<span class='danger'>Failed to locate a storage object for your medication on your mob, either you spawned with no arms and no backpack or this is a bug.</span>")

/mob/living/carbon/human/proc/equip_survival_tanks(var/forceback = FALSE)
	if(!isnull(species) && !isnull(species.breath_type) && species.breath_type != GAS_O2)
		// configure tank
		var/obj/item/tank/gastank = null
		if(species.breath_type == GAS_PHORON)
			gastank = new /obj/item/tank/vox(src)
		if(species.breath_type == GAS_N2)
			gastank = new /obj/item/tank/nitrogen(src)
		if(species.breath_type == GAS_CO2)
			gastank = new /obj/item/tank/carbon_dioxide(src)
		if(species.breath_type == GAS_CH4)
			gastank = new /obj/item/tank/methane(src)

		// back, or hand...
		equip_to_slot_or_del(new /obj/item/clothing/mask/breath(src), slot_wear_mask)
		if(forceback || backbag == 1)
			equip_to_slot_or_del(gastank, slot_back)
		else
			equip_to_slot_or_del(gastank, slot_r_hand)
			if(!(gastank in contents))
				equip_to_slot_or_del(gastank, slot_l_hand)

		internal = locate(/obj/item/tank) in contents
		if(istype(internal,/obj/item/tank) && internals)
			internals.icon_state = "internal1"
