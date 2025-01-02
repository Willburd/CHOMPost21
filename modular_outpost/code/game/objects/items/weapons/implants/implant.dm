//////////////////////////////
//	Compliance Implant
//////////////////////////////
/obj/item/implant/compliance/loadout
	var/initial = TRUE

/obj/item/implant/compliance/loadout/post_implant(mob/source, mob/living/user = usr)
	if(initial)
		initial = FALSE
		spawn(30)
			if(istype(source))
				var/newlaws = tgui_input_text(source, "Please Input Laws", "Compliance Laws", "", multiline = TRUE, prevent_enter = TRUE)
				newlaws = sanitize(newlaws,2048)
				if(newlaws)
					to_chat(source,"You set your laws to: <br>" + span_notice(newlaws))

					laws = newlaws //Organic
					initial = FALSE
					post_implant(source,source)
				else
					to_chat(source, span_danger("Invalid laws, compliance implant removed from starting loadout."))
					qdel(src)
		return
	. = ..()
