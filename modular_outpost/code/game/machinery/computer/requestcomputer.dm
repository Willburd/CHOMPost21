/obj/machinery/computer/supply_request_computeralt
	name = "requests console"
	desc = "A console intended to send requests to different departments on the station."
	icon_screen = "comm_monitor"
	icon_keyboard = "id_key"
	var/obj/machinery/requests_console/internal_console = /obj/machinery/requests_console
	circuit = /obj/item/circuitboard/supply_request_computeralt
	light_color = "#e9aaec"

/obj/machinery/computer/supply_request_computeralt/Initialize(mapload)
	. = ..()
	if(ispath(internal_console))
		internal_console = new internal_console(src)
		name = internal_console.name
		desc = internal_console.desc
		internal_console.name = ""
		internal_console.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/machinery/computer/supply_request_computeralt/Destroy()
	QDEL_NULL(internal_console)
	. = ..()

/obj/machinery/computer/supply_request_computeralt/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/multitool) || istype(O, /obj/item/card/id) || istype(O, /obj/item/stamp))
		// Forward these to the internal console
		return internal_console.attackby(O,user)
	. = ..()

/obj/machinery/computer/supply_request_computeralt/attack_hand(user as mob)
	if(!internal_console)
		return
	if(..(user))
		return
	tgui_interact(user)

/obj/machinery/computer/supply_request_computeralt/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RequestConsole", "[internal_console.department] Request Console")
		ui.open()

/obj/machinery/computer/supply_request_computeralt/tgui_data(mob/user)
	return internal_console.tgui_data(user)

/obj/machinery/computer/supply_request_computeralt/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	add_fingerprint(ui.user)

	. = internal_console.tgui_act(action,params,ui)
	switch(action)
		if("print")
			var/obj/item/paper/P = locate(/obj/item/paper) in src
			P.forceMove(get_turf(src))

/obj/machinery/computer/supply_request_computeralt/update_icon()
	if(internal_console.newmessagepriority > 0)
		icon_screen = "comm_logs"
	else
		icon_screen = "comm_monitor"
	. = ..()

// Hacky shit
/obj/machinery/requests_console/update_icon()
	if(istype(loc,/obj/machinery/computer/supply_request_computeralt))
		loc.update_icon()
	. = ..()

/obj/machinery/requests_console/audible_message(var/message, var/deaf_message, var/hearing_distance, var/radio_message, var/runemessage)
	if(istype(loc,/obj/machinery/computer/supply_request_computeralt))
		return loc.audible_message(message, deaf_message, hearing_distance, radio_message, runemessage)
	. = ..()

// Subtypes
/obj/machinery/computer/supply_request_computeralt/cargo
	name = "Cargo RC"
	internal_console = /obj/machinery/requests_console/preset/cargo

/obj/machinery/computer/supply_request_computeralt/security
	name = "Security RC"
	internal_console = /obj/machinery/requests_console/preset/security

/obj/machinery/computer/supply_request_computeralt/engineering
	name = "Engineering RC"
	internal_console = /obj/machinery/requests_console/preset/engineering

/obj/machinery/computer/supply_request_computeralt/atmos
	name = "Atmospherics RC"
	internal_console = /obj/machinery/requests_console/preset/atmos

/obj/machinery/computer/supply_request_computeralt/medical
	name = "Medical RC"
	internal_console = /obj/machinery/requests_console/preset/medical

/obj/machinery/computer/supply_request_computeralt/research
	name = "Research RC"
	internal_console = /obj/machinery/requests_console/preset/research

/obj/machinery/computer/supply_request_computeralt/janitor
	name = JOB_JANITOR + " RC"
	internal_console = /obj/machinery/requests_console/preset/janitor

/obj/machinery/computer/supply_request_computeralt/bridge
	name = "Bridge RC"
	internal_console = /obj/machinery/requests_console/preset/bridge

// Heads
/obj/machinery/computer/supply_request_computeralt/ce
	name = JOB_CHIEF_ENGINEER + " RC"
	internal_console = /obj/machinery/requests_console/preset/ce

/obj/machinery/computer/supply_request_computeralt/cmo
	name = JOB_CHIEF_MEDICAL_OFFICER + " RC"
	internal_console = /obj/machinery/requests_console/preset/cmo

/obj/machinery/computer/supply_request_computeralt/hos
	name = JOB_HEAD_OF_SECURITY + " RC"
	internal_console = /obj/machinery/requests_console/preset/hos

/obj/machinery/computer/supply_request_computeralt/rd
	name = JOB_RESEARCH_DIRECTOR + " RC"
	internal_console = /obj/machinery/requests_console/preset/rd

/obj/machinery/computer/supply_request_computeralt/captain
	name = "Captain RC"
	internal_console = /obj/machinery/requests_console/preset/captain

/obj/machinery/computer/supply_request_computeralt/ai
	name = JOB_AI + " RC"
	internal_console = /obj/machinery/requests_console/preset/ai

/obj/machinery/computer/supply_request_computeralt/hop
	name = "Head of personnel RC"
	internal_console = /obj/machinery/requests_console/preset/hop
