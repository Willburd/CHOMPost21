/decl/chemical_reaction/instant/hemocyanin
	name = "Hemocyanin"
	id = "hemocyanin"
	result = "hemocyanin"
	required_reagents = list("nitrogen" = 5, "hydrogen" = 3, "carbon" = 10, "copper" = 1, "phoron" = 0.2)
	catalysts = list("phoron" = 1)
	result_amount = 20

/decl/chemical_reaction/instant/artificial_sustenance
	name = "Artificial Sustenance"
	id = "a_sustenance"
	result = "a_sustenance"
	required_reagents = list("nutriment" = 1, "mutagen" = 1, "phoron" = 1)
	result_amount = 1

/decl/chemical_reaction/instant/sulphuricacid
	name = "Sulphuric acid"
	id = "sacid"
	result = "sacid"
	required_reagents = list("hydrogen" = 2,"sulfur" = 1,"oxygen" = 4)
	result_amount = 5

/decl/chemical_reaction/instant/sugar // Or engi-chem won't have fun
	name = "Sugar"
	id = "sugar"
	result = "sugar"
	catalysts = list("phoron" = 1)
	required_reagents = list("carbon" = 1,"hydrogen" = 2,"oxygen" = 1)
	result_amount = 1
