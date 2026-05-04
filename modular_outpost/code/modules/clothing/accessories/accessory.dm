/obj/item/clothing/accessory
	var/allow_borg = FALSE

// Borgs wearing accessories
/obj/item/clothing/accessory/attack_robot(mob/living/silicon/robot/user)
	. = ..()
	if(!Adjacent(user))
		return
	if(!allow_borg)
		to_chat(src, span_notice("You cannot wear \the [src]"))
		return
	if(length(user.accessories) >= 20)
		to_chat(src, span_danger("You are wearing too many accessories to put on another!"))
		return

	balloon_alert(user, "picking up \the [src]...")
	if(!do_after(user, 3 SECONDS, src))
		return
	if(QDELETED(src) || !Adjacent(user) || user.incapacitated)
		return
	user.accessories += src
	forceMove(user)
	balloon_alert(user, "picked up \the [src]")

/obj/item/clothing/accessory/examine(mob/user)
	. = ..()
	if(isrobot(user) && allow_borg)
		. += span_notice("You can wear it as a chassis accessory.")

/obj/item/clothing/accessory/ribbon
	allow_borg = TRUE

/obj/item/clothing/accessory/medal
	allow_borg = TRUE

/obj/item/clothing/accessory/solgov
	allow_borg = TRUE

/obj/item/clothing/accessory/locket
	allow_borg = TRUE

/obj/item/clothing/accessory/watch
	allow_borg = TRUE

/obj/item/clothing/accessory/badge
	allow_borg = TRUE

/obj/item/clothing/accessory/gold_sticker
	allow_borg = TRUE

/obj/item/clothing/accessory/rank_eshui
	allow_borg = TRUE

/obj/item/clothing/accessory/scarf
	allow_borg = TRUE

/obj/item/clothing/accessory/bowtie
	allow_borg = TRUE

/obj/item/clothing/accessory/tie
	allow_borg = TRUE

/obj/item/clothing/accessory/collar
	allow_borg = TRUE

/obj/item/clothing/accessory/pride
	allow_borg = TRUE

/obj/item/clothing/accessory/armband
	allow_borg = TRUE

/obj/item/clothing/accessory/sash
	allow_borg = TRUE

/obj/item/clothing/accessory/gaiter
	allow_borg = TRUE

/obj/item/clothing/accessory/poncho
	allow_borg = TRUE

/obj/item/clothing/accessory/tropical
	allow_borg = TRUE

/obj/item/clothing/accessory/hawaiian
	allow_borg = TRUE
