// Honker loot
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/element/lootable/mecha/honker
	common_loot = list(
		/obj/item/mecha_parts/chassis/gygax,
		/obj/item/mecha_parts/part/gygax_head,
		/obj/item/mecha_parts/part/gygax_torso,
		/obj/item/mecha_parts/part/gygax_left_arm,
		/obj/item/mecha_parts/part/gygax_right_arm,
		/obj/item/mecha_parts/part/gygax_left_leg,
		/obj/item/mecha_parts/part/gygax_right_leg,
		/obj/item/mecha_parts/part/gygax_armour
		)

	uncommon_loot = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/banana_mortar,
		/obj/item/mecha_parts/mecha_equipment/weapon/honker,
		/obj/item/kit/paint/gygax
		)

	rare_loot = list(
		/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		/obj/item/mecha_parts/mecha_equipment/repair_droid,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
		)

// Powerful rare loot, as these were removed from research
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/element/lootable/mecha/gygax/New()
	. = ..()

	rare_loot |= list(
		/obj/item/mecha_parts/mecha_equipment/combat_shield,
		/obj/item/mecha_parts/mecha_equipment/omni_shield
		)

/datum/element/lootable/mecha/phazon/New()
	. = ..()

	rare_loot |= list(
		/obj/item/mecha_parts/mecha_equipment/combat_shield,
		/obj/item/mecha_parts/mecha_equipment/omni_shield
		)
