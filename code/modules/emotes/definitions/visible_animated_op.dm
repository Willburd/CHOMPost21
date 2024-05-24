/decl/emote/visible/floorspin/tantrum
	key = "tantrum"
	emote_message_1p = "You flail around on the floor screaming!"
	emote_message_3p = "flails around on the floor screaming!"
	emote_sound = 'sound/voice/ragescree.ogg'
	emote_delay = 4.5 SECONDS

/decl/emote/visible/floorspin/tantrum/do_extra(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.Stun(5)
		if(H.jitteriness < 100)
			H.make_jittery(115)
