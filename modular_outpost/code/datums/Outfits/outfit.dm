/decl/hierarchy/outfit/proc/equip_stowaway_gear(mob/living/carbon/human/H)
	// A crowbar
	var/obj/item/tool/crowbar/red/bar = new()
	if(H.backbag == 1)
		H.equip_to_slot_or_del(bar, slot_r_hand)
	else
		H.equip_to_slot_or_del(bar, slot_in_backpack)
	// And glowstick
	var/obj/item/extra = new /obj/item/flashlight/glowstick()
	if(H.backbag == 1)
		H.equip_to_slot_or_del(extra, slot_l_hand)
	else
		H.equip_to_slot_or_del(extra, slot_in_backpack)
