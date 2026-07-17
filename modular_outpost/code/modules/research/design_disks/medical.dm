/obj/item/disk/design_disk/medical_upgrade
	name = "advanced medical design disk"
	desc = "A disk containing high quality medical tool designs."

/obj/item/disk/design_disk/medical_upgrade/Initialize(mapload)
	. = ..()
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/scalpel_laser2::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/bone_clamp::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/saw_manager::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/improved_analyzer::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/advanced_roller::id)
	blueprints += SSresearch.techweb_design_by_id(/datum/design_techweb/bioregen::id)
