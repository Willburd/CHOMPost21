/// Extermely stripped back proc version of the status display. Can't change image during round and will just init to using whatever the prefab subtype tells it to.
/obj/structure/prop/fake_status_display
	icon = 'icons/obj/status_display.dmi'
	icon_state = "frame"
	plane = TURF_PLANE
	layer = ABOVE_WINDOW_LAYER
	name = "status display"
	anchored = TRUE
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
