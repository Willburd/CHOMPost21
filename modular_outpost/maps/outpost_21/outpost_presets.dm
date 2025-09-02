// RX/TX
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/receiver/preset_right/outpost
	id = "outpost_rx"
	freq_listening = list(AI_FREQ, SCI_FREQ, MED_FREQ, SUP_FREQ, SRV_FREQ, COMM_FREQ, ENG_FREQ, SEC_FREQ, ENT_FREQ, EXP_FREQ)

/obj/machinery/telecomms/broadcaster/preset_right/outpost
	id = "outpost_tx"


// RELAYS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/relay/preset/outpost
	id = "Station Relay"
	listening_level = Z_LEVEL_OUTPOST_SURFACE
	autolinkers = list("station_relay")

/obj/machinery/telecomms/relay/preset/outpost/recyard
	id = "Reclamation Yard Relay"
	listening_level = Z_LEVEL_OUTPOST_ASTEROID
	autolinkers = list("roid_relay")

/obj/machinery/telecomms/relay/preset/outpost/confinementbeam
	id = "AI Platform Relay"
	listening_level = Z_LEVEL_OUTPOST_CONFINEMENTBEAM
	autolinkers = list("ai_relay")

/obj/machinery/telecomms/relay/preset/outpost/prospector
	id = "Prospector Relay"
	listening_level = Z_LEVEL_OUTPOST_VR // TEMP
	autolinkers = list("prospect_relay")

// HUB
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/hub/preset/outpost
	id = "Hub"
	network = "tcommsat"
	autolinkers = list("hub",
						"station_relay", "ai_relay", "prospect_relay", "roid_relay", "c_relay",
						"science", "medical", "supply", "service", "common", "command", "engineering", "security", "unused","explorer",
						"receiverA", "broadcasterA")


// BUS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/bus/preset_one/outpost
	freq_listening = list(SCI_FREQ, MED_FREQ)
	autolinkers = list("processor1", "science", "medical")

/obj/machinery/telecomms/bus/preset_two/outpost
	freq_listening = list(SUP_FREQ, SRV_FREQ, EXP_FREQ)
	autolinkers = list("processor2", "supply", "service", "unused")

/obj/machinery/telecomms/bus/preset_three/outpost
	freq_listening = list(SEC_FREQ, COMM_FREQ)
	autolinkers = list("processor3", "security", "command")

/obj/machinery/telecomms/bus/preset_four/outpost
	freq_listening = list(PUB_FREQ, ENT_FREQ, BDCM_FREQ)
	autolinkers = list("processor4", "common")

/obj/machinery/telecomms/bus/preset_five/outpost // Unique to us
	id = "Bus 5"
	network = "tcommsat"
	freq_listening = list(ENG_FREQ, AI_FREQ)
	autolinkers = list("processor5", "engineering")


// PROCESSORS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/processor/preset_five // Unique to us
	id = "Processor 5"
	network = "tcommsat"
	autolinkers = list("processor5")


// SERVERS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/server/presets/service/outpost
	freq_listening = list(SRV_FREQ, EXP_FREQ)
	autolinkers = list("service", "explorer")


// MISC
/////////////////////////////////////////////////////////////////////////////////////////
/datum/map/outpost/default_internal_channels()
	return list(
		num2text(PUB_FREQ) = list(),
		num2text(AI_FREQ)  = list(ACCESS_SYNTH),
		num2text(ENT_FREQ) = list(),
		num2text(ERT_FREQ) = list(ACCESS_CENT_SPECOPS),
		num2text(COMM_FREQ)= list(ACCESS_HEADS),
		num2text(ENG_FREQ) = list(ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS,ACCESS_ROBOTICS),
		num2text(MED_FREQ) = list(ACCESS_MEDICAL_EQUIP),
		num2text(MED_I_FREQ)=list(ACCESS_MEDICAL_EQUIP),
		num2text(SEC_FREQ) = list(ACCESS_SECURITY),
		num2text(SEC_I_FREQ)=list(ACCESS_SECURITY),
		num2text(SCI_FREQ) = list(ACCESS_TOX,ACCESS_XENOBIOLOGY),
		num2text(SUP_FREQ) = list(ACCESS_CARGO),
		num2text(SRV_FREQ) = list(ACCESS_JANITOR, ACCESS_HYDROPONICS),
		num2text(EXP_FREQ) = list(ACCESS_EXPLORER)
	)

/obj/item/multitool/outpost_buffered
	name = "pre-linked multitool (outpost hub)"
	desc = "This multitool has already been linked to the outpost telecomms hub and can be used to configure one (1) relay."

/obj/item/multitool/outpost_buffered/Initialize()
	. = ..()
	buffer = locate(/obj/machinery/telecomms/hub/preset/outpost)
