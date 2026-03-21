/datum/component/hose_connector/output/medical_sleeper/connected_reagents()
	var/obj/machinery/sleeper/S = carrier
	return S.beaker?.reagents
