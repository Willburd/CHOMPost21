GLOBAL_LIST_INIT(unique_theta_loot, list(
		/obj/item/spellbook/oneuse/blind,
		/obj/item/spellbook/oneuse/charge,
		/obj/item/spellbook/oneuse/fireball,
		/obj/item/spellbook/oneuse/forcewall,
		/obj/item/spellbook/oneuse/horsemask,
		/obj/item/spellbook/oneuse/knock,
		/obj/item/material/twohanded/fireaxe
	))

GLOBAL_LIST_INIT(unique_stowaway_loot, list(
		/obj/item/material/twohanded/fireaxe,
		/obj/item/card/emag,
		/obj/random/tool,
		/obj/random/design_disks,
		/obj/item/clothing/gloves/telekinetic,
		/obj/item/deadringer,
		/obj/item/prop/alien/junk,
		/obj/item/implanter/loyalty,
		/obj/item/tape_roll,
		/obj/item/dnainjector/random_labeled,
		/obj/item/dnainjector/random,
		/obj/item/clothing/accessory/bodycam/yobro,
		/obj/item/mecha_parts/mecha_equipment/tool/rcd,
		/obj/random/tank,
		/obj/random/tech_supply/component,
		/obj/item/deck/tarot,
		/obj/item/flame/lighter/zippo/gold,
		/obj/item/flame/lighter/zippo/black,,
		/obj/item/borg/upgrade/basic/vtec,
		/obj/item/clothing/under/hyperfiber,
		/obj/item/camera,
		/obj/item/cell/hyper,
		/obj/item/clothing/under/harness,
		/obj/item/clothing/under/tactical,
		/obj/item/clothing/mask/gas/voice,
		/obj/item/spacecash/random_value,
		/obj/item/capture_crystal,
		/obj/item/perfect_tele/one_beacon,
		/obj/item/gun/energy/mouseray,
		/obj/item/implanter/compliance,
		/obj/item/material/knife/tacknife,
		/obj/item/radio_jammer,
		/obj/item/sleevemate,
		/obj/item/bodysnatcher,
		/obj/item/mindbinder,
		/obj/item/handcuffs/fuzzy,
		/obj/item/handcuffs/legcuffs/fuzzy,
		/obj/item/storage/box/syndie_kit/spy,
		/obj/item/grenade/anti_photon,
		/obj/item/storage/pill_bottle/zoom,
		/obj/item/clothing/suit/storage/vest/heavy/merc,
		/obj/item/clothing/shoes/boots/combat,
		/obj/item/universal_translator,
		/obj/item/cartridge/captain,
		/obj/item/tool/wrench,
		/obj/item/tool/screwdriver,
		/obj/item/tool/wirecutters,
		/obj/item/mining_scanner/advanced,
		/obj/item/multitool,
		/obj/item/hailer,
		/obj/item/gps,
		/obj/item/geiger,
		/obj/item/cartridge/engineering,
		/obj/item/analyzer,
		/obj/item/healthanalyzer,
		/obj/item/clothing/shoes/syndigaloshes,
		/obj/item/clothing/head/hardhat,
		/obj/item/clothing/head/hardhat/red,
		/obj/item/clothing/head/welding,
		/obj/item/clothing/gloves/yellow,
		/obj/item/tool/transforming/powerdrill,
		/obj/item/weldingtool/experimental,
		/obj/item/tool/transforming/jawsoflife,
		/obj/random/energy,
		/obj/random/projectile,
		/obj/random/ammo,
		/obj/random/grenade,
	))

GLOBAL_VAR_INIT(spawned_theta,FALSE) // Only one a ROUND

/proc/produce_theta_item()
	var/path = pick(GLOB.unique_theta_loot)
	if(path)
		GLOB.spawned_theta = TRUE
		return new path()


/datum/element/lootable
	var/static/list/outpost_common_table = list(
		/obj/item/expi_pamphlet,
		/obj/item/reagent_containers/glass/beaker/wheymax,
		/obj/item/paper,
		/obj/item/pen,
		/obj/item/tape_roll,
	)
	var/static/list/outpost_uncommon_table = list(
		/obj/item/research_sample/uncommon,
		/obj/item/clothing/head/fishing,
		/obj/item/research_sample/rare,
		/obj/item/dnainjector/random_labeled,
		/obj/item/dnainjector/random,
		/obj/item/clothing/accessory/bodycam/yobro,
		/obj/random/scavmark_paper,
		/obj/item/storage/box/monkeycubes,
		/obj/item/storage/box/monkeycubes/pets/outpost_A,
		/obj/item/storage/box/monkeycubes/pets/outpost_B,
		/obj/item/storage/box/monkeycubes/pets/NT_standard,
		/obj/item/storage/box/monkeycubes/pets/NT_special,
		/obj/random/tool,
		/obj/random/design_disks,
	)
	var/static/list/outpost_rare_table = list(
		/obj/item/prop/alien/junk,
		/obj/item/implanter/loyalty,
		/obj/item/clothing/gloves/telekinetic,
		/obj/item/deadringer,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple,
		/obj/item/organ/internal/augment/armmounted/shoulder/multiple/medical,
		/obj/item/organ/internal/butt/robot,
		/obj/item/organ/internal/augment/armmounted/apc_connector,
		/obj/item/reagent_containers/food/drinks/cans/crystal_classic_wind,
		/obj/item/rectape/anna_lore,
		/obj/item/card/emag,
	)


/datum/element/lootable/maint/technical/New()
	. = ..()
	common_loot |= outpost_common_table
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table


/datum/element/lootable/maint/trash/New()
	. = ..()
	common_loot |= outpost_common_table
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table


/datum/element/lootable/trash_pile/New()
	. = ..()
	common_loot |= outpost_common_table
	uncommon_loot |= outpost_uncommon_table
	rare_loot |= outpost_rare_table
