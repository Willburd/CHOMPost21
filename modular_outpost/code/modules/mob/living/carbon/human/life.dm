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
