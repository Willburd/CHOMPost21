/datum/atc_chatter/outpost_artillery
	var/ignored = FALSE

/datum/atc_chatter/outpost_artillery/squak()
	//Control scan event: soft outcome
	switch(phase)
		if(1)
			SSatc.msg("This is [using_map.starsys_name] Defense Control, [combined_first_name], your [pick("ship","vessel","starship")] is entering secure airspace without authorization. Turn back or you will be [prob(20) ? "fired upon" : "destroyed"].", "[using_map.starsys_name] Defense Control")
			next()
		if(2)
			if(prob(20))
				ignored = TRUE
			else
				var/confirm = pick("Understood","Roger that","Affirmative","Very well","Copy that")
				SSatc.msg("[confirm] [using_map.starsys_name] Defense Control, requesting safe vector to leave secure airspace.","[comm_first_name]")
			next()
		if(3)
			if(!ignored)
				SSatc.msg("Your compliance is appreciated, [combined_first_name]. Transmitting vector, please await escort arrival.")
				finish()
				return
			else
				next()
		if(4)
			SSatc.msg("[combined_first_name], you have not responded and are continuing into secure airspace, final warning. Turn back or you will be [prob(20) ? "fired upon" : "destroyed"].", "[using_map.starsys_name] Defense Control")
			next()
		if(5)
			SSatc.msg("[pick(30) ? "Ground" : "Orbital"] artillery, fire at will on [callname].", "[using_map.starsys_name] Defense Control")
			finish()
