// Or engi-chem won't have fun
/decl/chemical_reaction/distilling/sugar
	name = "Distilling Sugar"
	id = "distill_sugar"
	result = "sugar"
	required_reagents = list("water" = 5)
	catalysts = list("plantcolony" = 1)
	result_amount = 1

	temp_range = list(T20C + 30, T20C + 60)
	temp_shift = -1

	require_xgm_gas = "carbon_dioxide" // PHOTOSYNTHESIS, PHOTOSYNTHESIS, PHOTOSYNTHESIS, PHOTOSYNTHESIS
	rejects_xgm_gas = "oxygen"

/decl/chemical_reaction/distilling/hydrogen
	name = "Distilling Hydrogen"
	id = "distill_hydrogen"
	result = "hydrogen"
	required_reagents = list("water" = 1)
	result_amount = 2

	temp_range = list(T20C + 110, T20C + 290)
	temp_shift = 3 // It's burning off phoron and oxygen

	require_xgm_gas = "phoron"
	rejects_xgm_gas = "oxygen"

/decl/chemical_reaction/distilling/mineralized_sodium
	name = "Distilling Sodium"
	id = "distill_sodium"
	result = "sodium"
	required_reagents = list("mineralizedfluid" = 1)
	result_amount = 1

	temp_range = list(T20C + 600, T20C + 800)
	temp_shift = -1

	require_xgm_gas = "phoron"
	rejects_xgm_gas = "oxygen"

/decl/chemical_reaction/distilling/mineralized_carbon
	name = "Distilling Carbon"
	id = "distill_carbon"
	result = "carbon"
	required_reagents = list("mineralizedfluid" = 1)
	result_amount = 1

	temp_range = list(T20C + 400, T20C + 800)
	temp_shift = -1

	require_xgm_gas = "oxygen"
	rejects_xgm_gas = "phoron"

/decl/chemical_reaction/distilling/reduce_salt
	name = "Distilling Sodium"
	id = "distill_reduce_tablesalt"
	result = "sodium"
	required_reagents = list("sodiumchloride" = 1)
	result_amount = 1

	temp_range = list(T20C + 800, T20C + 1000)
	temp_shift = -1

	require_xgm_gas = "phoron"
	rejects_xgm_gas = "oxygen"
