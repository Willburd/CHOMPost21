// Or engi-chem won't have fun
/decl/chemical_reaction/distilling/sugar
	name = "Distilling Sugar"
	id = "distill_sugar"
	result = REAGENT_ID_SUGAR
	required_reagents = list(REAGENT_ID_WATER = 5)
	catalysts = list(REAGENT_ID_PLANTCOLONY = 1)
	result_amount = 1

	temp_range = list(T20C + 30, T20C + 60)
	temp_shift = -1

	require_xgm_gas = GAS_CO2 // PHOTOSYNTHESIS, PHOTOSYNTHESIS, PHOTOSYNTHESIS, PHOTOSYNTHESIS
	rejects_xgm_gas = GAS_O2

/decl/chemical_reaction/distilling/hydrogen
	name = "Distilling Hydrogen"
	id = "distill_hydrogen"
	result = REAGENT_ID_HYDROGEN
	required_reagents = list(REAGENT_ID_WATER = 1)
	result_amount = 2

	temp_range = list(T20C + 110, T20C + 290)
	temp_shift = 3 // It's burning off phoron and oxygen

	require_xgm_gas = GAS_PHORON
	rejects_xgm_gas = GAS_O2

/decl/chemical_reaction/distilling/mineralized_sodium
	name = "Distilling Sodium"
	id = "distill_sodium"
	result = REAGENT_ID_SODIUM
	required_reagents = list(REAGENT_ID_MINERALIZEDFLUID = 1)
	result_amount = 1

	temp_range = list(T20C + 600, T20C + 800)
	temp_shift = -1

	require_xgm_gas = GAS_PHORON
	rejects_xgm_gas = GAS_O2

/decl/chemical_reaction/distilling/mineralized_carbon
	name = "Distilling Carbon"
	id = "distill_carbon"
	result = REAGENT_ID_CARBON
	required_reagents = list(REAGENT_ID_MINERALIZEDFLUID = 1)
	result_amount = 1

	temp_range = list(T20C + 400, T20C + 800)
	temp_shift = -1

	require_xgm_gas = GAS_O2
	rejects_xgm_gas = GAS_PHORON

/decl/chemical_reaction/distilling/reduce_salt
	name = "Distilling Sodium"
	id = "distill_reduce_tablesalt"
	result = REAGENT_ID_SODIUM
	required_reagents = list(REAGENT_ID_SODIUMCHLORIDE = 1)
	result_amount = 1

	temp_range = list(T20C + 800, T20C + 1000)
	temp_shift = -1

	require_xgm_gas = GAS_PHORON
	rejects_xgm_gas = GAS_O2

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
	if(B.changling_blood_test(holder))
		return
	. = ..()
