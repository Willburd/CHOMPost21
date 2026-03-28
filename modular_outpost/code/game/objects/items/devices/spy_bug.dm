/obj/item/bug_monitor/telesci
	name = "\improper Telesci Probe Monitor"
	desc = "A simple tablet designed to monitor telescience probes."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pda-j"
	item_state = "electronic"

// Internal cams
/obj/machinery/camera/bug/telesci
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/bug/telesci/Initialize(mapload)
	. = ..()
	name = "Telesci-Probe #[rand(1000,9999)]"
	c_tag = name

// Actual probes
/obj/item/camerabug/telesci
	name = "Telesci-Probe"
	desc = "A large probe designed to work with the research camera network. Assists with telescience targeting. It's fragile!"
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "hydro2"
	item_state = "nothing"
	w_class = ITEMSIZE_COST_NORMAL
	layer = OBJ_LAYER
	camtype = /obj/machinery/camera/bug/telesci
	brokentype = /obj/item/brokenbug/spy/telesci

/obj/item/brokenbug/spy/telesci
	name = "broken telescience probe"
	desc = "A telescience camera probe... Or what's left of it."
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "hydro"
	item_state = "nothing"
	layer = OBJ_LAYER
	w_class = ITEMSIZE_COST_NORMAL
