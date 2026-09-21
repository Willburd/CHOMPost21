/datum/decl/hierarchy/outfit/job/command_officer
	name = OUTFIT_JOB_NAME(JOB_COMMAND_OFFICER)
	shoes = /obj/item/clothing/shoes/brown
	id_type = /obj/item/card/id/silver/command_officer
	pda_type = /obj/item/pda/heads
	r_hand = /obj/item/clipboard

	glasses = /obj/item/clothing/glasses/fakesunglasses/aviator // Dripped

	headset = /obj/item/radio/headset/headset_com
	headset_alt = /obj/item/radio/headset/alt/headset_com
	headset_earbud = /obj/item/radio/headset/earbud/headset_com

/datum/decl/hierarchy/outfit/job/command_officer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/suit_jacket/navy/skirt
	else
		uniform = /obj/item/clothing/under/suit_jacket/navy

// Custom outfits for jr heads
/datum/decl/hierarchy/outfit/job/command_officer/med_co
	headset = /datum/decl/hierarchy/outfit/job/medical/cmo::headset
	headset_alt = /datum/decl/hierarchy/outfit/job/medical/cmo::headset_alt
	headset_earbud = /datum/decl/hierarchy/outfit/job/medical/cmo::headset_earbud
	pda_type = /datum/decl/hierarchy/outfit/job/medical/cmo::pda_type
	head = /obj/item/clothing/head/beret/medical

/datum/decl/hierarchy/outfit/job/command_officer/sec_co
	headset = /datum/decl/hierarchy/outfit/job/security/hos::headset
	headset_alt = /datum/decl/hierarchy/outfit/job/security/hos::headset_alt
	headset_earbud = /datum/decl/hierarchy/outfit/job/security/hos::headset_earbud
	pda_type = /datum/decl/hierarchy/outfit/job/security/hos::pda_type
	head = /obj/item/clothing/head/beret/sec/navy/officer

/datum/decl/hierarchy/outfit/job/command_officer/eng_co
	headset = /datum/decl/hierarchy/outfit/job/engineering/chief_engineer::headset
	headset_alt = /datum/decl/hierarchy/outfit/job/engineering/chief_engineer::headset_alt
	headset_earbud = /datum/decl/hierarchy/outfit/job/engineering/chief_engineer::headset_earbud
	pda_type = /datum/decl/hierarchy/outfit/job/engineering/chief_engineer::pda_type
	head = /obj/item/clothing/head/hardhat/white

/datum/decl/hierarchy/outfit/job/command_officer/sci_co
	headset = /datum/decl/hierarchy/outfit/job/science/rd::headset
	headset_alt = /datum/decl/hierarchy/outfit/job/science/rd::headset_alt
	headset_earbud = /datum/decl/hierarchy/outfit/job/science/rd::headset_earbud
	pda_type = /datum/decl/hierarchy/outfit/job/science/rd::pda_type
