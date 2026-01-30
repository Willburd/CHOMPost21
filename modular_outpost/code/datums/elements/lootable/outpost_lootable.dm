GLOBAL_LIST_INIT(unique_theta_loot, list(
		/obj/item/spellbook/oneuse/blind,
		/obj/item/spellbook/oneuse/charge,
		/obj/item/spellbook/oneuse/fireball,
		/obj/item/spellbook/oneuse/forcewall,
		/obj/item/spellbook/oneuse/horsemask,
		/obj/item/spellbook/oneuse/knock,
		/obj/item/material/twohanded/fireaxe
	))

GLOBAL_VAR_INIT(spawned_theta,FALSE) // Only one a ROUND

/proc/produce_theta_item()
	var/path = pick(GLOB.unique_theta_loot)
	if(path)
		GLOB.spawned_theta = TRUE
		return new path()


/datum/element/lootable
	var/static/list/outpost_uncommon_table = list(
		/obj/item/research_sample/uncommon,
		/obj/item/clothing/head/fishing,
		/obj/item/research_sample/rare,
		/obj/item/dnainjector/random_labeled,
		/obj/item/dnainjector/random,
		/obj/item/clothing/accessory/bodycam/yobro
	)
	var/static/list/outpost_rare_table = list(
		/obj/item/reagent_containers/glass/beaker/wheymax,
		/obj/item/prop/alien/junk,
		/obj/item/implanter/loyalty,
		/obj/item/clothing/gloves/telekinetic,
		/obj/item/storage/box/monkeycubes,
		/obj/item/storage/box/monkeycubes/pets/outpost_A,
		/obj/item/storage/box/monkeycubes/pets/outpost_B,
		/obj/item/storage/box/monkeycubes/pets/NT_standard,
		/obj/item/storage/box/monkeycubes/pets/NT_special,
		/obj/item/deadringer,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple/medical,
		/obj/item/organ/internal/butt/robot,
		/obj/item/organ/internal/augment/armmounted/apc_connector,
		/obj/item/reagent_containers/food/drinks/cans/crystal_classic_wind,
		/obj/item/rectape/anna_lore,
		/obj/item/card/emag
	)


/datum/element/lootable/maint/technical/New()
	. = ..()
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table


/datum/element/lootable/maint/trash/New()
	. = ..()
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table


/datum/element/lootable/trash_pile/New()
	. = ..()
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table
