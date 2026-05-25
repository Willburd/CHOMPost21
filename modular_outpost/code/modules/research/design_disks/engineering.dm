/obj/item/disk/design_disk/inducers
	name = "inducer design disk"
	desc = "A disk containing inducer designs."

/obj/item/disk/design_disk/inducers/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/inducer_eng::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/inducer_sci::id)

/obj/item/disk/design_disk/telekinetic_gloves
	name = "KAM design disk"
	desc = "A disk containing a kinesis assistance module design."

/obj/item/disk/design_disk/telekinetic_gloves/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/telekinetic_gloves::id)

/obj/item/disk/design_disk/advanced_stock_parts
	name = "advanced stock parts design disk"
	desc = "A disk containing advanced stock parts design."

/obj/item/disk/design_disk/advanced_stock_parts/Initialize(mapload)
	. = ..()
	for(var/design in /datum/techweb_node/parts_adv::design_ids)
		blueprints += SSresearch.techweb_design_by_id(design)
