/obj/item/implant/blood_sugar
	name = "blood sugar monitor implant"
	desc = "An alarm which monitors host blood sugar, and emits a warning when it falls beneath dangerous levels."
	known_implant = TRUE
	VAR_PRIVATE/previous_nutrition = 0

/obj/item/implant/blood_sugar/get_data()
	var/dat = {"
"} + span_bold("Implant Specifications:") + {"<BR>
"} + span_bold("Name:") + {"Veymed Blood Sugar Sensor<BR>
"} + span_bold("Life:") + {"Activates upon implantation.<BR>
"} + span_bold("Important Notes:") + {"Alerts host to low blood sugar.<BR>
<HR>
"} + span_bold("Implant Details:") + {"<BR>
"} + span_bold("Function:") + {"Plays a audible warning when host blood sugar becomes dangerously low."}
	return dat

/obj/item/implant/blood_sugar/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/implant/blood_sugar/process()
	if(!implanted)
		previous_nutrition = 0
		return PROCESS_KILL
	if(!isliving(imp_in))
		previous_nutrition = 0
		return PROCESS_KILL
	var/mob/living/M = imp_in
	if(M.stat == DEAD) // Skip
		return

	// Major incident, possibly trapped unconcious
	if(M.nutrition < 5)
		playsound(get_turf(src), 'sound/machines/quiet_beep.ogg', 10)

	// Handle only when it ticks down
	else if(M.nutrition < previous_nutrition)
		var/low_threshold = /datum/component/diabetic::nutrition_threshold + 40
		var/critical_threshold = /datum/component/diabetic::nutrition_critical

		// Oh fug
		if(M.nutrition < critical_threshold && previous_nutrition >= critical_threshold)
			to_chat(M, span_danger("Critical blood sugar detected."))
			playsound(get_turf(src), 'sound/machines/defib_ready.ogg', 15)
		// Early notice
		else if(M.nutrition < low_threshold && previous_nutrition >= low_threshold)
			to_chat(M, span_warning("Low blood sugar detected."))
			playsound(get_turf(src), 'sound/machines/quiet_beep.ogg', 10)

	previous_nutrition = M.nutrition

/obj/item/implant/blood_sugar/post_implant(mob/source as mob)
	previous_nutrition = 0
	START_PROCESSING(SSobj, src)
