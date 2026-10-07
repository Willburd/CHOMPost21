/datum/decl/emote/audible/woo
	key = "woo"
	emote_message_3p = "woo!"
	emote_sound = 'modular_outpost/sound/voice/WOO.ogg'

/datum/decl/emote/audible/synth/rberr
	key = "rberr"
	emote_message_3p = "de-doos."
	emote_sound = 'modular_outpost/sound/misc/rberr.ogg'

/datum/decl/emote/audible/synth/rbpos
	key = "rbpos"
	emote_message_3p = "do-dees."
	emote_sound = 'modular_outpost/sound/misc/rbpos.ogg'

/datum/decl/emote/audible/concrete_grind
	key = "grindingrealization"
	emote_message_3p = "slowly turns with dreadful realization"
	emote_sound = 'modular_outpost/sound/voice/concrete_scrape_loop.ogg'

/datum/decl/emote/audible/gorp
	key = "gorp"
	emote_message_3p = "gorp!"
	emote_sound = 'modular_outpost/sound/voice/gorp.ogg'

/datum/decl/emote/audible/expiewhine
	key = "expwhine"
	emote_message_3p = "whines."
	sound_vary = TRUE

/datum/decl/emote/audible/expiewhine/get_emote_sound(mob/living/user)
	return list(
			"sound" = pick(
				'modular_outpost/sound/voice/expie/exp5.ogg',
				'modular_outpost/sound/voice/expie/exp6.ogg',
				'modular_outpost/sound/voice/expie/exp7.ogg',
				'modular_outpost/sound/voice/expie/exp8.ogg',
				'modular_outpost/sound/voice/expie/exp9.ogg',
				'modular_outpost/sound/voice/expie/exp10.ogg',
				'modular_outpost/sound/voice/expie/exp11.ogg',
				'modular_outpost/sound/voice/expie/exp12.ogg',
				'modular_outpost/sound/voice/expie/exp13.ogg',
				'modular_outpost/sound/voice/expie/exp14.ogg',
				'modular_outpost/sound/voice/expie/exp15.ogg',
				'modular_outpost/sound/voice/expie/exp16.ogg',
				'modular_outpost/sound/voice/expie/exp17.ogg'),
			"vol" =   emote_volume
		)
