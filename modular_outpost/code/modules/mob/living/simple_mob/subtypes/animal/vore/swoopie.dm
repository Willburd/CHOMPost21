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
