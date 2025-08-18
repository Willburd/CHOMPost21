/obj/item/organ/internal/augment/armmounted/apc_connector
	name = "apc connector implant"
	desc = "A large implant that fits into a subject's arm. It allows a synthetic to connect to an area power controller to recharge."

	icon_state = "booster"
	var/obj/machinery/power/apc/apc = null

	forgiving_class = FALSE
	target_parent_classes = list(ORGAN_ROBOT,ORGAN_LIFELIKE,ORGAN_NANOFORM)

/obj/item/organ/internal/augment/armmounted/apc_connector/Destroy()
	end_charge()
	. = ..()

/obj/item/organ/internal/augment/armmounted/apc_connector/augment_action()
	if(!owner)
		return

	if(aug_cooldown)
		if(cooldown <= world.time)
			cooldown = world.time + aug_cooldown
		else
			return

	if(!ishuman(owner))
		return

	if(apc)
		to_chat(owner,span_warning("APC cable already connected!"))
		return

	var/mob/living/carbon/human/H = owner
	apc = locate(/obj/machinery/power/apc) in get_step(H,H.dir)
	if(!apc)
		apc = locate(/obj/machinery/power/apc) in get_turf(H)
	if(!apc)
		to_chat(H,span_notice("You must be near an APC to connect to."))
		return

	playsound(H, 'sound/machines/buzzbeep.ogg', 30, 1, 0)
	H.visible_message(span_warning("A cable extends from [H] and connects to \the [apc]."),span_notice("A cable extends from you and connect to \the [apc]."))
	if(!H.synthetic) // No.
		electrocute_mob(H, get_area(apc), apc, 1)
		H.Stun(10)
		apc = null
		return

	START_PROCESSING(SSobj, src)

/obj/item/organ/internal/augment/armmounted/apc_connector/proc/end_charge()
	apc = null
	STOP_PROCESSING(SSobj, src)

/obj/item/organ/internal/augment/armmounted/apc_connector/process()
	if(!owner)
		end_charge()
		return
	if(!apc || QDELETED(apc))
		end_charge()
		return

	var/mob/living/carbon/human/H = owner
	if(apc && (get_dist(H,apc) <= 1) && H.nutrition < 440) // 440 vs 450, life() happens before we get here so it'll never be EXACTLY 450
		H.nutrition = min(H.nutrition+10, 450)
		apc.drain_power(7000/450*10) //This is from the large rechargers. No idea what the math is.
		return

	to_chat(H,span_warning("APC charger disconnected."))
	H.visible_message(span_warning("[H]'s cable whips back into their body from \the [apc]."),span_notice("The APC connector cable returns to your body."))
	playsound(owner, 'sound/machines/click2.ogg', 30, 1, 0)
	end_charge()
