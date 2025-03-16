/mob/living/carbon/human/proc/handle_outpost_disabilities()
	var/anxietymedcount = 0 // DO NOT MIX THESE MEDS
	var/seizuremedcount = 0
	var/antihistaminescount = 0
	if(bloodstr.has_reagent(REAGENT_ID_QERRQUEM,0))
		anxietymedcount += 1;
	if(bloodstr.has_reagent(REAGENT_ID_PAROXETINE,0))
		anxietymedcount += 1;
		seizuremedcount += 1;
	if(bloodstr.has_reagent(REAGENT_ID_CITALOPRAM,0))
		anxietymedcount += 1;
		seizuremedcount += 1;
	if(bloodstr.has_reagent(REAGENT_ID_METHYLPHENIDATE,0))
		anxietymedcount += 1;
		seizuremedcount += 1;
	if(bloodstr.has_reagent(REAGENT_ID_TRICORDRAZINE,0)) // startrek wiki says so
		seizuremedcount += 1;
	if(bloodstr.has_reagent(REAGENT_ID_QUADCORD,0))
		seizuremedcount += 1;
		anxietymedcount += 1;

	// lets check for any one of these... Faster than doing each one, as it'll trigger on the first one it finds instead of checking them all every time
	if( bloodstr.has_reagent(REAGENT_ID_INAPROVALINE,0) || bloodstr.has_reagent(REAGENT_ID_MENTHOL,0) || bloodstr.has_reagent(REAGENT_ID_ADRANOL,0) || bloodstr.has_reagent(REAGENT_ID_IMMUNOSUPRIZINE,0) || bloodstr.has_reagent(REAGENT_ID_MALISHQUALEM,0))
		antihistaminescount += 1; // there is no harm to stacking them as an allergy med, except their own overdoses anyway

	// if no hazardous meds are mixed... just let any of the other ones work...
	if(anxietymedcount == 0)
		if(bloodstr.has_reagent(REAGENT_ID_ADRANOL,0))
			anxietymedcount = 1;
		if(bloodstr.has_reagent(REAGENT_ID_NICOTINE,0))
			anxietymedcount = 1;
			antihistaminescount += 1;
		if(ingested.has_reagent(REAGENT_ID_TEA,0))
			anxietymedcount = 1;
			antihistaminescount += 1;

	// alright, we need to see if we've mixed our meds... which is really bad.
	if(anxietymedcount > 1)
		if(prob(15) && prob(20))
			stuttering = max(35, stuttering)
			adjustHalLoss(2)
			make_jittery(6)
			if(prob(2))
				to_chat(src, "<font color='red'>Everything feels wrong.</font>")
				hallucination = 25
				emote("twitch")
				make_jittery(22)
				adjustHalLoss(10)

	// anxiety meds handled here
	else if(anxietymedcount == 0)
		if (disabilities & NERVOUS)
			if (prob(15) && prob(7))
				stuttering = max(25, stuttering)
				if(jitteriness < 25)
					make_jittery(25)
		if (disabilities & TOURETTES)
			if ((prob(5) && prob(8) && paralysis <= 1))
				Stun(2)
				spawn( 0 )
					switch(rand(1, 3))
						if(1)
							emote("twitch")
						if(2 to 3)
							say("[prob(50) ? ";" : ""][pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER", "TITS")]")
					make_jittery(20)

	// seizure meds handled here
	if(seizuremedcount == 0)
		if (disabilities & EPILEPSY)
			if ((prob(2) && prob(4) && paralysis < 1))
				to_chat(src, "<font color='red'>You have a seizure!</font>")
				for(var/mob/O in viewers(src, null))
					if(O == src)
						continue
					O.show_message(span_danger("[src] starts having a seizure!"), 1)
				Paralyse(10)
				make_jittery(200)

	// and not for sneezy stuff!
	if(antihistaminescount == 0)
		if(species.allergens & ALLERGEN_POLLEN) // this behaves in a funny way compared to all other allergens! Behaves like a disability
			var/masked = FALSE
			if(istype(head,/obj/item/clothing/head/helmet/space) && !isnull(internal)) // Hardsuits
				masked = TRUE
			else if(wear_mask) // masks block it entirely
				if(wear_mask.item_flags & AIRTIGHT)
					masked = !isnull(internal) // gas on
				if(wear_mask.item_flags & BLOCK_GAS_SMOKE_EFFECT)
					masked = TRUE
			if(!masked)
				var/isirritated = FALSE
				var/things = list()
				if(prob(22))
					if(!isnull(r_hand))
						things += r_hand
					if(!isnull(l_hand))
						things += l_hand

				if(isturf(src.loc))
					// terrain tests
					things += src.loc.contents
					if(prob(8))
						if(istype(src.loc,/turf/simulated/floor/grass))
							isirritated = TRUE // auto irritate!

					if(!isirritated)
						if(prob(12)) // ranged laggier check
							things += orange(2,src.loc)

				// scan irritants!
				if(!isirritated)
					for(var/obj/machinery/portable_atmospherics/hydroponics/irritanttray in things)
						if(!irritanttray.dead && !isnull(irritanttray.seed))
							isirritated = TRUE
							break
				if(!isirritated)
					for(var/obj/effect/plant/irritant in things)
						isirritated = TRUE
						break
				if(!isirritated)
					for(var/obj/item/toy/bouquet/irritant in things)
						isirritated = TRUE
						break

				if(isirritated)
					to_chat(src, "<font color='red'>[pick("The air feels itchy!","Your face feels uncomfortable!","Your body tingles!")]</font>")
					add_chemical_effect(CE_ALLERGEN, rand(5,20) * REM)

		// may as well allow this to be handled in it's own way too
		if (disabilities & COUGHING)
			if ((prob(10) && prob(8) && paralysis <= 1))
				if(prob(23)) drop_item()
				spawn( 0 )
					emote("cough")

	if(disabilities & DETERIORATE && prob(2) && prob(3)) // stacked percents for rarity
		// random strange symptoms from organ/limb
		custom_emote(VISIBLE_MESSAGE, "flinches slightly.")
		switch(rand(1,4))
			if(1)
				adjustToxLoss(rand(2,8))
			if(2)
				adjustCloneLoss(rand(1,2))
			if(3)
				add_chemical_effect(CE_PAINKILLER, rand(8,28))
			else
				adjustOxyLoss(rand(13,26))
		// external organs need to fall off if damaged enough
		var/obj/item/organ/O = pick(organs)
		if(O && !(O.organ_tag == BP_GROIN || O.organ_tag == BP_TORSO) && istype(O,/obj/item/organ/external))
			var/obj/item/organ/external/E = O
			if(O.damage >= O.min_broken_damage && O.robotic <= ORGAN_ASSISTED && prob(70))
				add_chemical_effect(CE_PAINKILLER, 120) // what limb? Extreme nerve damage. Can't feel a thing + shock
				E.droplimb(TRUE, DROPLIMB_ACID)

	if(disabilities & GIBBING)
		gutdeathpressure += 0.01
		if(gutdeathpressure > 0 && prob(gutdeathpressure))
			emote(pick("whimper","belch","belch","belch","choke","shiver"))
			Weaken(gutdeathpressure / 3)
		if((gutdeathpressure/3) >= 1 && prob(gutdeathpressure/3))
			gutdeathpressure = 0 // to stop retriggering
			spawn(1)
				emote(pick("whimper","shiver"))
			spawn(3)
				emote(pick("whimper","belch","shiver"))
			spawn(4)
				emote(pick("whimper","shiver"))
			spawn(6)
				emote(pick("belch"))
				gib()
