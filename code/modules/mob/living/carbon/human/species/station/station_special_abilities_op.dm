/mob/living/proc/super_fart()
	set name = "Super Fart"
	set desc = "Release a horrifying wave of your presence, or just be a giant asshole."
	set category = "Abilities"

	// Please, lets just keep this as a joke.
	var/mob/living/carbon/human/C = src
	if(C.stat == DEAD)
		to_chat(C,"<span class='notice'>The dead cannot toot!</span>")
		return

	// find butt
	var/obj/item/organ/internal/butt/Bu = locate() in C.internal_organs
	if(!Bu)
		to_chat(C,"<span class='notice'>Try as you might, you cannot toot without a butt to toot toots from!</span>")
		return
	Bu.structural_integrity -= rand(1,6)
	if(Bu.structural_integrity < 0)
		Bu.structural_integrity = 0

	var/deathmessage = ""
	C.gutdeathpressure += 1
	var/range = 5 + C.gutdeathpressure
	// obnoxious, and eventually fatal
	playsound(C, 'sound/effects/poot.ogg', 100, 1)
	for(var/mob/M in living_mobs(range))
		var/dist = get_dist(M.loc, src.loc)
		shake_camera(M, dist > 8 ? 3 : 5, dist > 10 ? 1 : 3)
		if(M != src)
			M.Stun(1)

	var/findholybook
	if(isturf(C.loc))
		var/turf/T = C.loc
		// release gas
		var/datum/gas_mixture/air_contents = new
		air_contents.temperature = C.bodytemperature
		air_contents.gas["methane"] = 0.07 * MOLES_CELLSTANDARD
		T.assume_air(air_contents)
		// hell toot
		for(var/obj/item/weapon/storage/bible/B in T.contents)
			findholybook = B
			break
	if(findholybook)
		var/list/redexitlist = list()
		var/list/hellexitlist = list()
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "hell")
				hellexitlist += R
			if(R.name == "redentrance")
				redexitlist += R
		// shakey
		for(var/mob/M in living_mobs(range))
			shake_camera(M, 5, 3)
			if(M != src)
				M.Stun(3)
		// sparky
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(5, 0, src)
		sparks.attach(C.loc)
		sparks.start()
		// send em to hell, or redspace if none exists... or just gib them
		if(hellexitlist.len > 0)
			var/obj/effect/landmark/pick_exit = pick(hellexitlist)
			C.forceMove(pick_exit.loc)
		else if(redexitlist.len > 0)
			var/obj/effect/landmark/pick_exit = pick(redexitlist)
			C.forceMove(pick_exit.loc)
		else
			C.gib()
		deathmessage = " and toots out of time and space"
	// death toot
	else if(Bu.structural_integrity < 75)
		if(prob((100 - Bu.structural_integrity) / 5))
			for(var/mob/M in living_mobs(range))
				shake_camera(M, 5, 3)
				if(M != src)
					M.Stun(8)
			if(Bu.structural_integrity < 20)
				C.gib()
				deathmessage = " and explodes"
			else
				Bu.assblasted()
				C.AdjustWeakened(10)
				C.halloss = 30
				C.emote("scream")
				deathmessage = " and explodes their butt off"
	// lights rattled or bursted
	for(var/obj/machinery/light/L in orange(10, C))
		if(prob(C.gutdeathpressure * 2))
			spawn(rand(5,25))
				L.broken()
		else
			L.flicker(4)
	C.visible_message("<span class='danger'>\The [C] unleashes a violent and obnoxious blast from their rear[deathmessage]!</span>","<span class='danger'>You unleash the horrifying power of your rump!</span>");
