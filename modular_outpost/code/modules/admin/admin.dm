/datum/admins/proc/sendFax()
	set category = "Fun.Event Kit"
	set name = "Send Fax"
	set desc = "Sends a fax to this machine"

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

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

		var/replyorigin = tgui_input_text(src.owner, "Please specify who the fax is coming from", "Origin")

		var/obj/item/paper/admin/P = new /obj/item/paper/admin( null ) //hopefully the null loc won't cause trouble for us
		faxreply = P

		P.admindatum = src
		P.origin = replyorigin
		P.destination = sendto

		P.adminbrowse()
