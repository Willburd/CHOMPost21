/datum/reagents/proc/ppe_affect(var/mob/living/user)
	if(!isliving(user))
		return
	if(!reagent_list.len)
		return
	if(prob(90))
		return
	var/datum/reagent/R = pick(reagent_list)
	if(!R.ppe_flags)
		return

	// Is it in our hands?
	var/affect_hand = 0
	if(user.r_hand == my_atom)
		affect_hand = 1
	if(user.l_hand == my_atom)
		affect_hand = 2

	// Get our protections
	var/has_gloves = FALSE
	var/has_goggles = FALSE
	var/has_suit = FALSE
	var/phoron_immune = FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.gloves)
			has_gloves = TRUE

		if(H.glasses && (H.glasses.body_parts_covered & EYES))
			has_goggles = TRUE
		else if(H.head && (H.head.body_parts_covered & EYES))
			has_goggles = TRUE

		if(H.wear_suit)
			has_suit = TRUE

		if(H.species.name == SPECIES_VOX || H.species.phoron_contact_mod < 0.1)
			phoron_immune = TRUE

	// Check the PPE effects
	var/list/ppe_check = list()
	var/i = 1
	while(i < REAGENT_PPE_LAST)
		if(R.ppe_flags & i)
			ppe_check.Add(i)
		i*=2
	var/flag_checking = pick(ppe_check)
	var/actual_action = 0

	// first do description of action
	switch(flag_checking)
		if(REAGENT_PPE_GAS)
			if(!has_goggles)
				to_chat(user,span_danger("The [my_atom]'s mist blows into your eyes!"))
				actual_action = REAGENT_PPE_GAS
		if(REAGENT_PPE_DUST)
			if(!has_goggles)
				to_chat(user,span_danger("The [my_atom]'s dust blows into your eyes!"))
				actual_action = REAGENT_PPE_GAS
		if(REAGENT_PPE_SQUIRTS)
			if(!has_goggles)
				to_chat(user,span_danger("The [my_atom] squirts into your eyes!"))
				actual_action = REAGENT_PPE_GAS
		if(REAGENT_PPE_PHORONGAS)
			if(!has_goggles && !phoron_immune)
				to_chat(user,span_danger("The [my_atom]'s mist blows into your eyes!"))
				actual_action = REAGENT_PPE_GAS

		if(REAGENT_PPE_SPLASH)
			if((!has_suit || !has_gloves) && affect_hand)
				to_chat(user,span_danger("The [my_atom] splashes onto you!"))
				actual_action = REAGENT_PPE_SPLASH
		if(REAGENT_PPE_BUBBLES)
			if((!has_suit || !has_gloves) && affect_hand)
				to_chat(user,span_danger("The [my_atom] overflows with foam onto you!"))
				actual_action = REAGENT_PPE_SPLASH

		if(REAGENT_PPE_BURNS)
			if(!has_gloves && affect_hand)
				to_chat(user,span_danger("The [my_atom] becomes painfully hot in your hand!"))
				actual_action = REAGENT_PPE_BURNS
		if(REAGENT_PPE_FREEZES)
			if(!has_gloves && affect_hand)
				to_chat(user,span_danger("The [my_atom] becomes painfully cold in your hand!"))
				actual_action = REAGENT_PPE_BURNS

	// Now do the actual effect... much more simple
	if(!actual_action)
		return
	switch(actual_action)
		if(REAGENT_PPE_GAS)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				var/obj/item/organ/internal/eyes/O = H.internal_organs_by_name[O_EYES]
				if(O && O.robotic <= ORGAN_ASSISTED)
					O.damage += rand(2,5)

		if(REAGENT_PPE_SPLASH)
			R.touch_mob(user,rand(1,3))

		if(REAGENT_PPE_BURNS)
			if(affect_hand == 1)
				user.apply_damage(rand(2,5),SEARING,BP_R_HAND)
			if(affect_hand == 2)
				user.apply_damage(rand(2,5),SEARING,BP_L_HAND)
