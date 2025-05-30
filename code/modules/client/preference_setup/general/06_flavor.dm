/datum/category_item/player_setup_item/general/flavor
	name = "Flavor"
	sort_order = 6

/datum/category_item/player_setup_item/general/flavor/load_character(list/save_data)
	pref.flavor_texts["general"]	= save_data["flavor_texts_general"]
	pref.flavor_texts["head"]		= save_data["flavor_texts_head"]
	pref.flavor_texts["face"]		= save_data["flavor_texts_face"]
	pref.flavor_texts["eyes"]		= save_data["flavor_texts_eyes"]
	pref.flavor_texts["torso"]		= save_data["flavor_texts_torso"]
	pref.flavor_texts["arms"]		= save_data["flavor_texts_arms"]
	pref.flavor_texts["hands"]		= save_data["flavor_texts_hands"]
	pref.flavor_texts["legs"]		= save_data["flavor_texts_legs"]
	pref.flavor_texts["feet"]		= save_data["flavor_texts_feet"]
	pref.custom_link				= save_data["custom_link"]
	//Flavour text for robots.
	pref.flavour_texts_robot["Default"] = save_data["flavour_texts_robot_Default"]
	for(var/module in GLOB.robot_module_types)
		pref.flavour_texts_robot[module] = save_data["flavour_texts_robot_[module]"]

/datum/category_item/player_setup_item/general/flavor/save_character(list/save_data)
	save_data["flavor_texts_general"]	= pref.flavor_texts["general"]
	save_data["flavor_texts_head"]		= pref.flavor_texts["head"]
	save_data["flavor_texts_face"]		= pref.flavor_texts["face"]
	save_data["flavor_texts_eyes"]		= pref.flavor_texts["eyes"]
	save_data["flavor_texts_torso"]		= pref.flavor_texts["torso"]
	save_data["flavor_texts_arms"]		= pref.flavor_texts["arms"]
	save_data["flavor_texts_hands"]		= pref.flavor_texts["hands"]
	save_data["flavor_texts_legs"]		= pref.flavor_texts["legs"]
	save_data["flavor_texts_feet"]		= pref.flavor_texts["feet"]
	save_data["custom_link"]			= pref.custom_link

	save_data["flavour_texts_robot_Default"] = pref.flavour_texts_robot["Default"]
	for(var/module in GLOB.robot_module_types)
		save_data["flavour_texts_robot_[module]"] = pref.flavour_texts_robot[module]

/datum/category_item/player_setup_item/general/flavor/sanitize_character()
	return

// Moved from /datum/preferences/proc/copy_to()
/datum/category_item/player_setup_item/general/flavor/copy_to_mob(var/mob/living/carbon/human/character)
	character.flavor_texts["general"]	= pref.flavor_texts["general"]
	character.flavor_texts["head"]		= pref.flavor_texts["head"]
	character.flavor_texts["face"]		= pref.flavor_texts["face"]
	character.flavor_texts["eyes"]		= pref.flavor_texts["eyes"]
	character.flavor_texts["torso"]		= pref.flavor_texts["torso"]
	character.flavor_texts["arms"]		= pref.flavor_texts["arms"]
	character.flavor_texts["hands"]		= pref.flavor_texts["hands"]
	character.flavor_texts["legs"]		= pref.flavor_texts["legs"]
	character.flavor_texts["feet"]		= pref.flavor_texts["feet"]
	character.custom_link				= pref.custom_link

/datum/category_item/player_setup_item/general/flavor/tgui_data(mob/user, datum/tgui/ui, datum/tgui_state/state)
	var/list/data = ..()

	data["flavor_text_length"] = LAZYLEN(pref.flavor_texts["general"])

	return data

/datum/category_item/player_setup_item/general/flavor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	switch(action)
		if("flavor_text")
			SetFlavorText(user)
			return TOPIC_HANDLED
		if("flavour_text_robot")
			SetFlavourTextRobot(user)
			return TOPIC_HANDLED
		if("custom_link")
			var/new_link = strip_html_simple(tgui_input_text(user, "Enter a link to add on to your examine text! This should be a related image link/gallery, or things like your F-list. This is not the place for memes.", "Custom Link" , html_decode(pref.custom_link), max_length = 100, encode = TRUE,  prevent_enter = TRUE))
			if(new_link)
				if(length(new_link) > 100)
					to_chat(user, span_warning("Your entry is too long, it must be 100 characters or less."))
					return
				pref.custom_link = new_link
				log_admin("[user]/[user.ckey] set their custom link to [pref.custom_link]")

// README: This must stay for SetFlavorText to work!
/datum/category_item/player_setup_item/general/flavor/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["flavor_text"])
		switch(href_list["flavor_text"])
			if("open")
				pass()
			if("general")
				var/msg = strip_html_simple(tgui_input_text(user,"Give a general description of your character. This will be shown regardless of clothings. Put in \"!clear\" to make blank.","Flavor Text",html_decode(pref.flavor_texts[href_list["flavor_text"]]), multiline = TRUE, prevent_enter = TRUE))	//VOREStation Edit: separating out OOC notes
				if(CanUseTopic(user) && msg)
					if(msg == "!clear")
						msg = ""
					pref.flavor_texts[href_list["flavor_text"]] = msg
			else
				var/msg = strip_html_simple(tgui_input_text(user,"Set the flavor text for your [href_list["flavor_text"]]. Put in \"!clear\" to make blank.","Flavor Text",html_decode(pref.flavor_texts[href_list["flavor_text"]]), multiline = TRUE, prevent_enter = TRUE))
				if(CanUseTopic(user) && msg)
					if(msg == "!clear")
						msg = ""
					pref.flavor_texts[href_list["flavor_text"]] = msg
		SetFlavorText(user)
		return TOPIC_HANDLED
	else if(href_list["flavour_text_robot"])
		switch(href_list["flavour_text_robot"])
			if("open")
				pass()
			if("Default")
				var/msg = strip_html_simple(tgui_input_text(user,"Set the default flavour text for your robot. It will be used for any module without individual setting. Put in \"!clear\" to make blank.","Flavour Text",html_decode(pref.flavour_texts_robot["Default"]), multiline = TRUE, prevent_enter = TRUE))
				if(CanUseTopic(user) && msg)
					if(msg == "!clear")
						msg = ""
					pref.flavour_texts_robot[href_list["flavour_text_robot"]] = msg
			else
				var/msg = strip_html_simple(tgui_input_text(user,"Set the flavour text for your robot with [href_list["flavour_text_robot"]] module. If you leave this blank, default flavour text will be used for this module. Put in \"!clear\" to make blank.","Flavour Text",html_decode(pref.flavour_texts_robot[href_list["flavour_text_robot"]]), multiline = TRUE, prevent_enter = TRUE))
				if(CanUseTopic(user) && msg)
					if(msg == "!clear")
						msg = ""
					pref.flavour_texts_robot[href_list["flavour_text_robot"]] = msg
		SetFlavourTextRobot(user)
		return TOPIC_HANDLED
	else if(href_list["custom_link"])
		var/new_link = strip_html_simple(tgui_input_text(user, "Enter a link to add on to your examine text! This should be a related image link/gallery, or things like your F-list. This is not the place for memes.", "Custom Link" , html_decode(pref.custom_link), max_length = 100, encode = TRUE,  prevent_enter = TRUE))
		if(new_link && CanUseTopic(user))
			if(length(new_link) > 100)
				to_chat(user, span_warning("Your entry is too long, it must be 100 characters or less."))
				return
			pref.custom_link = new_link
			log_admin("[user]/[user.ckey] set their custom link to [pref.custom_link]")

	return ..()

/datum/category_item/player_setup_item/general/flavor/proc/SetFlavorText(mob/user)
	var/HTML = "<html><body>"
	HTML += "<tt><center>"
	HTML += span_bold("Set Flavor Text") + " <hr />"
	HTML += "Note: This is not *literal* flavor of your character. This is visual description of what they look like. <hr />"
	HTML += "<br></center>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=general'>General:</a> "
	HTML += TextPreview(pref.flavor_texts["general"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=head'>Head:</a> "
	HTML += TextPreview(pref.flavor_texts["head"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=face'>Face:</a> "
	HTML += TextPreview(pref.flavor_texts["face"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=eyes'>Eyes:</a> "
	HTML += TextPreview(pref.flavor_texts["eyes"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=torso'>Body:</a> "
	HTML += TextPreview(pref.flavor_texts["torso"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=arms'>Arms:</a> "
	HTML += TextPreview(pref.flavor_texts["arms"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=hands'>Hands:</a> "
	HTML += TextPreview(pref.flavor_texts["hands"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=legs'>Legs:</a> "
	HTML += TextPreview(pref.flavor_texts["legs"])
	HTML += "<br>"
	HTML += "<a href='byond://?src=\ref[src];flavor_text=feet'>Feet:</a> "
	HTML += TextPreview(pref.flavor_texts["feet"])
	HTML += "<br>"
	HTML += "<hr />"
	HTML += "<tt></body></html>"
	user << browse(HTML, "window=flavor_text;size=430x300")
	return

/datum/category_item/player_setup_item/general/flavor/proc/SetFlavourTextRobot(mob/user)
	var/HTML = "<html><body>"
	HTML += "<tt><center>"
	HTML += span_bold("Set Robot Flavour Text") + " <hr />"
	HTML += "<br></center>"
	HTML += "<a href='byond://?src=\ref[src];flavour_text_robot=Default'>Default:</a> "
	HTML += TextPreview(pref.flavour_texts_robot["Default"])
	HTML += "<hr />"
	for(var/module in GLOB.robot_module_types)
		HTML += "<a href='byond://?src=\ref[src];flavour_text_robot=[module]'>[module]:</a> "
		HTML += TextPreview(pref.flavour_texts_robot[module])
		HTML += "<br>"
	HTML += "<hr />"
	HTML += "<tt></body></html>"
	user << browse(HTML, "window=flavour_text_robot;size=430x300")
	return
