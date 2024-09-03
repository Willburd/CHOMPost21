/decl/emote/visible/ragescree
	key = "ragescree"
	emote_message_1p = "You begin screaming!"
	emote_message_3p = "begins screaming!"
	emote_sound = 'modular_outpost/sound/voice/ragescree.ogg'
	emote_delay = 4.5 SECONDS

/decl/emote/visible/ragescree/do_extra(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.Stun(5)
		if(H.jitteriness < 100)
			H.make_jittery(115)
