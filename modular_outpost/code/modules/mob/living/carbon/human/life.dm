/mob
	var/anxietymedcount = 0 // DO NOT MIX THESE MEDS
	var/seizuremedcount = 0
	var/antihistaminescount = 0

/mob/living/carbon/human/proc/handle_outpost_medications()
	anxietymedcount = 0 // DO NOT MIX THESE MEDS
	seizuremedcount = 0
	antihistaminescount = 0
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

// Upstream will never allow themselves to bathe
#ifndef OUTPOST_FRIENDSHIP_MODE
/mob/living/carbon/human
	VAR_PRIVATE/feels_gross = 0

/mob/living/carbon/human/handle_outpost_hygene()
	if(isSynthetic())
		return

	// Need to be at maximum filth
	var/threshold = 20
	if(germ_level < GERM_LEVEL_MOVE_CAP || isbelly(loc))
		if(feels_gross >= threshold && !isbelly(loc)) // Got cleaned
			to_chat(src,span_notice("You feel refreshed and clean."))
		feels_gross = 0
		return

	// Avoid spam
	if(prob(99) || stat != CONSCIOUS || is_incorporeal())
		return
	feels_gross++
	if(feels_gross < threshold)
		return

	// Wash your damn ass
	if(feels_gross == threshold + 10)
		to_chat(src,span_warning("You feel like you should take a shower..."))
		return
	if((feels_gross % 2) == 0) // Only do it half the time
		return
	switch(rand(1,6))
		if(1)
			if(prob(20))
				emote("sneeze")
		if(2)
			if(prob(20))
				emote("cough")
		if(3)
			if(prob(20))
				emote("sniff")
		if(4)
			to_chat(src,span_warning("You feel dirty."))
		if(5)
			to_chat(src,span_warning("You feel disgusting."))
		if(6)
			if(prob(70))
				to_chat(src,span_warning("You feel itchy."))
#endif
