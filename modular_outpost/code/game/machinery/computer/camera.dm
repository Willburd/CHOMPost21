// Custom computer prefabs, mostly for camera networks
/obj/machinery/computer/security/research_rd
	name = "Research department camera monitor"
	desc = "Used to access the research department cameras."
	icon_keyboard = "mining_key"
	icon_screen = "mining"
	network = list(NETWORK_RESEARCH, NETWORK_RESEARCH_OUTPOST, NETWORK_XENOBIO)
	circuit = /obj/item/circuitboard/security
	light_color = "#e9aaec"

/obj/machinery/computer/security/bunker_only
	name = "Bunker camera monitor"
	desc = "Used to access the bunker cameras."
	icon_keyboard = "mining_key"
	icon_screen = "mining"
	network = list(NETWORK_BUNKER,NETWORK_FOUNDATIONS)
	circuit = /obj/item/circuitboard/security
	light_color = "#e9aaec"
