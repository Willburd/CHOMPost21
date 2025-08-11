// RX/TX
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/receiver/preset_right/ocean
	id = "ocean_rx"
	freq_listening = list(AI_FREQ, SCI_FREQ, MED_FREQ, SUP_FREQ, SRV_FREQ, COMM_FREQ, ENG_FREQ, SEC_FREQ, ENT_FREQ, EXP_FREQ)

/obj/machinery/telecomms/broadcaster/preset_right/ocean
	id = "ocean_tx"


// RELAYS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/relay/preset/ocean
	id = "Station Relay"
	listening_level = Z_LEVEL_ocean_SURFACE
	autolinkers = list("station_relay")

/obj/machinery/telecomms/relay/preset/ocean/recyard
	id = "Reclamation Yard Relay"
	listening_level = Z_LEVEL_ocean_ASTEROID
	autolinkers = list("roid_relay")

/obj/machinery/telecomms/relay/preset/ocean/confinementbeam
	id = "AI Platform Relay"
	listening_level = Z_LEVEL_ocean_CONFINEMENTBEAM
	autolinkers = list("ai_relay")

/obj/machinery/telecomms/relay/preset/ocean/prospector
	id = "Prospector Relay"
	listening_level = Z_LEVEL_ocean_VR // TEMP
	autolinkers = list("prospect_relay")

// HUB
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/hub/preset/ocean
	id = "Hub"
	network = "tcommsat"
	autolinkers = list("hub",
						"station_relay", "ai_relay", "prospect_relay", "roid_relay", "c_relay",
						"science", "medical", "supply", "service", "common", "command", "engineering", "security", "unused","explorer",
						"receiverA", "broadcasterA")


// BUS
/////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/telecomms/bus/preset_one/ocean
	freq_listening = list(SCI_FREQ, MED_FREQ)
	autolinkers = list("processor1", "science", "medical")

/obj/machinery/telecomms/bus/preset_two/ocean
	freq_listening = list(SUP_FREQ, SRV_FREQ, EXP_FREQ)
	autolinkers = list("processor2", "supply", "service", "unused")

/obj/machinery/telecomms/bus/preset_three/ocean
	freq_listening = list(SEC_FREQ, COMM_FREQ)
	autolinkers = list("processor3", "security", "command")

/obj/machinery/telecomms/bus/preset_four/ocean
	freq_listening = list(PUB_FREQ, ENT_FREQ, BDCM_FREQ)
	autolinkers = list("processor4", "common")

/obj/machinery/telecomms/bus/preset_five/ocean // Unique to us
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
/obj/machinery/telecomms/server/presets/service/ocean
	freq_listening = list(SRV_FREQ, EXP_FREQ)
	autolinkers = list("service", "explorer")


// MISC
/////////////////////////////////////////////////////////////////////////////////////////
/datum/map/ocean/default_internal_channels()
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

/obj/item/multitool/ocean_buffered
	name = "pre-linked multitool (outpost 22 hub)"
	desc = "This multitool has already been linked to the ocean telecomms hub and can be used to configure one (1) relay."

/obj/item/multitool/ocean_buffered/Initialize()
	. = ..()
	buffer = locate(/obj/machinery/telecomms/hub/preset/ocean)
