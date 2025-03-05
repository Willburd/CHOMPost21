/decl/chemical_reaction/distilling/sapoformator
	name = "Distilling Sapoformator"
	id = "distill_sapoformator"
	result = REAGENT_ID_SPACOMYCAZE
	required_reagents = list(REAGENT_ID_CLEANER = 1, REAGENT_ID_FOAMINGAGENT = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 160, T0C + 220)
	result_amount = 2

/decl/chemical_reaction/distilling/obscuritol
	name = "Distilling Obscuritol"
	id = "distill_obscuritol"
	result = REAGENT_ID_OBSCURITOL
	required_reagents = list(REAGENT_ID_MERCURY = 1, REAGENT_ID_URANIUM = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 60, T0C + 320)
	result_amount = 1

/decl/chemical_reaction/distilling/obscuritol/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	if(holder && holder.my_atom)
		var/turf/T = get_turf(holder.my_atom)
		for(var/obj/machinery/light/light in orange(6, T))
			light.flicker(rand(5, 10))
			if(prob(2))
				light.broken()

/decl/chemical_reaction/distilling/oxyphoromin
	name = "Distilling Oxyphoromin"
	id = "distill_oxyphoromin"
	result = REAGENT_ID_OXYPHOROMIN
	required_reagents = list(REAGENT_ID_OXYCODONE = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 960, T0C + 1470)
	result_amount = 1

/decl/chemical_reaction/distilling/extreme_mutagen
	name = "Distilling Mutagen X"
	id = "distill_extreme_mutagen"
	result = REAGENT_ID_MUTAGENX
	required_reagents = list(REAGENT_ID_MUTAGEN = 5, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 60, T0C + 170)
	result_amount = 0.1

/decl/chemical_reaction/distilling/genedrazine
	name = "Distilling Genedrazine"
	id = "distill_genedrazine"
	result = REAGENT_ID_GENEDRAZINE
	required_reagents = list(REAGENT_ID_CLONEXADONE = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 90, T0C + 200)
	result_amount = 1

/decl/chemical_reaction/distilling/expulsicol
	name = "Distilling Expulsicol"
	id = "distill_expulsicol"
	result = REAGENT_ID_EXPULSICOL
	required_reagents = list(REAGENT_ID_ICKYPAK = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 200, T0C + 600)
	result_amount = 2

/decl/chemical_reaction/distilling/nocturnol
	name = "Distilling Nocturnol"
	id = "distill_nocturnol"
	result = REAGENT_ID_NOCTURNOL
	required_reagents = list(REAGENT_ID_BLISS = 5, REAGENT_ID_COPPER = 1, REAGENT_ID_PHORON = 0.1)
	catalysts = list(REAGENT_ID_PHORON = 1)
	temp_range = list(T0C + 100, T0C + 200)
	result_amount = 0.1
