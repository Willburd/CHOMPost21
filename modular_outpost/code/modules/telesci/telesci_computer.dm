GLOBAL_VAR_INIT(telescience_failures,0)

/obj/machinery/computer/telescience/telefail()
	COOLDOWN_START(src, teleport_cooldown, (2 SECONDS))

	var/turf/pad_turf = get_turf(telepad)
	if(!pad_turf || !length(crystals))
		sparks()
		visible_message(span_warning("The telepad weakly fizzles."))
		return

	GLOB.telescience_failures++ // Lets keep some of the major failures a punishment for abusing the tsci pad instead of literally the first failure releasing a tesla
	switch(rand(99))
		if(0 to 70)
			sparks()
			visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(71 to 80)
			// Irradiate everyone in telescience!
			sparks()
			if(GLOB.telescience_failures > 6)
				for(var/mob/living/carbon/human/M in viewers(7, src))
					M.apply_effect((rand(10, 20)), IRRADIATE, 0)
					to_chat(M, span_warning("You feel strange."))
			else
				visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(81 to 92)
			// EMP
			sparks()
			if(GLOB.telescience_failures > 12)
				empulse(pad_turf, 4, 16)
			else
				visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(93)
			// organ removal
			sparks()
			if(GLOB.telescience_failures > 6)
				var/mob/living/carbon/human/H = locate() in range(7, src)
				if(!ishuman(H))
					return
				var/obj/item/organ/O = H.get_organ(pick(O_APPENDIX, O_BUTT, O_INTESTINE, O_LIVER, O_EYES, O_SPLEEN, O_KIDNEYS, O_LUNGS))
				if(!O)
					return
				O.removed()
				O.forceMove(pad_turf)
			else
				visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(94)
			// Merp
			sparks()
			new /mob/living/simple_mob/vore/alienanimals/jil(pad_turf)
			return

		if(95)
			// Burninate
			sparks()
			pad_turf.lingering_fire(5)
			return

		if(96)
			// Ladytesla
			sparks()
			if(prob(5) && GLOB.telescience_failures > 25) // This exists purely for anyone abusing...
				var/obj/singularity/energy_ball/ball = new(pad_turf)
				ball.energy = rand(5,10)
			else
				new /obj/item/toy/spinningtoy(pad_turf)
			return

		if(97)
			// Grabs operator or anyone funny nearby
			sparks()
			var/mob/living/L = locate() in range(9, src)
			if(L)
				do_teleport(L, pad_turf)
			return

		if(98)
			// Blast thy ass
			sparks()
			if(GLOB.telescience_failures > 15)
				explosion(pad_turf, 1, 1, 2, 2)
			else
				visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(99)
			// Classic kudzu
			sparks()
			visible_message(span_warning("The telepad changes colors rapidly, and opens a portal, and you see what your mind seems to think is the very threads that hold the pattern of the universe together, and a eerie sense of paranoia creeps into you."))
			spacevine_infestation()
			return
