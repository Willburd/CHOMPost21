/decl/hierarchy/outfit/job/command_officer
	name = OUTFIT_JOB_NAME(JOB_COMMAND_OFFICER)
	shoes = /obj/item/clothing/shoes/brown
	id_type = /obj/item/card/id/silver/command_officer
	pda_type = /obj/item/pda/heads
	r_hand = /obj/item/clipboard

	glasses = /obj/item/clothing/glasses/fakesunglasses/aviator // Dripped

	headset = /obj/item/radio/headset/headset_com
	headset_alt = /obj/item/radio/headset/alt/headset_com
	headset_earbud = /obj/item/radio/headset/earbud/headset_com

/decl/hierarchy/outfit/job/command_officer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/suit_jacket/navy/skirt
	else
		uniform = /obj/item/clothing/under/suit_jacket/navy
