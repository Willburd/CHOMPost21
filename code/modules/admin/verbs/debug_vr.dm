/datum/admins/proc/quick_nif()
	set category = "Fun.Add Nif"
	set name = "Quick NIF"
	set desc = "Spawns a NIF into someone in quick-implant mode."

	var/input_NIF

	if(!check_rights(R_ADMIN|R_EVENT|R_DEBUG|R_MOD))	//CHOMPStation Edit TFF 24/4/19: Allow Devs to use Quick-NIF verb. 11/9/20: Also allow mods :3
		return

	var/mob/living/carbon/human/H = tgui_input_list(usr, "Pick a mob with a player","Quick NIF", player_list)

	if(!H)
		return

	if(!istype(H))
		to_chat(usr,span_warning("That mob type ([H.type]) doesn't support NIFs, sorry."))
		return

	if(!H.get_organ(BP_HEAD))
		to_chat(usr,span_warning("Target is unsuitable."))
		return

	if(H.nif)
		to_chat(usr,span_warning("Target already has a NIF."))
		return

	if(H.species.flags & NO_DNA)
		var/obj/item/nif/S = /obj/item/nif/bioadap
		input_NIF = initial(S.name)
		new /obj/item/nif/bioadap(H)
	else
		var/list/NIF_types = typesof(/obj/item/nif)
		var/list/NIFs = list()

		for(var/NIF_type in NIF_types)
			var/obj/item/nif/S = NIF_type
			NIFs[capitalize(initial(S.name))] = NIF_type

		var/list/show_NIFs = sortList(NIFs) // the list that will be shown to the user to pick from

		input_NIF = tgui_input_list(usr, "Pick the NIF type","Quick NIF", show_NIFs)
		var/chosen_NIF = NIFs[capitalize(input_NIF)]

		if(chosen_NIF)
			new chosen_NIF(H)
		else
			new /obj/item/nif(H)

	log_and_message_admins("Quick NIF'd [H.real_name] with a [input_NIF].", src)
	feedback_add_details("admin_verb","QNIF") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
