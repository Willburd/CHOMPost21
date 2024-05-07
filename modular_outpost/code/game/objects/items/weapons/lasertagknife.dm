
////////Laser Tag////////////////////

/obj/item/weapon/lasertagknife
	name = "universal laser tag dagger"
	desc = "Rubber knife with a glowing fancy edge. It has no team allegiance!"
	icon = 'icons/obj/weapons_op.dmi'
	icon_state = "tagknifeomni"
	item_icons = list(slot_l_hand_str = 'icons/mob/items/lefthand_melee_op.dmi',slot_r_hand_str = 'icons/mob/items/righthand_melee_op.dmi',)
	item_state_slots = list(slot_r_hand_str = "tagknifeomni", slot_l_hand_str = "tagknifeomni")
	item_state = null
	hitsound = null
	w_class = ITEMSIZE_SMALL
	attackspeed = 1.2 SECONDS
	attack_verb = list("patted", "tapped")
	drop_sound = 'sound/items/drop/knife.ogg'
	pickup_sound = 'sound/items/pickup/knife.ogg'
	var/required_vest = /obj/item/clothing/suit/omnitag

/obj/item/weapon/lasertagknife/blue
	name = "blue laser tag dagger"
	desc = "Rubber knife with a blue glowing fancy edge!"
	icon_state = "tagknifeblue"
	item_state_slots = list(slot_r_hand_str = "tagknifeblue", slot_l_hand_str = "tagknifeblue")
	required_vest = /obj/item/clothing/suit/bluetag

/obj/item/weapon/lasertagknife/red
	name = "red laser tag dagger"
	desc = "Rubber knife with a red glowing fancy edge!"
	icon_state = "tagknifered"
	item_state_slots = list(slot_r_hand_str = "tagknifered", slot_l_hand_str = "tagknifered")
	required_vest = /obj/item/clothing/suit/redtag

/obj/item/weapon/lasertagknife/attack(mob/M, mob/user)
	var/success = FALSE
	var/mob/living/carbon/human/userH = user
	if(userH && istype(userH.wear_suit, required_vest))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_suit, /obj/item/clothing/suit/omnitag) || istype(H.wear_suit, /obj/item/clothing/suit/bluetag) || istype(H.wear_suit, /obj/item/clothing/suit/redtag))
				success = TRUE
				H.Weaken(5)
	if(success)
		M.visible_message("<span class='danger'>[M] has been zapped with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/Egloves.ogg', 50, 1, -1)
	else
		M.visible_message("<span class='danger'>[M] has been harmlessly bonked with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	return 1

/obj/item/weapon/lasertagknife/blue/attack(mob/M, mob/user)
	var/success = FALSE
	var/mob/living/carbon/human/userH = user
	if(userH && istype(userH.wear_suit, required_vest))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_suit, /obj/item/clothing/suit/omnitag) || istype(H.wear_suit, /obj/item/clothing/suit/redtag))
				success = TRUE
				H.Weaken(5)
	if(success)
		M.visible_message("<span class='danger'>[M] has been zapped with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/Egloves.ogg', 50, 1, -1)
	else
		M.visible_message("<span class='danger'>[M] has been harmlessly bonked with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	return 1

/obj/item/weapon/lasertagknife/red/attack(mob/M, mob/user)
	var/success = FALSE
	var/mob/living/carbon/human/userH = user
	if(userH && istype(userH.wear_suit, required_vest))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_suit, /obj/item/clothing/suit/omnitag) || istype(H.wear_suit, /obj/item/clothing/suit/bluetag))
				success = TRUE
				H.Weaken(5)
	if(success)
		M.visible_message("<span class='danger'>[M] has been zapped with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/Egloves.ogg', 50, 1, -1)
	else
		M.visible_message("<span class='danger'>[M] has been harmlessly bonked with [src] by [user]!</span>")
		playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	return 1
