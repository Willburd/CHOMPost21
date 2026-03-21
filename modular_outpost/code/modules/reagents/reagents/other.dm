
/datum/reagent/water/holywater/touch_turf(var/turf/T)
	..()
	if(volume < 5)
		return

	SShaunting.influence(HAUNTING_BLESSING) // Significant push, to avoid punishing mechanics
	for(var/card in GLOB.alldirs) // spread it out more...
		var/turf/TR = get_step(T,card)
		if(TR)
			TR.holy = TRUE

	var/area/A = get_area(T)
	if(A?.haunted && !(T.z in using_map.admin_levels)) // admin level is redspace centcomm z on outpost
		if(prob(10)) // ANGY MODE
			SShaunting.intense_world_haunt()
		else
			SShaunting.reduce_world_haunt()
		T.visible_message("\The [A] was consecrated!")
		A.haunted = FALSE
