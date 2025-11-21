GLOBAL_LIST_INIT(runtimes_in_world,list()) // the cat!
GLOBAL_VAR_INIT(last_runtime_meow,0)
GLOBAL_VAR_INIT(hyperspeed_runtime_meows,0)

/proc/outpost_trigger_runtime()
	if(!GLOB.runtimes_in_world.len)
		return
	// small delay between meows, but if we get over 1000 errors in 5 ticks, runtime gibs
	if(world.time < (GLOB.last_runtime_meow + (1 SECOND)))
		GLOB.hyperspeed_runtime_meows++
		if(GLOB.hyperspeed_runtime_meows >= 35)
			var/mob/living/simple_mob/animal/passive/cat/runtime/C = pick(GLOB.runtimes_in_world)
			playsound(C,'sound/voice/meow.ogg',90)
			C.visible_message("\The [C] meows!")
			C.gib()
			GLOB.hyperspeed_runtime_meows = 0
		return
	// Normal handling
	GLOB.hyperspeed_runtime_meows = 0 // Reset
	GLOB.last_runtime_meow = world.time
	for(var/mob/living/simple_mob/animal/passive/cat/runtime/C in GLOB.runtimes_in_world)
		playsound(C,'sound/voice/meow.ogg',60)
		C.visible_message("\The [C] meows!")
		if(prob(1) && prob(5))
			new /mob/living/simple_mob/animal/passive/cat/kitten(get_turf(C))
