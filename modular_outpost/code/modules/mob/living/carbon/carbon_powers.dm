/mob/living/proc/toggle_active_cloaking() // Modified from roguestar code to use cloak()
	set category = "Abilities.General"
	set name = "Toggle Active Cloaking"

	if(cloaked)
		to_chat(src, span_notice("You are now visible."))
		uncloak()
	else
		to_chat(src, span_notice("You are now invisible."))
		cloak()

/mob/proc/check_mutation_cascade_gib()
	if(!HAS_TRAIT(src, TRAIT_MUTATIONCASCADE))
		return
	if(stat == DEAD)
		return
	visible_message("\The [src]'s skin begins to droop and boil")
	to_chat(src, span_danger(span_huge("You don't feel so good...")))
	addtimer(CALLBACK(src, PROC_REF(gib)), rand(3,10) SECONDS, TIMER_DELETE_ME)
