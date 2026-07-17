/obj/machinery/reagent_refinery/reactor/atmosanalyze(mob/user)
	if(internal_tank)
		return atmosanalyzer_scan(src, src.internal_tank.air_contents, user)
	return
