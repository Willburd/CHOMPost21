/obj/machinery/computer/rdconsole_tg/remote_locked
	name = "Remote R&D Console"
	desc = "Used to remotely work with the research and develoupment lab. Locked by default."
	locked = TRUE
	circuit = /obj/item/circuitboard/rdconsole/locked

/obj/item/circuitboard/rdconsole/locked
	name = T_BOARD("Remote R&D control console")
	build_path = /obj/machinery/computer/rdconsole_tg/remote_locked
	hidden = TRUE // Limited availability
