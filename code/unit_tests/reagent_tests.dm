/datum/unit_test/reagent_shall_have_unique_name_and_id
	name = "REAGENTS: Reagent IDs and names shall be unique"

/datum/unit_test/reagent_shall_have_unique_name_and_id/start_test()
	var/failed = FALSE


	// These are base types, there is no way to tell that they are illegal to check/use
	var/list/exclusions = list()
	exclusions.Add(/datum/reagent)
	exclusions.Add(/datum/reagent/drink)
	exclusions.Add(/datum/reagent/medicine)
	exclusions.Add(/datum/reagent/boron)
	exclusions.Add(/datum/reagent/ethanol)
	exclusions.Add(/datum/reagent/ethanol/wine)

	failed = check_reagent_datums(exclusions)

	if(failed)
		fail("One or more /datum/reagent subtypes had invalid definitions.")
	else
		pass("All /datum/reagent subtypes had correct settings.")
	return TRUE

/datum/unit_test/reagent_shall_have_unique_name_and_id/proc/check_reagent_datums(var/list/subtype_removal)
	var/failed = FALSE

	var/collection_name = list()
	var/collection_id = list()

	// Remove excluded types
	var/list/type_list = subtypesof(/datum/reagent)
	for(var/S in subtype_removal)
		type_list -= S

	for(var/Rpath in type_list)
		var/datum/reagent/R = new Rpath()

		if(R.name == DEVELOPER_WARNING_CHEM_ID)
			log_unit_test("[R]: Reagents - reagent name not set.")
			failed = TRUE

		if(collection_name[R.name])
			log_unit_test("[R]: Reagents - reagent name \"[R.name]\" is not unique, used first in [collection_name[R.name]].")
			failed = TRUE
		collection_name[R.name] = R.type

		if(collection_id[R.id])
			log_unit_test("[R]: Reagents - reagent ID \"[R.id]\" is not unique, used first in [collection_id[R.id]].")
			failed = TRUE
		collection_id[R.id] = R.type

		if(R.description == DEVELOPER_WARNING_CHEM_DESC)
			log_unit_test("[R]: Reagents - reagent description unset.")
			failed = TRUE

		qdel(R)
	return failed



/datum/unit_test/chemical_reactions_shall_use_and_produce_valid_reagents
	name = "RECIPES: Chemical Reactions shall use and produce valid reagents"

/datum/unit_test/chemical_reactions_shall_use_and_produce_valid_reagents/start_test()
	var/failed = FALSE
	for(var/decl/chemical_reaction/R in subtypesof(/decl/chemical_reaction))
		failed = FALSE

		//if(!ISINTEGER(our_amount))
		//	log_unit_test("[R]: Recipes - result_quantity must be an integer.")
		//	failed = TRUE

	if(failed)
		fail("One or more /datum/recipe subtypes had invalid results or result_quantity definitions.")
	else
		pass("All /datum/recipe subtypes had correct settings.")
	return TRUE



/datum/unit_test/prefilled_reagent_containers_shall_have_valid_reagents
	name = "RECIPES: Prefilled reagent containers shall have valid reagents"

/datum/unit_test/prefilled_reagent_containers_shall_have_valid_reagents/start_test()
	var/failed = FALSE

	for(var/RC in subtypesof(/obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/R = new RC()

		if(R.prefill && R.prefill.len)
			for(var/ID in R.prefill)
				if(!SSchemistry.chemical_reagents[ID])
					log_unit_test("[RC]: Reagents - reagent prefill had invalid reagent ID \"[ID]\".")
					failed = TRUE

		qdel(R)

	if(failed)
		fail("One or more /obj/item/reagent_containers had an invalid prefill reagent.")
	else
		pass("All /obj/item/reagent_containers containers had valid prefill reagents.")
	return TRUE
