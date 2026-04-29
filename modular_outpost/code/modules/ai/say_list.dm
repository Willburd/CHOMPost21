//Outpost overrides for various say lists, cuz some of them SUCK


/datum/say_list/merc
	speak = list("Come on, gimme something to shoot.",
				"Oh to see the looks on their faces.",
				"Okay, this time with feeling.",
				"Fuckin' helmet keeps fogging up.",
				"What even IS this weather?!",
				"Anyone else smell that?")
	emote_see = list("sniffs", "coughs", "taps their foot", "looks around", "checks their equipment","does a functions check on their weapon")

	say_understood = list("Understood!", "Affirmative!")
	say_cannot = list("Negative!")
	say_maybe_target = list("Who's there?", "Peekaboo~")
	say_got_target = list("Engaging!", "Target sighted!", "GET SOME!")
	say_threaten = list("Run! I dare ya!", "Lookie we got here~")
	say_stand_down = list("Good.","Count one more for me.", "That's right you mothers, RUN!")
	say_escalate = list("Your funeral!", "Bring it!")

	threaten_sound = 'sound/weapons/targeton.ogg'
	stand_down_sound = 'sound/weapons/targetoff.ogg'
