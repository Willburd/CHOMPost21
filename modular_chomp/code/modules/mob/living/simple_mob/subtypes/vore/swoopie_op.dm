/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/prim
	name = "PR1M-N-PR0P3R"
	// Desc todo for pet
	allow_mind_transfer = FALSE

/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/prim/Initialize()
	. = ..()
	var/color_to_use = color_matrix_hsv(50, 1, 1)
	add_atom_colour(color_to_use, FIXED_COLOUR_PRIORITY)
	custom_eye_color = "#f1d414"

/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/randomized/Initialize()
	. = ..()
	var/color_to_use = color_matrix_hsv(pick(0,50,70,130,180,220,300,320), 1, 1)
	add_atom_colour(color_to_use, FIXED_COLOUR_PRIORITY)
	custom_eye_color = pick("#00CC00","#24bdd1","#ee3225")
