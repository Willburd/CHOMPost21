// For changeling detection
/datum/decl/chemical_reaction/distilling/anti_changeling
	name = "Distilling Water From Blood"
	id = "distill_antichangeling"
	result = REAGENT_ID_WATER
	inhibitors = list(REAGENT_ID_SUGAR = 0.1, REAGENT_ID_PHORON = 0.1, REAGENT_ID_BIOMASS = 0.1) // or it would block biomass
	required_reagents = list(REAGENT_ID_BLOOD = 1)
	temp_range = list(T20C + 80, T20C + 330)
	temp_shift = -2
	result_amount = 1

/datum/decl/chemical_reaction/distilling/anti_changeling/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/datum/reagent/blood/B = holder.get_reagent(REAGENT_ID_BLOOD)
	if(B && B.changling_blood_test(holder))
		return
	. = ..()

/datum/decl/chemical_reaction/distilling/fenthol
	name = REAGENT_FENTHOL
	id = REAGENT_ID_FENTHOL
	result = REAGENT_ID_FENTHOL
	required_reagents = list(REAGENT_ID_MINDBREAKER = 1, REAGENT_ID_OXYPHOROMIN = 2)
	temp_range = list(T0C + 520, T0C + 590)
	temp_shift = 2
	result_amount = 0.15

/datum/decl/chemical_reaction/distilling/narcoloxon
	name = REAGENT_NARCOLOXON
	id = REAGENT_ID_NARCOLOXON
	result = REAGENT_ID_NARCOLOXON
	required_reagents = list(REAGENT_ID_ANTITOXIN = 1, REAGENT_ID_OXYPHOROMIN = 1)
	temp_range = list(T0C + 220, T0C + 300)
	temp_shift = 1
	result_amount = 1
