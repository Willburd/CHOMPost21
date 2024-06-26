/decl/emote/visible/kiss
	key = "kiss"
	emote_message_1p_target = "You kiss TARGET!"
	emote_message_1p = "You blow kisses!"
	emote_message_3p_target = "kisses TARGET!"
	emote_message_3p = "blows kisses!"
	check_range = 1

/decl/emote/visible/kiss/New()
	..()
	emote_message_1p_target = SPAN_WARNING(emote_message_1p_target)
	emote_message_1p =        SPAN_WARNING(emote_message_1p)
	emote_message_3p_target = SPAN_WARNING(emote_message_3p_target)
	emote_message_3p =        SPAN_WARNING(emote_message_3p)

/decl/emote/visible/dab
	key = "dab"
	emote_message_3p_target = SPAN_WARNING("dabs at TARGET.")
	emote_message_3p = SPAN_WARNING("dabs.")
