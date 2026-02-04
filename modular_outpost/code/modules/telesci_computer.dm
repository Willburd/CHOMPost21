
/obj/machinery/computer/telescience/telefail()
	COOLDOWN_START(src, teleport_cooldown, (2 SECONDS))

	var/turf/pad_turf = get_turf(telepad)
	if(!pad_turf)
		sparks()
		visible_message(span_warning("The telepad weakly fizzles."))
		return

	switch(crystals.len > 0 ? rand(99) : 0)
		if(0 to 70)
			sparks()
			visible_message(span_warning("The telepad weakly fizzles."))
			return

		if(71 to 80)
			// Irradiate everyone in telescience!
			sparks()
			for(var/mob/living/carbon/human/M in viewers(7, src))
				M.apply_effect((rand(10, 20)), IRRADIATE, 0)
				to_chat(M, span_warning("You feel strange."))
			return

		if(81 to 92)
			// EMP
			sparks()
			empulse(pad_turf, 4, 16)
			return

		if(93)
			// organ removal
			sparks()
			var/mob/living/carbon/human/H = locate() in range(7, src)
			if(!ishuman(H))
				return
			var/obj/item/organ/O = H.get_organ(pick(O_APPENDIX, O_BUTT, O_INTESTINE, O_LIVER, O_EYES, O_SPLEEN, O_KIDNEYS, O_LUNGS))
			if(!O)
				return
			O.removed()
			O.forceMove(pad_turf)
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
			if(prob(5))
				new /obj/item/toy/spinningtoy(pad_turf)
			else
				var/obj/singularity/energy_ball/ball = new(pad_turf)
				ball.energy = rand(10,40)
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
			explosion(pad_turf, 1, 1, 2, 2)
			return

		if(99)
			// Classic kudzu
			sparks()
			visible_message(span_warning("The telepad changes colors rapidly, and opens a portal, and you see what your mind seems to think is the very threads that hold the pattern of the universe together, and a eerie sense of paranoia creeps into you."))
			spacevine_infestation()
			return
