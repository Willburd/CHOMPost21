// Technically the crew monitor exists, but this helps you learn the station easier
/mob/living/silicon/robot/verb/current_location()
	set category = "Abilities.Silicon"
	set name = "Display Location Name"
	var/area/A = get_area(src)
	if(A)
		to_chat(src, "Current Location: [sanitize(A.get_name())]")

/mob/living/silicon/robot/verb/toggle_prybar()
	set category = "Abilities.Silicon"
	set name = "Toggle Crowbar Jaws"
	// Because these are actually not puppyjaws and are a reskined cyborg crowbar...
	// And I am tired of chewing up the floors stupidly as I try to defend myself as a borg
	var/obj/item/tool/crowbar/cyborg/C = locate() in module.modules
	if(C)
		if(initial(C.pry))
			C.pry = !C.pry
			if(C.pry)
				C.tool_qualities = list(TOOL_CROWBAR)
				to_chat(usr,span_notice("You will no longer use your [C] to open doors or dismantle floors."))
			else
				C.tool_qualities = list()
				to_chat(usr,span_warning("Your [C] will now open doors and dismantle floors."))
