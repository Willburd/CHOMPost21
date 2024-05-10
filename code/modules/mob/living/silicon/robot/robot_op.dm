// Technically the crew monitor exists, but this helps you learn the station easier
/mob/living/silicon/robot/verb/current_location()
	set category = "Abilities"
	set name = "Display Location Name"
	var/area/A = get_area(src)
	if(A)
		to_chat(src, "Current Location: [sanitize(A.get_name())]")
