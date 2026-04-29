/obj/random/design_disks
	name = "random design disk"
	desc = "Random design disk loot."
	icon = 'icons/obj/storage.dmi'
	icon_state = "disk_kit"
	var/static/list/disk_icons = list(
		"data-red",
		"data-yellow",
		"data-blue",
		"data-purple",
		"data-green",
		"data-black",
		"data-white"
	)

/obj/random/design_disks/item_to_spawn()
	return pick(
		/obj/item/disk/design_disk/rapid_construction,
		/obj/item/disk/design_disk/ore_storage_bluespace,
		/obj/item/disk/design_disk/medical_upgrade,
		/obj/item/disk/design_disk/mining_upgrade,
		/obj/item/disk/design_disk/inducers,
		/obj/item/disk/design_disk/janitor_upgrade,
		/obj/item/disk/design_disk/telekinetic_gloves,
		/obj/item/disk/design_disk/advanced_stock_parts,
	)

/obj/random/design_disks/spawn_item()
	. = ..()
	var/obj/item/disk/design_disk/disk = .
	disk.icon_state = pick(disk_icons)
