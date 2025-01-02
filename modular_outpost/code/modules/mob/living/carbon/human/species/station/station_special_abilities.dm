/mob/living/proc/super_fart()
	set name = "Super Fart"
	set desc = "Release a horrifying wave of your presence, or just be a giant asshole."
	set category = "Superpower"

	// Please, lets just keep this as a joke.
	var/mob/living/carbon/human/C = src
	if(C.stat == DEAD)
		to_chat(C,span_notice("The dead cannot toot!"))
		return

	// find butt
	var/obj/item/organ/internal/butt/Bu = locate() in C.internal_organs
	if(!Bu)
		to_chat(C,span_notice("Try as you might, you cannot toot without a butt to toot toots from!"))
		return
	if(!Bu.can_super_fart())
		to_chat(C,span_notice("Your butt's safety limiter prevents your tooter from tooting!"))
		return
	Bu.structural_integrity -= rand(1,6)
	if(Bu.structural_integrity < 0)
		Bu.structural_integrity = 0

	var/deathmessage = ""
	C.gutdeathpressure += 1
	var/range = 5 + C.gutdeathpressure
	// obnoxious, and eventually fatal
	playsound(C, 'modular_outpost/sound/effects/poot.ogg', 100, 1)
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
		air_contents.gas[GAS_CH4] = 0.07 * MOLES_CELLSTANDARD
		T.assume_air(air_contents)
		// hell toot
		for(var/obj/item/storage/bible/B in T.contents)
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
	// Propel!
	var/movementdirection = src.dir
	if(buckled && isobj(buckled))
		spawn(0)
			if(!buckled.anchored)
				var/obj/structure/bed/chair/CH
				if(istype(buckled, /obj/structure/bed/chair))
					CH = buckled
				var/list/move_speed = list(1, 1, 1, 2, 2, 3)
				for(var/i in 1 to 6)
					if(CH) CH.propelled = (6-i)
					buckled.Move(get_step(src,movementdirection), movementdirection)
					sleep(move_speed[i])
				//additional movement
				for(var/i in 1 to 3)
					buckled.Move(get_step(src,movementdirection), movementdirection)
					sleep(3)
	if((istype(loc, /turf/space)) || (lastarea.get_gravity() == 0))
		inertia_dir = movementdirection
		step(src, movementdirection)
	// lights rattled or bursted
	for(var/obj/machinery/light/L in orange(10, C))
		if(prob(C.gutdeathpressure * 2))
			spawn(rand(5,25))
				L.broken()
		else
			L.flicker(4)
	C.visible_message(span_danger("\The [C] unleashes a violent and obnoxious blast from their rear[deathmessage]!"),span_danger("You unleash the horrifying power of your rump!"));

/mob/living/proc/super_fart_flame()
	if(stat != DEAD)
		var/obj/item/projectile/P = new /obj/item/projectile/bullet/dragon(get_turf(src))
		playsound(src, "sound/weapons/Flamer.ogg", 50, 1)
		// configure to be less broken! We're only a flamethrower, not a dragon!
		P.submunition_spread_max = 40
		P.submunition_spread_min = 25
		P.submunitions = list(/obj/item/projectile/bullet/incendiary/dragonflame = 3)
		// launch!
		P.launch_projectile( get_step(src,reverse_dir[src.dir]), BP_TORSO, src)
