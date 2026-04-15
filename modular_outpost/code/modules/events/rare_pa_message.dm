/datum/event/rare_pa_message
	announceWhen	= 90
	var/static/list/common_messages = list(
		'modular_outpost/sound/AI/distant/biowaste_burning.ogg',
		'modular_outpost/sound/AI/distant/bondingsites.ogg',
		'modular_outpost/sound/AI/distant/disposalcleaning.ogg',
		'modular_outpost/sound/AI/distant/electrical_diagnostic.ogg',
		'modular_outpost/sound/AI/distant/extrasealant.ogg',
		'modular_outpost/sound/AI/distant/gaming.ogg',
		'modular_outpost/sound/AI/distant/geoshifting.ogg',
		'modular_outpost/sound/AI/distant/groundwatertest.ogg',
		'modular_outpost/sound/AI/distant/hydraulictesting.ogg',
		'modular_outpost/sound/AI/distant/lostdrone.ogg',
		'modular_outpost/sound/AI/distant/regularbackups.ogg',
		'modular_outpost/sound/AI/distant/safetyseminar.ogg',
		'modular_outpost/sound/AI/distant/strainpressure.ogg',
		'modular_outpost/sound/AI/distant/strata_analysis.ogg',
		'modular_outpost/sound/AI/distant/no_entry.ogg',
	)
	var/static/list/rare_messages = list(
		'modular_outpost/sound/AI/distant/aggressive_door.ogg',
		'modular_outpost/sound/AI/distant/androidhell.ogg',
		'modular_outpost/sound/AI/distant/donk.ogg',
		'modular_outpost/sound/AI/distant/donkordont.ogg',
		'modular_outpost/sound/AI/distant/dontdiestupid.ogg',
		'modular_outpost/sound/AI/distant/doorstuck.ogg',
		'modular_outpost/sound/AI/distant/droids_monthly.ogg',
		'modular_outpost/sound/AI/distant/feelings.ogg',
		'modular_outpost/sound/AI/distant/fulltime.ogg',
		'modular_outpost/sound/AI/distant/mar.ogg',
		'modular_outpost/sound/AI/distant/surprises.ogg',
		'modular_outpost/sound/AI/distant/veymedshuttle.ogg',
	)

/datum/event/rare_pa_message/setup()
	announceWhen = rand(5,15)

/datum/event/rare_pa_message/announce()
	var/message = pick(common_messages)
	if(prob(5))
		message = pick(rare_messages)
	// Send em out
	for(var/mob/player in GLOB.player_list)
		var/area/in_area = get_area(player)
		if(!player.client)
			continue
		if(world.time < GLOB.last_outpost_announcer_voice + (20 SECONDS))
			continue
		if(prob(30))
			continue
		if(area_is_outpost_announcer_valid(in_area))
			var/sound/our_message = new(message)
			our_message.volume = 2 * player.client.get_preference_volume_channel(VOLUME_CHANNEL_MASTER)
			our_message.environment = SOUND_ENVIRONMENT_SEWER_PIPE
			SEND_SOUND(player, our_message)
			GLOB.last_outpost_announcer_voice = world.time


// Don't spam it
GLOBAL_VAR_INIT(last_outpost_announcer_voice, 0)

/proc/area_is_outpost_announcer_valid(area/in_area)
	if(GLOB.current_announcer_voice != ANNOUNCER_VOICE_OUTPOST)
		return FALSE // We don't want to hear this voice
	if(!in_area)
		return FALSE
	return in_area.holomap_color == HOLOMAP_AREACOLOR_ARRIVALS || in_area.holomap_color == HOLOMAP_AREACOLOR_CIV || in_area.holomap_color == HOLOMAP_AREACOLOR_ENGINEERING || in_area.holomap_color == HOLOMAP_AREACOLOR_MEDICAL || in_area.holomap_color == HOLOMAP_AREACOLOR_SCIENCE || in_area.holomap_color == HOLOMAP_AREACOLOR_SECURITY || in_area.holomap_color == HOLOMAP_AREACOLOR_COMMAND || in_area.holomap_color == HOLOMAP_AREACOLOR_CARGO || in_area.holomap_color == HOLOMAP_AREACOLOR_HALLWAYS || in_area.holomap_color == HOLOMAP_AREACOLOR_HYDROPONICS
