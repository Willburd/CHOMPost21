/decl/chemical_reaction/distilling/sugar // Or engi-chem won't have fun
	name = "Distilling Sugar"
	id = "sugar"
	result = "sugar"
	required_reagents = list("carbon" = 1,"hydrogen" = 2)
	result_amount = 2

	temp_range = list(T20C + 120, T20C + 220)
	temp_shift = -1

	require_xgm_gas = "oxygen" // should be easy!
	rejects_xgm_gas = "phoron" // should be easy!
