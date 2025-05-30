/obj/item/clothing
	var/recent_struggle = 0

/obj/item/clothing/shoes
	var/list/inside_emotes = list()
	var/recent_squish = 0
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/feet/mob_teshari.dmi',
		SPECIES_VOX = 'icons/inventory/feet/mob_vox.dmi',
		SPECIES_WEREBEAST = 'icons/inventory/feet/mob_vr_werebeast.dmi')

/obj/item/clothing/shoes/Initialize(mapload)
	inside_emotes = list(
		span_red("You feel weightless for a moment as \the [name] moves upwards."),
		span_red("\The [name] are a ride you've got no choice but to participate in as the wearer moves."),
		span_red("The wearer of \the [name] moves, pressing down on you."),
		span_red("More motion while \the [name] move, feet pressing down against you.")
	)

	. = ..()
/* //Must be handled in clothing.dm
/obj/item/clothing/shoes/proc/handle_movement(var/turf/walking, var/running)
	if(prob(1) && !recent_squish)
		recent_squish = 1
		spawn(100)
			recent_squish = 0
		for(var/mob/living/M in contents)
			var/emote = pick(inside_emotes)
			to_chat(M,emote)
	return
*/

//This is a crazy 'sideways' override.
/obj/item/clothing/shoes/attackby(var/obj/item/I, var/mob/user)
	if(istype(I,/obj/item/holder/micro))
		var/full = 0
		for(var/mob/M in src)
			if(isvoice(M)) //Don't count voices as people!
				continue
			full++
		if(full >= 2)
			to_chat(user, span_warning("You can't fit anyone else into \the [src]!"))
		else
			var/obj/item/holder/micro/holder = I
			if(holder.held_mob && (holder.held_mob in holder))
				var/mob/living/M = holder.held_mob
				holder.dump_mob()
				to_chat(M, span_warning("[user] stuffs you into \the [src]!"))
				M.forceMove(src)
				to_chat(user, span_notice("You stuff \the [M] into \the [src]!"))
	else
		..()

/obj/item/clothing/shoes/attack_self(var/mob/user)
	for(var/mob/M in src)
		if(isvoice(M)) //Don't knock voices out!
			continue
		M.forceMove(get_turf(user))
		to_chat(M, span_warning("[user] shakes you out of \the [src]!"))
		to_chat(user, span_notice("You shake [M] out of \the [src]!"))

	..()

/obj/item/clothing/shoes/container_resist(mob/living/micro)
	var/mob/living/carbon/human/macro = loc
	if(isvoice(micro)) //Voices shouldn't be able to resist but we have this here just in case.
		return
	if(!istype(macro))
		to_chat(micro, span_notice("You start to climb out of [src]!"))
		if(do_after(micro, 50, src))
			to_chat(micro, span_notice("You climb out of [src]!"))
			micro.forceMove(loc)
		return

	var/escape_message_micro = "You start to climb out of [src]!"
	var/escape_message_macro = "Something is trying to climb out of your [src]!"
	var/escape_time = 60

	if(macro.shoes == src)
		escape_message_micro = "You start to climb around the larger creature's feet and ankles!"
		escape_time = 100

	to_chat(micro, span_notice("[escape_message_micro]"))
	to_chat(macro, span_danger("[escape_message_macro]"))
	if(!do_after(micro, escape_time, macro))
		to_chat(micro, span_danger("You're pinned underfoot!"))
		to_chat(macro, span_danger("You pin the escapee underfoot!"))
		return

	to_chat(micro, span_notice("You manage to escape [src]!"))
	to_chat(macro, span_danger("Someone has climbed out of your [src]!"))
	micro.forceMove(macro.loc)

/obj/item/clothing/gloves
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/hands/mob_teshari.dmi',
		SPECIES_VOX = 'icons/inventory/hands/mob_vox.dmi',
		SPECIES_WEREBEAST = 'icons/inventory/hands/mob_vr_werebeast.dmi')

/obj/item/clothing/ears
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/ears/mob_teshari.dmi',
		SPECIES_VOX = 'icons/inventory/ears/mob_vox.dmi',
		SPECIES_WEREBEAST = 'icons/inventory/ears/mob_vr_werebeast.dmi')

/obj/item/clothing/relaymove(var/mob/living/user,var/direction)

	if(recent_struggle)
		return

	recent_struggle = 1

	spawn(100)
		recent_struggle = 0

	if(ishuman(src.loc)) //Is this on a person?
		var/mob/living/carbon/human/H = src.loc
		if(isvoice(user)) //Is this a possessed item? Spooky. It can move on it's own!
			to_chat(H, span_red("The [src] shifts about, almost as if squirming!"))
			to_chat(user, span_red("You cause the [src] to shift against [H]'s form! Well, what little you can get to, given your current state!"))
		else if(H.shoes == src)
			to_chat(H, span_red("[user]'s tiny body presses against you in \the [src], squirming!"))
			to_chat(user, span_red("Your body presses out against [H]'s form! Well, what little you can get to!"))
		else
			to_chat(H, span_red("[user]'s form shifts around in the \the [src], squirming!"))
			to_chat(user, span_red("You move around inside the [src], to no avail."))
	else if(isvoice(user)) //Possessed!
		src.visible_message(span_red("The [src] shifts about!"))
		to_chat(user, span_red("You cause the [src] to shift about!"))
	else
		src.visible_message(span_red("\The [src] moves a little!"))
		to_chat(user, span_red("You throw yourself against the inside of \the [src]!"))

//Mask
/obj/item/clothing/mask
	name = "mask"
	icon = 'modular_chomp/icons/inventory/face/item.dmi' // This is intentional because of our custom species. //Chompedit: this file also goes to modular_chomp
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_masks.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_masks.dmi',
		)
	body_parts_covered = HEAD|FACE|EYES
	slot_flags = SLOT_MASK
	//Chompedit Start: Moving over to the modularity folder because virgo changed the name of upstream icons in their modular files. Epic.
	item_icons = list(
		slot_wear_mask_str = 'modular_chomp/icons/inventory/face/mob.dmi'
		)
	sprite_sheets = list(
		SPECIES_TESHARI		= 'modular_chomp/icons/inventory/face/mob_teshari.dmi',
		SPECIES_VOX 		= 'modular_chomp/icons/inventory/face/mob_vox.dmi',
		SPECIES_TAJARAN 	= 'modular_chomp/icons/inventory/face/mob_tajaran.dmi',
		SPECIES_UNATHI 		= 'modular_chomp/icons/inventory/face/mob_unathi.dmi',
		SPECIES_SERGAL 		= 'modular_chomp/icons/inventory/face/mob_sergal.dmi',
		SPECIES_NEVREAN 	= 'modular_chomp/icons/inventory/face/mob_nevrean.dmi',
		SPECIES_ZORREN_HIGH	= 'modular_chomp/icons/inventory/face/mob_fox.dmi',
		SPECIES_ZORREN_FLAT = 'modular_chomp/icons/inventory/face/mob_fennec.dmi',
		SPECIES_AKULA 		= 'modular_chomp/icons/inventory/face/mob_akula.dmi',
		SPECIES_VULPKANIN 	= 'modular_chomp/icons/inventory/face/mob_vulpkanin.dmi',
		SPECIES_XENOCHIMERA	= 'modular_chomp/icons/inventory/face/mob_tajaran.dmi',
		SPECIES_WEREBEAST	= 'modular_chomp/icons/inventory/face/mob_werebeast.dmi'
		)
	//Chompedit End.

//"Spider" 		= 'icons/inventory/mask/mob_spider.dmi' Add this later when they have custom mask sprites and everything.

/obj/item/clothing/under
	sensor_mode = 3
	var/sensorpref = 5
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/uniform/mob_teshari.dmi',
		SPECIES_VOX = 'icons/inventory/uniform/mob_vox.dmi',
		SPECIES_WEREBEAST = 'icons/inventory/uniform/mob_vr_werebeast.dmi')

/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/H = loc
	sensorpref = isnull(H) ? 1 : (ishuman(H) ? H.sensorpref : 1)
	switch(sensorpref)
		if(1) sensor_mode = 0				//Sensors off
		if(2) sensor_mode = 1				//Sensors on binary
		if(3) sensor_mode = 2				//Sensors display vitals
		if(4) sensor_mode = 3				//Sensors display vitals and enables tracking
		if(5) sensor_mode = pick(0,1,2,3)	//Select a random setting
		else
			sensor_mode = pick(0,1,2,3)
			log_debug("Invalid switch for suit sensors, defaulting to random. [sensorpref] chosen")

/obj/item/clothing/head
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/head/mob_teshari.dmi',
		SPECIES_VOX = 'icons/inventory/head/mob_vox.dmi',
		SPECIES_WEREBEAST = 'icons/inventory/head/mob_vr_werebeast.dmi')
