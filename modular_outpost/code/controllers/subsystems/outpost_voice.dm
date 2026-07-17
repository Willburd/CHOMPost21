SUBSYSTEM_DEF(outpost_voice)
	name = "Outpost Voice"
	flags = SS_NO_FIRE | SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	dependencies = list(
		/datum/controller/subsystem/atoms
	)
	var/list/voice_lines = list(
		// counters
		"zero" = list('modular_outpost/sound/AI/fragments/0.ogg', 0.8 SECOND),
		"one" = list('modular_outpost/sound/AI/fragments/1.ogg', 0.8 SECOND),
		"two" = list('modular_outpost/sound/AI/fragments/2.ogg', 0.8 SECOND),
		"three" = list('modular_outpost/sound/AI/fragments/3.ogg', 0.8 SECOND),
		"four" = list('modular_outpost/sound/AI/fragments/4.ogg', 0.8 SECOND),
		"five" = list('modular_outpost/sound/AI/fragments/5.ogg', 0.8 SECOND),
		"six" = list('modular_outpost/sound/AI/fragments/6.ogg', 0.8 SECOND),
		"seven" = list('modular_outpost/sound/AI/fragments/7.ogg', 0.8 SECOND),
		"eight" = list('modular_outpost/sound/AI/fragments/8.ogg', 0.8 SECOND),
		"nine" = list('modular_outpost/sound/AI/fragments/9.ogg', 0.8 SECOND),
		"ten" = list('modular_outpost/sound/AI/fragments/10.ogg', 0.8 SECOND),
		"twenty" = list('modular_outpost/sound/AI/fragments/20.ogg', 0.8 SECOND),
		"thirty" = list('modular_outpost/sound/AI/fragments/30.ogg', 0.8 SECOND),
		"fourty" = list('modular_outpost/sound/AI/fragments/40.ogg', 0.8 SECOND),
		"fifty" = list('modular_outpost/sound/AI/fragments/50.ogg', 0.8 SECOND),
		// "sixty" = list('modular_outpost/sound/AI/fragments/60.ogg', 1 SECOND),
		"seventy" = list('modular_outpost/sound/AI/fragments/70.ogg', 0.8 SECOND),
		"eighty" = list('modular_outpost/sound/AI/fragments/80.ogg', 0.8 SECOND),
		"ninty" = list('modular_outpost/sound/AI/fragments/90.ogg', 0.8 SECOND),
		"hundred" = list('modular_outpost/sound/AI/fragments/100.ogg', 0.8 SECOND),
		// timing
		"seconds" = list('modular_outpost/sound/AI/fragments/seconds.ogg', 0.8 SECOND),
		"minutes" = list('modular_outpost/sound/AI/fragments/minutes.ogg', 0.8 SECOND),
		"minute" = list('modular_outpost/sound/AI/fragments/minute.ogg', 0.8 SECOND),
		"hours" = list('modular_outpost/sound/AI/fragments/hours.ogg', 0.8 SECOND),
		// events
		"to_detonation" = list('modular_outpost/sound/AI/fragments/to_detonation.ogg', 1.2 SECOND),
		"to_impact" = list('modular_outpost/sound/AI/fragments/to_impact.ogg', 1.2 SECOND),
		"bsa_test" = list('modular_outpost/sound/AI/fragments/bsa_test.ogg', 2 SECOND),
	)
	var/list/number_to_id = list(
		"0" = "zero",
		"1" = "one",
		"2" = "two",
		"3" = "three",
		"4" = "four",
		"5" = "five",
		"6" = "six",
		"7" = "seven",
		"8" = "eight",
		"9" = "nine",
		"10" = "ten",
		"20" = "twenty",
		"30" = "thirty",
		"40" = "fourty",
		"50" = "fifty",
		"60" = "sixty",
		"70" = "seventy",
		"80" = "eighty",
		"90" = "ninty",
		"100" = "hundred"
	)

/datum/controller/subsystem/outpost_voice/proc/play_voice_clip(id)
	var/list/line_data = voice_lines[id]
	if(!line_data)
		return 0
	var/list/zlevels = using_map.station_levels
	PlaySound(line_data[1], zlevels)
	return line_data[2]

/datum/controller/subsystem/outpost_voice/proc/PlaySound(message_sound, list/zlevels)
	for(var/mob/M in GLOB.player_list)
		if(zlevels && !(M.z in zlevels))
			continue
		if(!isnewplayer(M) && !isdeaf(M))
			SEND_SOUND(M, message_sound)

/datum/controller/subsystem/outpost_voice/proc/play_sentance(list/sentance)
	// Play each word in the voice sentance
	var/voice_id = sentance[1]
	var/delay = play_voice_clip(voice_id)
	// Remove the first and move on
	sentance[1] = null
	sentance -= null
	if(!length(sentance))
		return
	addtimer(CALLBACK(src, PROC_REF(play_sentance), sentance), delay)

/datum/controller/subsystem/outpost_voice/proc/assemble_sequence(list/clip_list, post_delay)
	return list(list(clip_list, post_delay)) // Wrapped list for easy sequence addition

/datum/controller/subsystem/outpost_voice/proc/play_sequence(list/full_sequence)
	var/list/sequence_data = full_sequence[1]
	play_sentance(sequence_data[1])
	var/delay = sequence_data[2]
	// Next sequence
	full_sequence[1] = null
	full_sequence -= null
	if(!length(full_sequence))
		return
	addtimer(CALLBACK(src, PROC_REF(play_sequence), full_sequence), delay)

/datum/controller/subsystem/outpost_voice/proc/event_countdown(minutes, callout_id, do_seconds_countdown)
	var/seq = list()
	while(minutes > 0)
		if(minutes > 1)
			seq += assemble_sequence(list(number_to_id["[minutes]"],"minutes",callout_id), 1 MINUTE)
		else
			seq += assemble_sequence(list(number_to_id["[minutes]"],"minute",callout_id), 10 SECONDS)
		minutes--
	if(do_seconds_countdown) // Final countdown isn't always desired
		seq += assemble_sequence(list("fifty","seconds",callout_id), 10 SECONDS)
		seq += assemble_sequence(list("fourty","seconds",callout_id), 10 SECONDS)
		seq += assemble_sequence(list("thirty","seconds",callout_id), 10 SECONDS)
		seq += assemble_sequence(list("twenty","seconds",callout_id), 10 SECONDS)
		seq += assemble_sequence(list("ten"), 1 SECOND)
		seq += assemble_sequence(list("nine"), 1 SECOND)
		seq += assemble_sequence(list("eight"), 1 SECOND)
		seq += assemble_sequence(list("seven"), 1 SECOND)
		seq += assemble_sequence(list("six"), 1 SECOND)
		seq += assemble_sequence(list("five"), 1 SECOND)
		seq += assemble_sequence(list("four"), 1 SECOND)
		seq += assemble_sequence(list("three"), 1 SECOND)
		seq += assemble_sequence(list("two"), 1 SECOND)
		seq += assemble_sequence(list("one"), 1 SECOND)
		seq += assemble_sequence(list("zero"), 1 SECOND)
	play_sequence(seq)
