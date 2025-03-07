/datum/technomancer/equipment/gloves_of_regen
	name = "Gloves of Regeneration"
	desc = "It's a pair of black gloves, with a hypodermic needle on the insides, and a small storage of a secret blend of chemicals \
	designed to be slowly fed into a living person's system, increasing their metabolism greatly, resulting in accelerated healing.  \
	A side effect of this healing is that the wearer will generally get hungry a lot faster.  Sliding the gloves on and off also \
	hurts a lot.  As a bonus, the gloves are more resistant to the elements than most.  It should be noted that synthetics will have \
	little use for these."
	cost = 50
	obj_path = /obj/item/clothing/gloves/regen

/obj/item/clothing/gloves/regen
	name = "gloves of regeneration"
	desc = "A pair of gloves with a small storage of green liquid on the outside.  On the inside, a a hypodermic needle can be seen \
	on each glove."
	icon_state = "regen"
	item_state = "graygloves"
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/regen/equipped(var/mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.gloves == src)
			wearer = WEAKREF(H)
			if(H.can_feel_pain())
				to_chat(H, span_danger("You feel a stabbing sensation in your hands as you slide \the [src] on!"))
				H.custom_pain("You feel a sharp pain in your hands!",1)
	..()


/obj/item/clothing/gloves/regen/dropped(var/mob/user)
	..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	if(H.can_feel_pain())
		to_chat(H, span_danger("You feel the hypodermic needles as you slide \the [src] off!"))
		H.custom_pain("Your hands hurt like hell!",1)

/obj/item/clothing/gloves/regen/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/gloves/regen/Destroy()
	wearer = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/gloves/regen/process()
	var/mob/living/carbon/human/H = wearer?.resolve()
	if(!ishuman(H) || H.isSynthetic() || H.stat == DEAD || H.nutrition <= 10)
		return // Robots and dead people don't have a metabolism.

	if(H.getBruteLoss())
		H.adjustBruteLoss(-0.1)
		H.nutrition = max(H.nutrition - 10, 0)
	if(H.getFireLoss())
		H.adjustFireLoss(-0.1)
		H.nutrition = max(H.nutrition - 10, 0)
	if(H.getToxLoss())
		H.adjustToxLoss(-0.1)
		H.nutrition = max(H.nutrition - 10, 0)
	if(H.getOxyLoss())
		H.adjustOxyLoss(-0.1)
		H.nutrition = max(H.nutrition - 10, 0)
	if(H.getCloneLoss())
		H.adjustCloneLoss(-0.1)
		H.nutrition = max(H.nutrition - 20, 0)
