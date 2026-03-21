/datum/unit_test/all_slimes_must_have_research_values

/datum/unit_test/all_slimes_must_have_research_values/Run()
	var/failed = FALSE

	for(var/slime in subtypesof(/obj/item/slime_extract))
		if(!(slime in SSresearch.techweb_point_items))
			TEST_NOTICE(src, "Slimes - [slime] type did not have a SSresearch.techweb_point_items value associated with it.")
			failed = TRUE
		// Outpost 21 edit begin - Test for sellable too
		var/obj/item/slime_extract/extract = slime
		if(!initial(extract.supply_conversion_value))
			TEST_NOTICE(src, "Slimes - [slime] type did not have a supply_conversion_value set.")
			failed = TRUE
		// Outpost 21 edit end

	if(failed)
		TEST_FAIL("All xenobio slimes must have a research point value")
