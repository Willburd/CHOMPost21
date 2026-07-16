/obj/item/toy/maxwell
	name = "Maxwell"
	desc = "What a stupid looking cat."
	var/datum/looping_sound/maxwell/soundloop

/obj/item/toy/maxwell/Initialize(mapload)
	. = ..()
	soundloop = new(list(src), start_immediately = TRUE)

/obj/item/toy/maxwell/Destroy(force, ...)
	QDEL_NULL(soundloop)
	. = ..()

/datum/looping_sound/maxwell
	start_sound = 'modular_outpost/sound/music/Kevin MacLeod - Move Forward.ogg'
	mid_sounds = list('modular_outpost/sound/music/Kevin MacLeod - Move Forward.ogg' = 1)
	start_length = 69 SECONDS
	mid_length = 69 SECONDS
	end_sound = 'modular_outpost/sound/music/Kevin MacLeod - Move Forward.ogg'
	volume = 40
	extra_range = -3 // Short-range
	falloff = 0.1 // Harsh
	volume_chan = VOLUME_CHANNEL_INSTRUMENTS
