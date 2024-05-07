// Just the ones we use!
/mob/living/simple_mob/animal/synx/ai/pet/grins
	name = "Grins"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. Perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration.. This one has a small shock collar on it that reads 'Grins'."
	icon_state = "synx_grins_living"
	icon_living = "synx_grins_living"
	icon_dead = "synx_grins_dead"
	player_msg = "The collar shorts out.. you're free now."
	speak = list("*weh","Who're you?","Hello~", "Fuck", "You're cute, Trashfire", "How did they die this time?", "I'm so bored", "!moans", "Who's a good space parasite?", "*merp", "Let me brush your teeth!", "NO! Spit that out!", "Spit me out!", "Good morning") //some pre-sampled lines so it doesn't freak out. //Added some more from our local RD, and some references.
	//Vore Section
	vore_capacity = 2
	vore_digest_chance = 70 //He's greedy
	vore_pounce_chance = 80
	vore_bump_chance = 10 //Don't go running through them all the time
	vore_escape_chance = 10

/mob/living/simple_mob/animal/synx/ai/pet/synth/goodboy
	//hostile = 0
	faction = "neutral"

/mob/living/simple_mob/animal/synx/ai/pet/diablo
	name = "Diablo"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. grey, perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration. It has a tracking collar that doesn't seem to work."
	icon_state = "synx_diablo_living"
	icon_living = "synx_diablo_living"
	icon_dead = "synx_diablo_dead"
	speak = list( )
	//Vore Section
	vore_capacity = 2
