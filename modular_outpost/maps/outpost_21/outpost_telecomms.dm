// ### Preset machines  ###


// #### Relays ####
// Telecomms doesn't know about connected z-levels, so we need relays even for the other surface levels.
/obj/machinery/telecomms/relay/preset/outpost/basement
	id = "Basement Relay"
	listening_level = Z_LEVEL_OUTPOST_BASEMENT
	autolinkers = list("l_relay")

/obj/machinery/telecomms/relay/preset/outpost/main
	id = "Main Complex Relay"
	listening_level = Z_LEVEL_OUTPOST_SURFACE
	autolinkers = list("m_relay")

/obj/machinery/telecomms/relay/preset/outpost/upper
	id = "Upper Floors Relay"
	listening_level = Z_LEVEL_OUTPOST_UPPER
	autolinkers = list("s_relay")

/obj/machinery/telecomms/relay/preset/outpost/confinementbeam
	id = "Confinement Platform Relay"
	listening_level = Z_LEVEL_OUTPOST_CONFINEMENTBEAM
	autolinkers = list("k_relay")

/obj/machinery/telecomms/hub/preset/outpost
	id = "Hub"
	network = "tcommsat"
	autolinkers = list("hub", "relay", "c_relay", "l_relay", "m_relay", "s_relay", "k_relay", "r_relay", "science", "medical",
	"supply", "service", "common", "command", "engineering", "security", "unused", "hb_relay","explorer", "unused" ,
	"receiverA", "broadcasterA")

/obj/machinery/telecomms/receiver/preset_right/outpost
	id = "outpost_rx"
	freq_listening = list(AI_FREQ, SCI_FREQ, MED_FREQ, SUP_FREQ, SRV_FREQ, COMM_FREQ, ENG_FREQ, SEC_FREQ, ENT_FREQ, EXP_FREQ)

/obj/machinery/telecomms/broadcaster/preset_right/outpost
	id = "outpost_tx"

/obj/machinery/telecomms/bus/preset_two/outpost
	freq_listening = list(SUP_FREQ, SRV_FREQ, EXP_FREQ)

/obj/machinery/telecomms/server/presets/service/outpost
	freq_listening = list(SRV_FREQ, EXP_FREQ)
	autolinkers = list("service", "explorer")

/datum/map/outpost/default_internal_channels()
	return list(
		num2text(PUB_FREQ) = list(),
		num2text(AI_FREQ)  = list(access_synth),
		num2text(ENT_FREQ) = list(),
		num2text(ERT_FREQ) = list(access_cent_specops),
		num2text(COMM_FREQ)= list(access_heads),
		num2text(ENG_FREQ) = list(access_engine_equip, access_atmospherics),
		num2text(MED_FREQ) = list(access_medical_equip),
		num2text(MED_I_FREQ)=list(access_medical_equip),
		num2text(SEC_FREQ) = list(access_security),
		num2text(SEC_I_FREQ)=list(access_security),
		num2text(SCI_FREQ) = list(access_tox,access_robotics,access_xenobiology),
		num2text(SUP_FREQ) = list(access_cargo),
		num2text(SRV_FREQ) = list(access_janitor, access_hydroponics),
		num2text(EXP_FREQ) = list(access_explorer)
	)

/obj/item/multitool/outpost_buffered
	name = "pre-linked multitool (outpost hub)"
	desc = "This multitool has already been linked to the outpost telecomms hub and can be used to configure one (1) relay."

/obj/item/multitool/outpost_buffered/Initialize()
	. = ..()
	buffer = locate(/obj/machinery/telecomms/hub/preset/outpost)


/*
// wip attempt at asteroid telecoms

// Asteroid reclamation yard tcomms, uniquely configured, barebones as hell
/obj/machinery/telecomms/relay/preset/asteroid
	id = "Reclamation Yard Relay"
	network = "tcommsat"
	listening_level = Z_LEVEL_OUTPOST_ASTEROID
	autolinkers = list("y_relay")

/obj/machinery/telecomms/hub/preset/asteroid
	id = "Hub"
	network = "tcommsat"
	autolinkers = list("y_hub", "y_relay", "receiverA", "broadcasterA", "y_common") // bare minimum

/obj/machinery/telecomms/receiver/preset_right/asteroid
	id = "reclamation_rx"
	network = "tcommsat"
	freq_listening = list(PUB_FREQ, AI_FREQ, ENT_FREQ)

/obj/machinery/telecomms/broadcaster/preset_right/asteroid
	id = "reclamation_tx"
	network = "tcommsat"

/obj/machinery/telecomms/bus/preset/asteroid
	id = "Bus"
	network = "tcommsat"
	freq_listening = list(PUB_FREQ, AI_FREQ, ENT_FREQ)
	autolinkers = list("y_processor", "y_common")

/obj/machinery/telecomms/processor/preset/asteroid
	id = "Processor"
	network = "tcommsat"
	autolinkers = list("y_processor") // processors are sort of isolated; they don't need backward links

/obj/machinery/telecomms/server/presets/asteroid
	network = "tcommsat"
	freq_listening = list(PUB_FREQ, AI_FREQ, ENT_FREQ)
	autolinkers = list("y_common")

/obj/item/multitool/asteroid_buffered
	name = "pre-linked multitool (reclamation-yard hub)"
	desc = "This multitool has already been linked to the reclamation-yard telecomms hub and can be used to configure one (1) relay."

/obj/item/multitool/asteroid_buffered/Initialize()
	. = ..()
	buffer = locate(/obj/machinery/telecomms/hub/preset/asteroid)
*/
