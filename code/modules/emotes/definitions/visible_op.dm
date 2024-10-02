/decl/emote/visible/kiss
	key = "kiss"
	emote_message_1p_target = "You kiss TARGET!"
	emote_message_1p = "You blow kisses!"
	emote_message_3p_target = "kisses TARGET!"
	emote_message_3p = "blows kisses!"
	check_range = 1

/decl/emote/visible/kiss/New()
	..()
	emote_message_1p_target = span_warning(emote_message_1p_target)
	emote_message_1p =        span_warning(emote_message_1p)
	emote_message_3p_target = span_warning(emote_message_3p_target)
	emote_message_3p =        span_warning(emote_message_3p)

/decl/emote/visible/dab
	key = "dab"

/decl/emote/visible/dab/New()
	emote_message_3p_target = span_warning("dabs on TARGET.")
	emote_message_3p = span_warning("dabs.")
