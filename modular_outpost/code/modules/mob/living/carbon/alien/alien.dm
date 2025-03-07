/mob/living/carbon/alien
	var/randomize_name = TRUE

/mob/living/carbon/alien/Initialize(mapload)
	. = ..()
	if(randomize_name)
		name = "[initial(name)] ([instance_num])"
		real_name = name
