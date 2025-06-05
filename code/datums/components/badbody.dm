
// Controller for body logic, instead of shoving more things into mob/living/carbon/human
/datum/component/badbody
	VAR_PRIVATE/mob/living/carbon/human/body
	VAR_PRIVATE/next_speak = 0
	VAR_PRIVATE/next_spooky = 0
	VAR_PRIVATE/long_delay_mode = FALSE
	VAR_PRIVATE/start_x = 0
	VAR_PRIVATE/start_y = 0

/datum/component/badbody/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	body = parent
	start_x = body.loc.x
	start_y = body.loc.y
	RegisterSignal(body, COMSIG_LIVING_LIFE, PROC_REF(process_component))

/datum/component/badbody/Destroy(force = FALSE)
	UnregisterSignal(body, COMSIG_LIVING_LIFE)
	body = null
	. = ..()

/datum/component/badbody/proc/process_component()
	if(QDELETED(src))
		return
	if(!isnull(body.client))
		SShaunting.reset_world_haunt() // Clean out for now
		qdel(src)
		return
	if(!isnull(body.client))
		body.UnsetSpecialVoice()

	var/speak = ""
	if(!long_delay_mode)
		// Await rescue
		if(next_speak == 0)
			next_speak = world.time + rand(400,2000)
			speak = pick(";Where am I?",";Hello, is anyone there?",";Why is it dark?",";Can anyone hear me?")
		else if(world.time >= next_speak)
			next_speak = world.time + rand(900,3000)
			speak = pick("Please help, I'm scared.","Where am I?","Please, I'm lost","I don't know where I am.","Where am I?","Please help.","Please help!","Help me!","Help me please!","I don't want to die!","It hurts!","I can't feel my legs.","I'm lost.","Don't leave me alone!","Come back please!")
			if(prob(30))
				speak = ";" + speak
		if(speak != "")
			if(istype( body.loc, /obj/structure/morgue) && prob(20))
				long_delay_mode = TRUE
				next_speak = world.time + rand(1000,7000)
				next_spooky = world.time + rand(700,1200)
				return
			else if(start_x != body.x || start_y != body.y)
				long_delay_mode = TRUE
				next_speak = world.time + rand(1000,7000)
				next_spooky = world.time + rand(700,1200)
				return
	else
		// Spooky everyone!
		if(world.time >= next_spooky)
			next_spooky = do_a_spooky(body)
			SShaunting.influence(HAUNTING_GHOSTS)
		// Time to spook medical
		if(world.time >= next_speak)
			next_speak = world.time + rand(1000,7000)
			if(istype(body.loc,/obj/structure/morgue))
				speak = pick("So cold...","Please...","Help me...","I can't move...","Let me out...","It hurts...","Cold...","So cold, it hurts...")
				if(prob(40))
					speak = ";" + speak
			else if(prob(50))
				speak = pick("Stop...","It hurts...","It's inside...","Take it out","Kill me...","Help me...","Why...","Let me out...","I can't take it!","Stop!","Help!","Please stop!","It hurts!","Let me die!")
				if(prob(10))
					speak = ";" + speak

	if(speak != "")
		body.visible_message( span_warning("\The [body] [pick("shudders","cracks","snaps","crunches","twitches")] and speaks."))
		deadsay(speak)
		SShaunting.influence(HAUNTING_GHOSTS)

// Hacky, but I refused to rewrite say code just for this
/datum/component/badbody/proc/deadsay(var/speak)
	var/old_stat = body.stat
	body.stat = CONSCIOUS
	if(prob(20)) // Some variety
		body.stuttering = 100
	else
		body.stuttering = 0
	body.say(speak, whispering = prob(80))
	body.stat = old_stat
// End hacky

/datum/component/badbody/proc/do_a_spooky()
	// Randomly do stuff to scare people
	var/area/A = get_area(body.loc)
	switch(rand(1,7))
		if(1)
			if(start_x == body.loc.x && start_y == body.loc.y)
				long_delay_mode = FALSE // Return to no events, start crying again
			start_x = body.loc.x
			start_y = body.loc.y
			// long delay
			return world.time + rand(1200,2000)
		if(2)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/machinery/light_switch/L in get_area_all_atoms(A))
						L.attack_hand(body)
						break
			return world.time + rand(700,1200)
		if(3)
			if(istype( body.loc, /obj/structure/morgue) )
				var/obj/structure/morgue/M = body.loc
				M.open()
			else if(istype( body.loc, /obj/structure/closet) )
				var/obj/structure/closet/C = body.loc
				if(C.req_breakout())
					C.container_resist(body)
				else
					C.toggle()
			else if(body.buckled)
				body.resist()
			else
				body.IMove(get_step(body.loc,pick(GLOB.cardinal)))
			return world.time + rand(100,500)
		if(4)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/machinery/light/L in get_area_all_atoms(A))
						if(L.z != body.z || get_dist(src,L) > 4)
							continue
						L.flicker(3)
			return world.time + rand(700,1200)
		if(5)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/item/radio/intercom/R in get_area_all_atoms(A))
						if(!R.listening)
							R.ToggleReception()
			return world.time + rand(700,1200)
		if(6)
			body.visible_message( span_danger("\The [body] [pick("shudders","cracks","snaps","crunches","twitches")] and screams!"))
			// Hacky, but I refused to rewrite say code just for this
			var/old_stat = body.stat
			body.stat = CONSCIOUS
			body.say("*scream")
			body.stat = old_stat
			// End hacky
			return world.time + rand(700,1200)
		if(7)
			if(prob(10))
				body.UnsetSpecialVoice()
			return world.time + rand(700,1200)
