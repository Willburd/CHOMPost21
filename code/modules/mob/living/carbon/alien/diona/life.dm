//Dionaea regenerate health and nutrition in light.
/mob/living/carbon/alien/diona/handle_environment(datum/gas_mixture/environment)

	// outpost 21 addition begin - lockers are dark and spooky!
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(istype(loc,/obj/structure/closet))
		light_amount = 0 // it's dark in here!
	// outpost 21 addition end
	else if(isturf(loc)) //else, there's considered to be no light
		var/turf/T = loc
		light_amount = T.get_lumcount() * 5

	adjust_nutrition(light_amount)

	if(light_amount > 2) //if there's enough light, heal
		adjustBruteLoss(-1)
		adjustFireLoss(-1)
		adjustToxLoss(-1)
		adjustOxyLoss(-1)


	if(!client)
		handle_npc(src)
