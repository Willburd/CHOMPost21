/obj/effect/overlay/aiholo/
	var/typing
	var/obj/effect/decal/typing_indicator
	var/obj/effect/decal/typing_indicator_active
	var/cur_typing_indicator

// Imagine copypasting code again!
/obj/effect/overlay/aiholo/proc/init_typing_indicator(var/set_state = "typing")
	if(typing_indicator)
		qdel(typing_indicator)
		typing_indicator = null
	typing_indicator = new
	typing_indicator.appearance = generate_speech_bubble(null, set_state)
	typing_indicator.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)

/obj/effect/overlay/aiholo/proc/set_typing_indicator(var/state)
	if(!master.is_preference_enabled(/datum/client_preference/show_typing_indicator))
		if(typing_indicator)
			cut_overlay(typing_indicator, TRUE)
		return

	var/cur_bubble_appearance = master.custom_speech_bubble
	if(!cur_bubble_appearance || cur_bubble_appearance == "default")
		cur_bubble_appearance = master.speech_bubble_appearance()
	if(!typing_indicator || cur_typing_indicator != cur_bubble_appearance)
		init_typing_indicator("[cur_bubble_appearance]_typing")

	if(state && !typing)
		add_overlay(typing_indicator, TRUE)
		typing = TRUE
		typing_indicator_active = typing_indicator
	else if(typing)
		cut_overlay(typing_indicator_active, TRUE)
		typing = FALSE
		if(typing_indicator_active != typing_indicator)
			qdel(typing_indicator_active)
		typing_indicator_active = null

	return state
