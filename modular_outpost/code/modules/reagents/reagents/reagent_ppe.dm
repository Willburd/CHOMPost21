/datum/reagents/proc/ppe_affect(mob/living/user)
	if(QDELETED(user))
		return
	if(QDELETED(my_atom))
		return
	if(!isliving(user))
		return
	if(!reagent_list.len)
		return
	if(!istype(my_atom,/obj/item/reagent_containers/glass)) // Limited to glass for now to avoid milking someone and getting ppe blinded or something
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



//////////////////////////////////////////////////////////////////////////////////////////
// Assigned PPE reagents
//////////////////////////////////////////////////////////////////////////////////////////
/datum/reagent/blood
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/water
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/fuel
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_PHORONGAS

/datum/reagent/chlorine
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH|REAGENT_PPE_BURNS
/datum/reagent/fluorine
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH
/datum/reagent/hydrogen
	ppe_flags = REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH
/datum/reagent/lithium
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/mercury
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/oxygen
	ppe_flags = REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH
/datum/reagent/phosphorus
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH
/datum/reagent/radium
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/radium/concentrated
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/acid
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH

/datum/reagent/drugs
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH

/datum/reagent/spaceacillin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/inaprovaline
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/inaprovaline/topical
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/bicaridine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/bicaridine/topical
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/kelotane
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/dermaline
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/dermaline/topical
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/dylovene
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/carthatoline
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/dexalin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/dexalinp
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/tricordrazine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/tricorlidaze
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/cryoxadone
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH|REAGENT_PPE_FREEZES
/datum/reagent/clonexadone
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH|REAGENT_PPE_FREEZES
/datum/reagent/necroxadone
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH|REAGENT_PPE_FREEZES
/datum/reagent/paracetamol
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/tramadol
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/oxycodone
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/synaptizine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/hyperzine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/alkysine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/imidazoline
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/peridaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/osteodaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/myelamine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/respirodaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/gastirodaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/hepanephrodaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/cordradaxon
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/immunosuprizine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/ryetalyn
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/ethylredoxrazine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/hyronalin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/arithrazine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/spaceacillin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/corophizine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/spacomycaze
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/sterilizine
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH|REAGENT_PPE_BURNS|REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS
/datum/reagent/leporazine
	ppe_flags = REAGENT_PPE_BURNS|REAGENT_PPE_FREEZES

/datum/reagent/toxin
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_SPLASH
/datum/reagent/toxin/amatoxin
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/toxin/carpotoxin
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/toxin/hydrophoron
	ppe_flags = REAGENT_PPE_PHORONGAS|REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/toxin/spidertoxin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/toxin/warningtoxin
	ppe_flags = REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/toxin/phoron
	ppe_flags = REAGENT_PPE_PHORONGAS|REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/toxin/cyanide
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/toxin/zombiepowder
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/toxin/zombiepowder
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/lichpowder
	ppe_flags = REAGENT_PPE_SPLASH
/datum/reagent/toxin/plantbgone
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_SPLASH
/datum/reagent/acid/polyacid
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_BURNS|REAGENT_PPE_SPLASH
/datum/reagent/acid/digestive
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/acid/diet_digestive
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_BUBBLES|REAGENT_PPE_SPLASH
/datum/reagent/condensedcapsaicin/venom
	ppe_flags = REAGENT_PPE_GAS|REAGENT_PPE_SQUIRTS|REAGENT_PPE_SPLASH

/datum/reagent/macrocillin
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
/datum/reagent/microcillin
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
/datum/reagent/normalcillin
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
/datum/reagent/sizeoxadone
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
/datum/reagent/ickypak
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
/datum/reagent/unsorbitol
	ppe_flags = REAGENT_PPE_SPLASH|REAGENT_PPE_BUBBLES
