/*
	output_atoms	(list of atoms)			The destination(s) for the sounds

	mid_sounds		(list or soundfile)		Since this can be either a list or a single soundfile you can have random sounds. May contain further lists but must contain a soundfile at the end.
	mid_length		(num)					The length to wait between playing mid_sounds

	start_sound		(soundfile)				Played before starting the mid_sounds loop
	start_length	(num)					How long to wait before starting the main loop after playing start_sound

	end_sound		(soundfile)				The sound played after the main loop has concluded

	chance			(num)					Chance per loop to play a mid_sound
	volume			(num)					Sound output volume
	muted			(bool)					Private. Used to stop the sound loop.
	max_loops		(num)					The max amount of loops to run for.
	direct			(bool)					If true plays directly to provided atoms instead of from them
	opacity_check	(bool)					If true, things behind walls/opaque things won't hear the sounds.
	pref_check		(type)					If set to a /datum/client_preference type, will check if the hearer has that preference active before playing it to them.
	volume_chan		(type)					If set to a specific volume channel via the incoming argument, we tell the playsound proc to modulate volume based on that channel //CHOMPedit
	exclusive		(bool)					If true, only one of this sound is allowed to play. Relies on if started is true or not. If true, it will not start another loop until it is false.
	extends_time	(bool)					Outpost 21 edit - Playing while looping refreshes start time of loop, used for sounds played during constant movement, that stop when movement stops.
*/
/datum/looping_sound
	var/list/atom/output_atoms
	var/mid_sounds
	var/mid_length
	var/start_sound
	var/start_length
	var/end_sound
	var/chance
	var/volume = 100
	var/max_loops
	var/direct
	var/vary
	var/extra_range
	var/opacity_check
	var/pref_check
	var/exclusive
	var/falloff // CHOMPEdit: Add Falloff
	var/volume_chan
	var/extends_time // Outpost 21 edit

	var/timerid
	var/started
	var/refreshed // Outpost 21 edit

/datum/looping_sound/New(list/_output_atoms=list(), start_immediately=FALSE, disable_direct=FALSE)
	if(!mid_sounds)
		WARNING("A looping sound datum was created without sounds to play.")
		return

	output_atoms = _output_atoms
	if(disable_direct)
		direct = FALSE

	if(start_immediately)
		start()

/datum/looping_sound/Destroy()
	stop()
	output_atoms = null
	return ..()

/datum/looping_sound/proc/start(atom/add_thing, skip_start_sound = FALSE)
	if(QDELETED(src)) //Chomp runtime
		return //Chomp runtime
	if(add_thing)
		output_atoms |= add_thing
	// Outpost 21 edit begin - Extending runtime loops
	if(extends_time && max_loops)
		refreshed = TRUE
	// Outpost 21 edit end
	if(timerid)
		return
	if(skip_start_sound && (!exclusive && !started)) // Skip start sounds optionally, check if we're exclusive AND started already
		sound_loop()
		started = TRUE
		return
	if(exclusive && started) // Prevents a sound from starting multiple times
		return // Don't start this loop.
	on_start()
	started = TRUE

/datum/looping_sound/proc/stop(atom/remove_thing, skip_stop_sound = FALSE)
	if(remove_thing)
		output_atoms -= remove_thing
	if(!timerid)
		return
	if(!skip_stop_sound)
		on_stop()
	deltimer(timerid)
	timerid = null
	started = FALSE

/datum/looping_sound/proc/sound_loop(starttime)
	// Outpost 21 edit begin - Extending runtime loops
	if(refreshed)
		starttime = world.time
		refreshed = FALSE
	// Outpost 21 edit end
	if(QDELETED(src) || (max_loops && world.time >= starttime + mid_length * max_loops)) //ChompEDIT - runtime
		stop()
		return
	if(!chance || prob(chance))
		play(get_sound(starttime))
	if(!timerid)
		timerid = addtimer(CALLBACK(src, PROC_REF(sound_loop), world.time), mid_length, TIMER_STOPPABLE | TIMER_LOOP)

/datum/looping_sound/proc/play(soundfile)
	var/list/atoms_cache = output_atoms
	var/sound/S = sound(soundfile)
	if(direct)
		S.channel = SSsounds.random_available_channel()
		S.volume = volume
	for(var/i in 1 to atoms_cache?.len) //Chomp - runtime
		var/atom/thing = atoms_cache[i]
		if(direct)
			if(ismob(thing))
				var/mob/M = thing
				if(!M.check_sound_preference(pref_check))
					continue
			SEND_SOUND(thing, S)
		else
			playsound(thing, S, volume, vary, extra_range, falloff = falloff, ignore_walls = !opacity_check, preference = pref_check, volume_channel = volume_chan) // CHOMPEdit - Weather volume channel CHOMPEdit again: falloff

/datum/looping_sound/proc/get_sound(starttime, _mid_sounds)
	if(!_mid_sounds)
		. = mid_sounds
	else
		. = _mid_sounds
	while(!isfile(.) && !isnull(.))
		. = pickweight(.)

/datum/looping_sound/proc/on_start()
	var/start_wait = 1 // On TG this is 0, however it needs to be 1 to work around an issue.
	if(start_sound)
		play(start_sound)
		start_wait = start_length
	addtimer(CALLBACK(src, PROC_REF(sound_loop)), start_wait)

/datum/looping_sound/proc/on_stop()
	if(end_sound)
		play(end_sound)
