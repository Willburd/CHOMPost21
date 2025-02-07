/datum/unit_test/reagent_shall_have_unique_name_and_id
	name = "REAGENTS: Reagent IDs and names shall be unique"

/datum/unit_test/reagent_shall_have_unique_name_and_id/start_test()
	var/failed = FALSE

	var/collection_name = list()
	var/collection_id = list()
	for(var/Rpath in subtypesof(/datum/reagent))
		var/datum/reagent/R = new Rpath()
		if(!R.name)
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

		if(R.description == "A non-descript chemical.")
			log_unit_test("[R]: Reagents - reagent description unset.")
			failed = TRUE

	if(failed)
		fail("One or more /datum/reagent subtypes had invalid definitions.")
	else
		pass("All /datum/reagent subtypes had correct settings.")
	return TRUE
