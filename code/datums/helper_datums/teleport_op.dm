/proc/bluespace_bag_malfunction( var/mob/user, var/obj/item/bag_holding, var/obj/item/stored_item )
	if(prob(10))
		to_chat(user, span_danger("\The [stored_item] violently explodes as it is inserted into \the [bag_holding]!"))
		explosion(get_turf(stored_item),1,1,2,3)
		qdel(bag_holding)
		qdel(stored_item)
		if(prob(10))
			user.gib() // sometimes it's extra mean
		return

	if(prob(10))
		to_chat(user, span_danger("Both \the [stored_item] and \the [bag_holding] suddenly vanish!"))
		var/turf/T = get_turf(user)
		user.drop_from_inventory(bag_holding,T)
		user.drop_from_inventory(stored_item,T)
		do_teleport(bag_holding, locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), user.z), 0, TRUE,local = FALSE, bohsafe = TRUE)
		do_teleport(stored_item, locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), user.z), 0, TRUE,local = FALSE, bohsafe = TRUE)
		return

	if(prob(10))
		to_chat(user, span_danger("A portal opens as \the [stored_item] vanishes!"))
		var/turf/enter = get_turf(user)
		var/wormhole_min_duration = round((30 SECONDS))
		var/wormhole_max_duration = round((5 MINUTES))
		var/list/redexitlist = list()
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "redexit")
				redexitlist += R
		if(prob(1))
			create_redspace_wormhole(enter,enter,FALSE,wormhole_min_duration,wormhole_max_duration)
		else
			create_wormhole(enter,pick(redexitlist),wormhole_min_duration,wormhole_max_duration)
		var/obj/effect/portal/P = locate() in enter
		if(P)
			P.Crossed(user) // Autostep
		qdel(stored_item)
		return

	if(prob(10) && ishuman(user))
		var/mob/living/carbon/human/H = user
		to_chat(user, span_danger("Both \the [stored_item] and \the [bag_holding] collapse into each other, taking your arms with them!"))
		var/turf/T = get_turf(user)
		user.drop_from_inventory(bag_holding,T)
		user.drop_from_inventory(stored_item,T)

		var/turf/left_dest = locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), user.z)
		var/turf/right_dest = locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), user.z)
		do_teleport(bag_holding, left_dest, 0, TRUE, local = FALSE,bohsafe = TRUE)
		do_teleport(stored_item, right_dest, 0, TRUE, local = FALSE,bohsafe = TRUE)

		var/obj/item/organ/external/left_arm = H.get_organ(BP_L_ARM)
		if(left_arm)
			left_arm.removed(H)
			new /obj/effect/gibspawner/human(H.loc,H.dna,H.species.flesh_color,H.species.blood_color)
			do_teleport(left_arm, left_dest, 0, TRUE,local = FALSE,bohsafe = TRUE)
		var/obj/item/organ/external/right_arm = H.get_organ(BP_R_ARM)
		if(right_arm)
			right_arm.removed(H)
			new /obj/effect/gibspawner/human(H.loc,H.dna,H.species.flesh_color,H.species.blood_color)
			do_teleport(right_arm, right_arm, 0, TRUE,local = FALSE,bohsafe = TRUE)
		if(left_arm || right_arm)
			H.emote("scream")
		return

	to_chat(user, span_warning("The Bluespace interfaces of the two devices conflict and malfunction."))
	qdel(stored_item)
	return
