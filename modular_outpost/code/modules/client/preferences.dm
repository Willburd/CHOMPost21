//proc for setting disabilities
/datum/category_item/player_setup_item/general/body/proc/Disabilities_OP(mob/user)
	var/dat = "<body>"
	dat += "<html><center>"

	dat += "<h2>Addictions</h2>"
	dat += "Coffee: <a href='byond://?src=\ref[src];addictions=[ADDICT_COFFEE]'><b>[pref.addictions & ADDICT_COFFEE ? "Yes" : "No"]</b></a><br>"
	dat += "Nicotine: <a href='byond://?src=\ref[src];addictions=[ADDICT_NICOTINE]'><b>[pref.addictions & ADDICT_NICOTINE ? "Yes" : "No"]</b></a><br>"
	dat += "Alcohol: <a href='byond://?src=\ref[src];addictions=[ADDICT_ALCOHOL]'><b>[pref.addictions & ADDICT_ALCOHOL ? "Yes" : "No"]</b></a><br>"
	dat += "Painkiller: <a href='byond://?src=\ref[src];addictions=[ADDICT_PAINKILLER]'><b>[pref.addictions & ADDICT_PAINKILLER ? "Yes" : "No"]</b></a><br>"
	dat += "Bliss: <a href='byond://?src=\ref[src];addictions=[ADDICT_BLISS]'><b>[pref.addictions & ADDICT_BLISS ? "Yes" : "No"]</b></a><br>"
	dat += "Oxycodone: <a href='byond://?src=\ref[src];addictions=[ADDICT_OXY]'><b>[pref.addictions & ADDICT_OXY ? "Yes" : "No"]</b></a><br>"
	dat += "Hyperzine: <a href='byond://?src=\ref[src];addictions=[ADDICT_HYPER]'><b>[pref.addictions & ADDICT_HYPER ? "Yes" : "No"]</b></a><br>"
	dat += "Sustenance: <a href='byond://?src=\ref[src];addictions=[ADDICT_SUSTENANCE]'><b>[pref.addictions & ADDICT_SUSTENANCE ? "Yes" : "No"]</b></a><br>"
	dat += "<hr><br>"
	dat += "<a href='byond://?src=\ref[src];reset_disabilities=1'>Reset</a><br>"

	dat += "</center></html>"
	var/datum/browser/popup = new(user, "disabil", "<div align='center'>Choose Disabilities</div>", 350, 380, src)
	popup.set_content(dat)
	popup.open()
