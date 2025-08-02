// For changeling detection
/decl/chemical_reaction/distilling/anti_changeling
	name = "Distilling Water From Blood"
	id = "distill_antichangeling"
	result = REAGENT_ID_WATER
	inhibitors = list(REAGENT_ID_SUGAR = 1) // or it would block biomass
	required_reagents = list(REAGENT_ID_BLOOD = 1)
	temp_range = list(T20C + 80, T20C + 330)
	temp_shift = -2
	result_amount = 1

/decl/chemical_reaction/distilling/anti_changeling/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/datum/reagent/blood/B = holder.get_reagent(REAGENT_ID_BLOOD)
	if(B && B.changling_blood_test(holder))
		return
	. = ..()
