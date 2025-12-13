
/obj/machinery/sleeper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/hose_connector/output/medical_sleeper)
