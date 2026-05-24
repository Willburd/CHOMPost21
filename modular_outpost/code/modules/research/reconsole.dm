/obj/machinery/computer/rdconsole_tg/remote_locked
	name = "Remote R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	circuit = /obj/item/circuitboard/rdconsole/locked

/obj/item/circuitboard/rdconsole/locked
	name = T_BOARD("Remote R&D control console")
	build_path = /obj/machinery/computer/rdconsole_tg/remote_locked
	hidden = TRUE // Limited availability


/obj/machinery/computer/rdconsole_tg/robotics_remote
	name = "Robotics R&D Console"
	desc = "Used to remotely work with the research and development lab. Locked by default."
	locked = TRUE
	req_access = list(ACCESS_ROBOTICS)
	circuit = /obj/item/circuitboard/rdconsole/robotics_locked

/obj/item/circuitboard/rdconsole/robotics_locked
	name = T_BOARD("Robotics R&D console")
	build_path = /obj/machinery/computer/rdconsole_tg/robotics_remote
	hidden = TRUE // Limited availability
