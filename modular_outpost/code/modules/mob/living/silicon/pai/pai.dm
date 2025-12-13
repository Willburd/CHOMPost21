GLOBAL_LIST_INIT(pai_accessible_objects, list( \
		/obj/structure/closet, \
		/obj/structure/fence/door, \
		/obj/machinery/light_switch, \
		/obj/machinery/button, \
		/obj/machinery/access_button, \
		/obj/machinery/shower, \
		/obj/structure/lift/panel, \
		/obj/structure/lift/button, \
		/obj/machinery/disposal, \
		/obj/machinery/disposal/mail_reciever, \
		/obj/structure/musician, \
		/obj/machinery/media/jukebox, \
		/obj/machinery/computer/security/telescreen, \
		/obj/machinery/conveyor_switch, \
		/obj/machinery/computer/security/telescreen/bodycamera, \
		/obj/machinery/computer/crew, \
		/obj/machinery/computer/atmos_alert, \
		/obj/machinery/computer/power_monitor, \
		/obj/machinery/computer/general_air_control, \
		/obj/machinery/computer/station_alert \
		))

/mob/living/silicon/pai/UnarmedAttack(atom/A, proximity_flag)
	if(A.type in GLOB.pai_accessible_objects) // direct paths not a type-check
		var/obj/O = A
		O.attack_hand(src)
		return
	if(istype(A,/obj/item/flashlight/lamp))
		var/obj/item/flashlight/lamp/L = A
		L.toggle_light()
		return
	if(istype(A,/obj/machinery/computer)) // All other computers explain why it's not compatible
		to_chat(src,span_warning("A firewall prevents you from interfacing with this device!"))
		return
	. = ..()
