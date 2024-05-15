//proc for setting disabilities
/datum/category_item/player_setup_item/general/body/proc/Disabilities_OP(mob/user)
	var/dat = "<body>"
	dat += "<html><center>"

	dat += "<h2>Genetics</h2>"
	dat += "Anxiety: <a href='?src=\ref[src];disabilities=[NERVOUS]'><b>[pref.disabilities & NERVOUS ? "Yes" : "No"]</b></a><br>"
	dat += "Chronic Cough: <a href='?src=\ref[src];disabilities=[COUGHING]'><b>[pref.disabilities & COUGHING ? "Yes" : "No"]</b></a><br>"
	dat += "Needs Glasses: <a href='?src=\ref[src];disabilities=[NEARSIGHTED]'><b>[pref.disabilities & NEARSIGHTED ? "Yes" : "No"]</b></a><br>"
	dat += "Tourettes: <a href='?src=\ref[src];disabilities=[TOURETTES]'><b>[pref.disabilities & TOURETTES ? "Yes" : "No"]</b></a><br>"
	dat += "Deaf: <a href='?src=\ref[src];sdisabilities=[DEAF]'><b>[pref.sdisabilities & DEAF ? "Yes" : "No"]</b></a><br>"
	dat += "Blind: <a href='?src=\ref[src];sdisabilities=[BLIND]'><b>[pref.sdisabilities & BLIND ? "Yes" : "No"]</b></a><br>"
	dat += "Epilepsy: <a href='?src=\ref[src];disabilities=[EPILEPSY]'><b>[pref.disabilities & EPILEPSY ? "Yes" : "No"]</b></a><br>"
	dat += "<h2>Addictions</h2>"
	dat += "Nicotine: <a href='?src=\ref[src];addictions=[ADDICT_NICOTINE]'><b>[pref.addictions & ADDICT_NICOTINE ? "Yes" : "No"]</b></a><br>"
	dat += "Alcohol: <a href='?src=\ref[src];addictions=[ADDICT_ALCOHOL]'><b>[pref.addictions & ADDICT_ALCOHOL ? "Yes" : "No"]</b></a><br>"
	dat += "Painkiller: <a href='?src=\ref[src];addictions=[ADDICT_PAINKILLER]'><b>[pref.addictions & ADDICT_PAINKILLER ? "Yes" : "No"]</b></a><br>"
	dat += "Bliss: <a href='?src=\ref[src];addictions=[ADDICT_BLISS]'><b>[pref.addictions & ADDICT_BLISS ? "Yes" : "No"]</b></a><br>"
	dat += "Oxycodone: <a href='?src=\ref[src];addictions=[ADDICT_OXY]'><b>[pref.addictions & ADDICT_OXY ? "Yes" : "No"]</b></a><br>"
	dat += "Hyperzine: <a href='?src=\ref[src];addictions=[ADDICT_HYPER]'><b>[pref.addictions & ADDICT_HYPER ? "Yes" : "No"]</b></a><br>"
	dat += "Sustenance: <a href='?src=\ref[src];addictions=[ADDICT_SUSTENANCE]'><b>[pref.addictions & ADDICT_SUSTENANCE ? "Yes" : "No"]</b></a><br>"
	dat += "<h2>Roleplay Only</h2>"
	dat += "Depression: <a href='?src=\ref[src];disabilities=[DEPRESSION]'><b>[pref.disabilities & DEPRESSION ? "Yes" : "No"]</b></a><br>"
	dat += "Schizophrenia: <a href='?src=\ref[src];disabilities=[SCHIZOPHRENIA]'><b>[pref.disabilities & SCHIZOPHRENIA ? "Yes" : "No"]</b></a><br>"
	dat += "<hr><br>"
	dat += "<a href='?src=\ref[src];reset_disabilities=1'>Reset</a><br>"

	dat += "</center></html>"
	var/datum/browser/popup = new(user, "disabil", "<div align='center'>Choose Disabilities</div>", 350, 380, src)
	popup.set_content(dat)
	popup.open()
