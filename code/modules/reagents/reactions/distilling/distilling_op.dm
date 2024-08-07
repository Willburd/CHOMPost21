// Or engi-chem won't have fun
/decl/chemical_reaction/distilling/sugar
	name = "Distilling Sugar"
	id = "distill_sugar"
	result = "sugar"
	required_reagents = list("carbon" = 1,"hydrogen" = 2)
	result_amount = 2

	temp_range = list(T20C + 120, T20C + 220)
	temp_shift = -1

	require_xgm_gas = "oxygen" // should be easy!
	rejects_xgm_gas = "nitrogen" // So you can't do it on a bunsen

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
