/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie
	shock_resist = 1 // borg

/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/get_effective_size(var/micro = FALSE)
	return size_multiplier + 0.55 // Lets teshari get scooped running under it

/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/verb/eject_switch()
	set name = "Eject CHURNO-VAC"
	set desc = "Releases the contents of the SWOOPIE's CHURNO-VAC."
	set category = "Object"
	set src in oview(1)

	if(do_after(usr, 40, target = src))
		usr.visible_message(span_info("[usr] pulls \The [src]'s ejection switch!"))
		release_vore_contents()
		for(var/mob/living/L in living_mobs(0)) //add everyone on the tile to the do-not-eat list for a while
			if(!(LAZYFIND(prey_excludes, L))) // Unless they're already on it, just to avoid fuckery.
				LAZYSET(prey_excludes, L, world.time)
				addtimer(CALLBACK(src, PROC_REF(removeMobFromPreyExcludes), WEAKREF(L)), 30 SECONDS)

// Default these on
/datum/ai_holder/simple_mob/retaliate/swoopie
	swoop_pests = TRUE
	swoop_trash = TRUE



// AI pet subtype
/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/prim
	name = "PR1M-N-PR0P3R"
	faction = "outpost21"
	// Desc todo for pet
	allow_mind_transfer = FALSE

/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/prim/Initialize(mapload)
	. = ..()
	var/color_to_use = color_matrix_hsv(50, 1, 1)
	add_atom_colour(color_to_use, FIXED_COLOUR_PRIORITY)
	custom_eye_color = "#f1d414"

// Randomized type
/mob/living/simple_mob/vore/aggressive/corrupthound/swoopie/randomized/Initialize(mapload)
	. = ..()
	var/color_to_use = color_matrix_hsv(pick(0,50,70,130,180,220,300,320), 1, 1)
	add_atom_colour(color_to_use, FIXED_COLOUR_PRIORITY)
	custom_eye_color = pick("#00CC00","#24bdd1","#ee3225")
