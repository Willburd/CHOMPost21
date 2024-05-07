/mob/living/carbon/alien
	var/randomize_name = TRUE

/mob/living/carbon/alien/Initialize()
	. = ..()
	if(randomize_name)
		name = "[initial(name)] ([instance_num])"
		real_name = name