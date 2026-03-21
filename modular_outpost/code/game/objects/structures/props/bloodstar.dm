/// Extermely stripped back proc version of the status display. Can't change image during round and will just init to using whatever the prefab subtype tells it to.
/obj/structure/prop/fake_status_display
	icon = 'icons/obj/status_display.dmi'
	icon_state = "frame"
	plane = TURF_PLANE
	layer = ABOVE_WINDOW_LAYER
	name = "status display"
	density = FALSE
	unacidable = TRUE

/obj/structure/prop/fake_status_display/proc/display_alert(var/newlevel)
	switch(newlevel)
		if("green")	set_light(l_range = 2, l_power = 0.25, l_color = "#00ff00")
		if("yellow")	set_light(l_range = 2, l_power = 0.25, l_color = "#ffff00")
		if("violet")	set_light(l_range = 2, l_power = 0.25, l_color = "#9933ff")
		if("orange")	set_light(l_range = 2, l_power = 0.25, l_color = "#ff9900")
		if("blue")	set_light(l_range = 2, l_power = 0.25, l_color = "#1024A9")
		if("red")	set_light(l_range = 4, l_power = 0.9, l_color = "#ff0000")
		if("delta")	set_light(l_range = 4, l_power = 0.9, l_color = "#FF6633")
	set_picture("status_display_[newlevel]")

/obj/structure/prop/fake_status_display/proc/set_picture()
	add_overlay(image('icons/obj/status_display.dmi', icon_state=state))

/obj/structure/prop/fake_status_display/Destroy()
	cut_overlays()
	. = ..()

// Subtypes
/obj/structure/prop/fake_status_display/green/Initialize(mapload)
	. = ..()
	display_alert(SEC_LEVEL_GREEN)

/obj/structure/prop/fake_status_display/yellow/Initialize(mapload)
	. = ..()
	display_alert(SEC_LEVEL_YELLOW)

/obj/structure/prop/fake_status_display/blue/Initialize(mapload)
	. = ..()
	display_alert(SEC_LEVEL_BLUE)

/obj/structure/prop/fake_status_display/red/Initialize(mapload)
	. = ..()
	display_alert(SEC_LEVEL_RED)

/obj/structure/prop/fake_status_display/delta/Initialize(mapload)
	. = ..()
	display_alert(SEC_LEVEL_DELTA)

/obj/structure/prop/fake_status_display/nt/Initialize(mapload)
	. = ..()
	set_picture("default")

/obj/structure/prop/fake_status_display/entertainment/Initialize(mapload)
	. = ..()
	set_picture("entertainment")

/obj/structure/prop/fake_status_display/bsod/Initialize(mapload)
	. = ..()
	set_picture("ai_bsod")



/// Fake Supermatter
/obj/structure/prop/fake_supermatter
	name = "Supermatter"
	desc = "A strangely translucent and iridescent crystal. " + span_red("Something appears off about it.")
	icon = 'icons/obj/supermatter.dmi'
	icon_state = "darkmatter"
	plane = MOB_PLANE // So people can walk behind the top part
	layer = ABOVE_MOB_LAYER // So people can walk behind the top part
	unacidable = TRUE
	light_range = 4

/obj/structure/prop/fake_supermatter/shielded
	icon_state = "psy_shielded_unused"

/obj/structure/prop/fake_supermatter/alt_color
	icon_state = "psy_unused"



/// Fake smes
/obj/structure/prop/fake_smes
	name = "power storage unit"
	desc = "A high-capacity superconducting magnetic energy storage (SMES) unit. This one is locked down!"
	icon = 'icons/obj/power.dmi'
	icon_state = "smes"
	unacidable = TRUE



/// Circulator for TEG
/obj/structure/prop/fake_circulator
	name = "circulator"
	desc = "A gas circulator turbine and heat exchanger."
	icon = 'icons/obj/power.dmi'
	icon_state = "circ-unassembled"
	unacidable = TRUE

/obj/structure/prop/fake_circulator/assembled
	icon_state = "circ-assembled"



/// Generator for TEG
/obj/structure/prop/fake_generator
	name = "thermoelectric generator"
	desc = "It's a high efficiency thermoelectric generator."
	icon = 'icons/obj/power.dmi'
	icon_state = "teg-unassembled"
	unacidable = TRUE

/obj/structure/prop/fake_generator/assembled
	icon_state = "teg-assembled"
