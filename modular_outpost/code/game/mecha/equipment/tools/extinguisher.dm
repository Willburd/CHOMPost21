/obj/item/mecha_parts/mecha_equipment/tool/extinguisher/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/mecha_parts/mecha_equipment/tool/extinguisher/destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/mecha_parts/mecha_equipment/tool/extinguisher/process()
	if(!chassis)
		return
	if(reagents.total_volume >= reagents.maximum_volume)
		return
	if(chassis.use_power(15))
		reagents.add_reagent(REAGENT_ID_FIREFOAM, 10)
