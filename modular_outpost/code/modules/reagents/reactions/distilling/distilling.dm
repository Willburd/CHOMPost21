// Or engi-chem won't have fun
/decl/chemical_reaction/distilling/sugar
	name = "Crystalizing Sugar"
	id = "distill_sugar"
	result = REAGENT_ID_SUGAR
	required_reagents = list(REAGENT_ID_CARBON = 5)
	catalysts = list(REAGENT_ID_WATER = 1, REAGENT_ID_SUGAR = 1) // Rebuild the crystals!
	result_amount = 0.1

	temp_range = list(T0C -10, T0C -5) // crystal growth
	temp_shift = -1

	require_xgm_gas = GAS_PHORON
	rejects_xgm_gas = GAS_O2

/decl/chemical_reaction/distilling/hydrogen
	name = "Distilling Hydrogen"
	id = "distill_hydrogen"
	result = REAGENT_ID_HYDROGEN
	inhibitors = list(REAGENT_ID_CARBON = 1)
	required_reagents = list(REAGENT_ID_WATER = 1)
	result_amount = 2

	temp_range = list(T20C + 110, T20C + 290)
	temp_shift = 3 // It's burning off phoron

	require_xgm_gas = GAS_PHORON
	rejects_xgm_gas = GAS_O2

/decl/chemical_reaction/distilling/oxygen
	name = "Distilling Oxygen"
	id = "distill_oxygen"
	result = REAGENT_ID_OXYGEN
	inhibitors = list(REAGENT_ID_CARBON = 1)
	required_reagents = list(REAGENT_ID_WATER = 1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	result_amount = 1

	temp_range = list(T20C + 150, T20C + 320)
	temp_shift = 3 // It's burning off phoron

	require_xgm_gas = GAS_N2
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
	if(B && B.changling_blood_test(holder))
		return
	. = ..()
