ADMIN_VERB(sendFax, R_ADMIN|R_MOD|R_EVENT, "Send Fax", "Sends a fax to this machine.", ADMIN_CATEGORY_FUN_EVENT_KIT)
	var/list/fax_machines = list()
	for(var/obj/machinery/photocopier/faxmachine/M in GLOB.allfaxes)
		var/area/A = get_area(M)
		fax_machines["[A]"] = M

	var/selected = tgui_input_list(usr, "Choose a fax", "Fax", fax_machines)
	if(selected)
		var/obj/machinery/photocopier/faxmachine/sendto = fax_machines[selected]
		if(QDELETED(sendto))
			to_chat(usr, "Error: Fax machine ceased to exist!")
			return

		var/replyorigin = tgui_input_text(usr, "Please specify who the fax is coming from", "Origin")

		var/obj/item/paper/admin/P = new /obj/item/paper/admin( null ) //hopefully the null loc won't cause trouble for us

		P.admindatum = src
		P.origin = replyorigin
		P.destination = sendto

		P.adminbrowse()
