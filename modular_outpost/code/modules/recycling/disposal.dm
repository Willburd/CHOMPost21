/obj/structure/disposalholder
	count = 3072 //*** can travel 3072 steps before going inactive (in case of loops)

/obj/machinery/disposal/mail_reciever
	name = "disposal mail destination()"
	desc = "A pneumatic waste disposal unit. This unit is marked for receiving mail."
	icon = 'icons/obj/pipes/disposal_mail.dmi'

/obj/machinery/disposal/burn_pit
	name = "incinerator disposal"
	desc = "A pneumatic waste disposal unit. This unit is connected directly to the station's incinerator."
	icon = 'icons/obj/pipes/disposal_burn.dmi'

/obj/machinery/disposal/proc/malfunction()
	mode = 3
	flush = 1
	update()
	visible_message(span_warning("\The [src] sparks violently!"))
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(4, 1, get_turf(src))
	sparks.start()

//junction that filters bodies
/obj/structure/disposalpipe/sortjunction/bodies
	name = "body recovery junction"
	desc = "An underfloor disposal pipe which filters out detectable bodies, living or soon to be dead."
	subtype = DISPOSAL_SORT_BODIES

/obj/structure/disposalpipe/sortjunction/bodies/divert_check(var/checkTag)
	return checkTag == "corpse"

/obj/structure/disposalpipe/sortjunction/bodies/flipped
	icon_state = "pipe-j2s"

/obj/structure/disposalpipe/sortjunction/proc/check_corpse_sorter(var/obj/structure/disposalholder/H)
	var/detectedtag = H.destinationTag
	if(istype(src,/obj/structure/disposalpipe/sortjunction/bodies) && detectedtag == "")
		for(var/mob/living/L in H)
			if(istype(L,/mob/living/carbon)) // only living carbons count not silicons
				detectedtag = "corpse"
				break
		// Check for microholders, you can't skip the system this way either!
		var/obj/item/holder/hold = null
		for(var/obj/item/holder/hl in H)
			if(!isnull(hl.held_mob) && istype(hl.held_mob,/mob/living/carbon))
				hold = hl
				break
		if(!isnull(hold))
			detectedtag = "corpse"
		else
			// check ID validity
			var/obj/item/card/foundid = null
			for(var/obj/item/card/id in H) // send these to medical body disposal as well
				foundid = id
				break
			for(var/obj/item/pda/P in H)
				if(!isnull(P.id)) // send these to medical body disposal as well
					foundid = P.id
					break
			for(var/obj/item/storage in H)
				for(var/obj/item/pda/P in storage.contents)
					if(!isnull(P.id)) // send these to medical body disposal as well
						foundid = P.id
						break
				for(var/obj/item/card/id in storage.contents)
					foundid = id // check simple storages for idcards! one level deep only!
					break
			// check ID validity
			if(!isnull(foundid) && !istype(foundid,/obj/item/card/id/guest))
				detectedtag = "corpse"
	return detectedtag
