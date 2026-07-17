/datum/experiment/physical/start_engine
	name = "Engine Firing"
	description = "Assist engineering in the construction of one of the station's many types of engines."

/datum/experiment/physical/start_engine/register_events()
	if(!istype(currently_scanned_atom, /obj/machinery/the_singularitygen) && !istype(currently_scanned_atom, /obj/machinery/power/supermatter))
		linked_experiment_handler.announce_message("Incorrect object for experiment.")
		return FALSE

	RegisterSignal(currently_scanned_atom, COMSIG_ATOM_ENGINE_ONLINE, PROC_REF(started_engine))
	linked_experiment_handler.announce_message("Experiment ready to start.")
	return TRUE

/datum/experiment/physical/start_engine/unregister_events()
	UnregisterSignal(currently_scanned_atom, COMSIG_ATOM_ENGINE_ONLINE)

/datum/experiment/physical/start_engine/check_progress()
	. += EXPERIMENT_PROG_BOOL("Scan the core of one of the station's many types of engines before it is started, and begin the ignition process.", is_complete())

/datum/experiment/physical/start_engine/proc/started_engine(datum/source)
	SIGNAL_HANDLER
	finish_experiment(linked_experiment_handler)
