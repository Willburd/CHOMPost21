/proc/censor_swears(t)
	/* Bleeps our swearing */
	var/static/swear_censoring_list = list("fuck",
										"shit",
										"damn",
										"piss",
										"whore",
										"cunt",
										"bitch",
										"bastard",
										"dick",
										"cock",
										"slut",
										"dong",
										"pussy",
										"twat",
										"snatch",
										"schlong",
										"damn",
										"dammit",
										"damnit",
										"ass",
										"tit",
										"douch",
										"prick",
										"hell",
										"crap")
	var/haystack = t
	for(var/filter in swear_censoring_list)
		var/regex/needle = regex(filter, "i")
		while(TRUE)
			var/pos = needle.Find(haystack)
			if(!pos)
				break
			var/partial_start = copytext(haystack,1,pos)
			var/partial_end   = copytext(haystack,pos+length(filter),length(haystack)+1)
			haystack = "[partial_start][pick("BEEP","BLEEP","BOINK","BEEEEEP")][partial_end]"
	return haystack
