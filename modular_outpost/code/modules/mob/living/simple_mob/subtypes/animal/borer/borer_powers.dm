/mob/living/simple_mob/animal/borer/verb/taste_chemicals()
	set category = "Abilities.Borer"
	set name = "Taste Blood"
	set desc = "Tastes the chemicals in your host's bloodstream."

	if(!host)
		to_chat(src, "<span class='notice'>You are not inside a host body.</span>")
		return

	if(stat)
		to_chat(src, "<span class='notice'>You cannot taste your host's blood while in your current state.</span>")
		return

	if(docile)
		to_chat(src, "<font color='blue'>All you can sense is the overwhelming taste of sugar.</font>")
		return

	var/list/bigtaste = list()
	var/list/smalltaste = list()

	for(var/datum/reagent/current in host.bloodstr.reagent_list)
		if(current.volume > 3)
			bigtaste.Add(current.name)
		else
			smalltaste.Add(current.name)

	var/tastemessage = ""
	if(bigtaste.len > 0)
		tastemessage = "You can taste the flavor of "
		if(bigtaste.len > 1)
			while(bigtaste.len > 0)
				// multiple
				var/taste = bigtaste[1]
				if(bigtaste.len > 1)
					tastemessage += taste + ", "
				else
					tastemessage += " and " + taste + ". "
					break
				bigtaste -= taste
		else
			// single
			tastemessage += bigtaste[1] + ". "

	if(smalltaste.len > 0)
		if(tastemessage == "")
			tastemessage += "You taste a hint of "
		else
			tastemessage += "With a hint of "
		if(smalltaste.len > 1)
			// multiple
			while(smalltaste.len > 0)
				var/taste = smalltaste[1]
				if(smalltaste.len > 1)
					tastemessage += taste + ", "
				else
					tastemessage += " and " + taste + ". "
					break
				smalltaste -= taste
		else
			// single
			tastemessage += smalltaste[1] + ". "

	if(bigtaste.len == 0 && smalltaste.len == 0)
		tastemessage = "You taste nothing in particular."
	to_chat(src, "<span class='notice'>[tastemessage]</span>")
