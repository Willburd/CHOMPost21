// Just the ones we use!
/mob/living/simple_mob/animal/synx/ai/pet/grins
	name = "Grins"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. Perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration.. This one has a small shock collar on it that reads 'Grins'."
	player_msg = "The collar shorts out.. you're free now."
	speak = list("*weh","Who're you?","Hello~", "Fuck", "You're cute, Trashfire", "How did they die this time?", "I'm so bored", "!moans", "Who's a good space parasite?", "*merp", "Let me brush your teeth!", "NO! Spit that out!", "Spit me out!", "Good morning", "Dah", "Pinche coyo", "Ne", "OFFICER NEEDING HELP", "Sup") //some pre-sampled lines so it doesn't freak out. //Added some more from our local RD, and some references.
	//Vore Section
	vore_capacity = 2
	vore_digest_chance = 70 //He's greedy
	vore_pounce_chance = 80
	vore_bump_chance = 50 //Don't go running through them all the time //Upped from 10 to 50, because people keep feeding him, so he's getting bold~
	vore_escape_chance = 10

/mob/living/simple_mob/animal/synx/ai/pet/grins/Initialize()
	//Configure speaker list for their name
	voices = list(name)
	//Configure design
	randomized_design = FALSE
	body = "Normal"
	overlay_colors["Body"] = "#FFFFFF"
	horns = "Wide"
	overlay_colors["Horns"] = "#2F2F2F"
	markings = "Short"
	overlay_colors["Marks"] = "#2F2F2F"
	eyes = "Normal"
	overlay_colors["Eyes"] = "#FF0000"
	has_collar = TRUE
	. = ..()

/mob/living/simple_mob/animal/synx/ai/pet/synth/goodboy
	//hostile = 0
	faction = "neutral"

/mob/living/simple_mob/animal/synx/ai/pet/diablo
	name = "Diablo"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. grey, perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration. It has a tracking collar that doesn't seem to work."
	speak = list( )
	//Vore Section
	vore_capacity = 2

/mob/living/simple_mob/animal/synx/ai/pet/diablo/Initialize()
	//Configure design
	randomized_design = FALSE
	body = "Normal"
	overlay_colors["Body"] = "#636363"
	horns = "Straight"
	overlay_colors["Horns"] = "#2F2F2F"
	markings = "Short"
	overlay_colors["Marks"] = "#c0c0c0"
	eyes = "Normal"
	overlay_colors["Eyes"] = "#FF0000"
	. = ..()
