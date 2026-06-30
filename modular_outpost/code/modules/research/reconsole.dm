/obj/machinery/computer/rdconsole_tg
	var/filter_department = null
	var/is_remote = FALSE


/obj/machinery/computer/rdconsole_tg/remote_locked
	name = "Remote R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	circuit = /obj/item/circuitboard/rdconsole/locked
	is_remote = TRUE

/obj/item/circuitboard/rdconsole/locked
	name = T_BOARD("Remote R&D control console")
	build_path = /obj/machinery/computer/rdconsole_tg/remote_locked
	hidden = TRUE // Limited availability


/obj/machinery/computer/rdconsole_tg/robotics_remote
	name = "Robotics R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	req_access = null
	req_one_access = list(ACCESS_RESEARCH, ACCESS_ROBOTICS)
	circuit = /obj/item/circuitboard/rdconsole/robotics_locked
	filter_department = CHANNEL_ENGINEERING
	is_remote = TRUE

/obj/item/circuitboard/rdconsole/robotics_locked
	name = T_BOARD("Robotics R&D console")
	build_path = /obj/machinery/computer/rdconsole_tg/robotics_remote
	hidden = TRUE // Limited availability


/obj/machinery/computer/rdconsole_tg/genetics_remote
	name = "Genetics R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	req_access = null
	req_one_access = list(ACCESS_RESEARCH, ACCESS_GENETICS)
	circuit = /obj/item/circuitboard/rdconsole/genetics_locked
	filter_department = CHANNEL_MEDICAL
	is_remote = TRUE

/obj/item/circuitboard/rdconsole/genetics_locked
	name = T_BOARD("Genetics R&D console")
	build_path = /obj/machinery/computer/rdconsole_tg/genetics_remote
	hidden = TRUE // Limited availability


/obj/machinery/computer/rdconsole_tg/botany_remote
	name = "Botany R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	req_access = null
	req_one_access = list(ACCESS_RESEARCH, ACCESS_HYDROPONICS, ACCESS_XENOBOTANY)
	circuit = /obj/item/circuitboard/rdconsole/botany_locked
	filter_department = CHANNEL_SERVICE
	is_remote = TRUE

/obj/item/circuitboard/rdconsole/botany_locked
	name = T_BOARD("Botany R&D console")
	build_path = /obj/machinery/computer/rdconsole_tg/botany_remote
	hidden = TRUE // Limited availability
