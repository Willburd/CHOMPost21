/datum/decl/emote/audible/synth/rstartup
	key = "startup"
	emote_message_1p = "You startup."
	emote_message_3p = "chimes to life."
	emote_sound = 'modular_zubbers/code/modules/emotes/sound/synth_voice/synth_startup.ogg'
	emote_delay = 2 SECONDS

/datum/decl/emote/audible/synth/rshutdown
	key = "shutdown"
	emote_message_1p = "You shutdown."
	emote_message_3p = "emits a nostalgic tone as they fall silent."
	emote_sound = 'modular_zubbers/code/modules/emotes/sound/synth_voice/synth_shutdown.ogg'
	emote_delay = 2 SECONDS

/datum/decl/emote/audible/synth/error
	key = "error"
	emote_message_1p = "You perform an illegal operation."
	emote_message_3p = "experiences a system error."
	emote_sound = 'modular_zubbers/code/modules/emotes/sound/synth_voice/synth_error.ogg'
	emote_delay = 2 SECONDS

/datum/decl/emote/audible/kweh
	key = "kweh"
	emote_message_3p = "kwehs out loud!"
	sound_vary = TRUE

/datum/decl/emote/audible/kweh/get_emote_sound(mob/living/user)
	return list(
			"sound" = pick('modular_zubbers/code/modules/emotes/sound/raptor/raptor_1.ogg',
				'modular_zubbers/code/modules/emotes/sound/raptor/raptor_4.ogg',
				'modular_zubbers/code/modules/emotes/sound/raptor/raptor_5.ogg'),
			"vol" =   emote_volume
		)

/datum/decl/emote/audible/kweh_sad
	key = "skweh"
	emote_message_3p = "kwehs sadly"
	sound_vary = TRUE

/datum/decl/emote/audible/kweh_sad/get_emote_sound(mob/living/user)
	return list(
			"sound" = pick('modular_zubbers/code/modules/emotes/sound/raptor/raptor_2.ogg',
				'modular_zubbers/code/modules/emotes/sound/raptor/raptor_3.ogg'),
			"vol" =   emote_volume
		)
