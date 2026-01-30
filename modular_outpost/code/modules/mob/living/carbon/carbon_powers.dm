/mob/living/proc/toggle_active_cloaking() // Modified from roguestar code to use cloak()
	set category = "Abilities.General"
	set name = "Toggle Active Cloaking"

	if(cloaked)
		to_chat(src, span_notice("You are now visible."))
		uncloak()
	else
		to_chat(src, span_notice("You are now invisible."))
		cloak()
