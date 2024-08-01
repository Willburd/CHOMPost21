/obj/machinery/reagent_refinery/reactor/atmosanalyze(var/mob/user)
	if(internal_tank)
		return internal_tank.atmosanalyze(user)
	return
