/obj/item/disk/design_disk/ore_storage_bluespace
	name = "bluespace ore storage design disk"
	desc = "A disk containing bluespace ore storage designs."

/obj/item/disk/design_disk/ore_storage_bluespace/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/board/ore_silo::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/ore_holding::id)

/obj/item/disk/design_disk/mining_upgrade
	name = "mining design disk"
	desc = "A disk containing advanced mining tool designs."

/obj/item/disk/design_disk/mining_upgrade/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/drill_diamond::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/mining_scanner::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/plasmacutter::id)

/obj/item/disk/design_disk/janitor_upgrade
	name = "janitorial design disk"
	desc = "A disk containing advanced cleaning designs."

/obj/item/disk/design_disk/janitor_upgrade/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/advmop::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/light_replacer::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/maglight::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/shovel::id)
