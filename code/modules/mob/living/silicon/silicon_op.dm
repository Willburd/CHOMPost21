/obj/effect/overlay/aiholo/
	///the icon currently used for the typing indicator's bubble
	var/mutable_appearance/active_typing_indicator
	///the icon currently used for the thinking indicator's bubble
	var/mutable_appearance/active_thinking_indicator

// Imagine copypasting code again!

/** Creates a thinking indicator over the mob. Note: Prefs are checked in /client/proc/start_thinking() */
/obj/effect/overlay/aiholo/proc/create_thinking_indicator(var/cur_bubble_appearance)
	if(active_thinking_indicator || active_typing_indicator)
		return FALSE
	active_thinking_indicator = mutable_appearance('icons/mob/talk_vr.dmi', "[cur_bubble_appearance]_thinking", FLOAT_LAYER)
	active_thinking_indicator.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	add_overlay(active_thinking_indicator)

/** Removes the thinking indicator over the mob. */
/obj/effect/overlay/aiholo/proc/remove_thinking_indicator()
	if(!active_thinking_indicator)
		return FALSE
	cut_overlay(active_thinking_indicator)
	active_thinking_indicator = null

/** Creates a typing indicator over the mob. Note: Prefs are checked in /client/proc/start_typing() */
/obj/effect/overlay/aiholo/proc/create_typing_indicator(var/cur_bubble_appearance)
	if(active_typing_indicator || active_thinking_indicator)
		return FALSE
	active_typing_indicator = mutable_appearance('icons/mob/talk_vr.dmi', "[cur_bubble_appearance]_typing", ABOVE_MOB_LAYER)
	active_typing_indicator.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	add_overlay(active_typing_indicator)

/** Removes the typing indicator over the mob. */
/obj/effect/overlay/aiholo/proc/remove_typing_indicator()
	if(!active_typing_indicator)
		return FALSE
	cut_overlay(active_typing_indicator)
	active_typing_indicator = null
