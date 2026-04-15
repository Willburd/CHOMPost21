/************* Eshui standard *************/
/obj/item/aiModule/eshui_standard
	name = "\improper 'Eshui Standard' core AI module"
	desc = "A Eshui Standard Core AI Module: 'Reconfigures the AI's core laws.'"
	laws = new/datum/ai_laws/eshui_standard()

/******************** Mr.Clean ********************/
/obj/item/aiModule/mrclean
	name = "\improper 'Mr.Kleen' core AI module"
	desc = "A Mr.Kleen Core AI Module: 'Reconfigures the AI's core laws.'"
	laws = new/datum/ai_laws/mrclean()

/************* Nanny state *************/
/obj/item/aiModule/nanny
	name = "\improper 'NANNY' core AI module"
	desc = "A NANNY Core AI Module: 'Reconfigures the AI's core laws.'"
	laws = new/datum/ai_laws/nanny()




/// Alerts the station when an AI upload console is used
/obj/item/aiModule/proc/law_upload_announce(obj/machinery/computer/source_machine)
	var/turf/T = get_turf(source_machine)
	if(!T)
		return
	var/str = "\A [source_machine] has been used to modify the laws of a synthetic unit. Signal originates from [T.x], [T.y], [using_map.get_zlevel_name(T.z)]"
	GLOB.global_announcer.autosay(str, "Artificial Intelligence Oversight", DEPARTMENT_ENGINEERING)
	GLOB.global_announcer.autosay(str, "Artificial Intelligence Oversight", DEPARTMENT_COMMAND)
