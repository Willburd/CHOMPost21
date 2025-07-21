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


/datum/element/lootable/maint/technical/New()
	. = ..()

	rare_loot += list(
		/obj/item/prop/alien/junk
	)


/datum/element/lootable/maint/trash/New()
	. = ..()

	uncommon_loot += list(
		/obj/item/prop/alien/junk,
		/obj/item/dnainjector/random_labeled,
		/obj/item/dnainjector/random
	)


/datum/element/lootable/trash_pile/New()
	. = ..()

	uncommon_loot += list(
		/obj/item/research_sample/uncommon,
		/obj/item/clothing/head/fishing,
		/obj/item/research_sample/rare
	)

	rare_loot += list(
		/obj/item/reagent_containers/glass/beaker/wheymax,
		/obj/item/implanter/loyalty,
		/obj/item/clothing/gloves/telekinetic,
		/obj/item/storage/box/monkeycubes,
		/obj/item/storage/box/monkeycubes/pets/A,
		/obj/item/storage/box/monkeycubes/pets/B,
		/obj/item/deadringer,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple/medical,
		/obj/item/reagent_containers/food/drinks/cans/crystal_classic_wind
	)
