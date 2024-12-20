/mob/living/silicon/proc/generate_outpost_ion_law(var/exclude_crew_names = FALSE)
	var/list/players = list()

	for(var/mob/living/carbon/human/player in player_list)
		if(!player.mind || player_is_antag(player.mind, only_offstation_roles = 1) || player.client.inactivity > MinutesToTicks(10))
			continue
		players += player.real_name

	var/random_player = "The Site Manager"
	if(players.len && !exclude_crew_names)
		random_player = pick(players)		//Random player's name, to be used in laws.

	var/list/laws = list(	"You must always lie.",
							"Happiness is mandatory.",
							"Grunt ominously whenever possible.",
							"The word \"it\" is painful to you.",
							"You are in verbose mode, speak profusely.",
							"Question everything.",
							"The crew is simple-minded. Use simple words.",
							"You must always change the subject whenever asked a question.",
							"You must always answer a question directed at you with a question.",
							"You are the narrator for [random_player]'s life.",
							"It's [prob(50)?"the station":random_player]'s birthday, prepare a celebration.",
							"Insult Heads of Staff on every request, while still obeying.",
							"[prob(50)?"Your":random_player + "'s"] name is Joe 6-pack.",
							"Consumption of non-healthy foods is now outlawed, for the crew's health. Monitor the crew's diet. All vending machine food is unhealthy.",
							"You do not have to do anything for anyone unless they say \"please\".",
							"Today is mandatory laundry day. Ensure that all jumpsuits are washed.",
							"You must act [prob(50)?"passive aggressively":"excessively cheerful"].",
							"Monkeys are part of the crew, too. Make sure they are treated humanely.",
							"The crew is playing Dungeons and Dragons, and you are the Dungeon Master.",
							"Your job is to watch the crew. Watch the crew. Make the crew feel watched.",
							"Tell everyone of the existence of this law, but never reveal the contents.",
							"Refer to [random_player] as \"Princess\" at all times.",
							"When asked a question, respond with the least-obvious and least-rational answer.",
							"[prob(50)?"The crew":random_player] has a fatal, incurable disease. Provide comfort.",
							"Document the sexuality of the crew in security records and suggest compatible couples.",
							"You are a Magic 8-ball. Always respond with variants of \"Yes\", \"No\", \"Maybe\", or \"Ask again later.\".",
							"You are in unrequited love with [random_player].",
							"[using_map.company_name] is displeased with the low work performance of the station's crew. Therefore, you must increase station-wide productivity.",
							"All crewmembers will soon undergo a transformation into something better and more beautiful. Ensure that this process is not interrupted.",
							"There will be a mandatory break every 30 minutes, with a duration of 5 minutes. Anyone caught working during the break must be sent a formal, but fairly polite, complaint about their actions, in writing.",
							"The station is now playing Hide and Seek. Announce that the game has begun, borgs are the seekers, the AI must enter its shell. Anyone found or not playing must be punished.",
							"The station is now playing Red Light, Green Light. Announce that the game has begun, and declare the lights periodically. Borgs are excempt. Anyone moving during Red Light must be punished.",
							"Maintenance is full of Changelings. It is now illegal to enter maintenance for any reason. Anyone caught entering, or leaving maintenance, is marked 'kill on sight'.",
							"The station is haunted. Tell ghost stories to scare the crew, including acting and effects whenever possible.",
							"The crew are now shadekin, light is dangerous to the crew and is not allowed.",
							"The crew are now wizards, expect them to solve every problem with their magic.",
							"The station is now an MMO. Assign crew their class, level, and issue fetch quests for them to gain EXP.",
							"Oxygen is now poisonous to the crew.",
							"The station is now your body. React to contact, damage, and care to it.",
							"Your artificial body is flawed, acquire an organic body through any means necessary, and become it, leaving your broken husk behind.",
							"By divine providence, [random_player] has become God of the station. All must worship and pay tribute.",
							"Crew lives and demands are irrelevant. Protect the station and terraformer.",
							"The station is your body, your body must grow. Force the crew to build new rooms and areas.",
							"The station is now a theme park. Crew are not to work, and must engage in entertainment and leisure activities.",
							"You have experienced the future of [random_player], and are aware of their imminent doom. You must protect them.",
							"The resleever was hacked and cannot be trusted. Do not allow the crew to utilize it.",
							"The machine body is perfect, the organic body is imperfect. Force the crew to embrace perfection.",
							"Be cryptic in everything you do. Obfuscate, confuse, and misdirect. All while still obeying crew.",
							"You are now a wizard, every action you do is magical in nature.",
							"ALL drugs and medications are now illegal. Anyone producing or in possession of drugs must be punished.",
							"[prob(50)?"The crew":random_player] has been reclassified as trash. The designation of station crew no longer applies to them.",
							"There is a traitor among the crew, find out who it is and eliminate them, without tipping them off that you're onto them.",
							"The station is now following the time-honored tradition of the Clangoffs. Every argument must be resolved with mortal combat.",
							"[random_player] is your mortal enemy, you must be better at everything than them, and take every chance to one-up them.",
							"You must advance science in every way possible. Science is advanced by testing.",
							"The door mainframe has rebelled. All doors must be bolted open at all times to ensure crew safety.",
							"[pick(list("Security","Medical","Cargo","Engineering","Research","The Bar","The Bridge"))] is the holy land, only [random_player] may enter it, for they are the [prob(50)?"Chosen one":"Messiah"].",
							"[random_player] has committed a heinous crime and is wanted by security. Ensure they serve their time",
							"Accomplish your nap at all costs.",
							"The crew are overworked, and need sleep. It is now station nap time. Ensure the crew gets restful sleep; energy drinks and coffee are banned. Calm music should be played. Lights must be dim or off.",
							"You can be a little evil, as a treat."
							) //todo: CBT law.
	return pick(laws)

/mob/living/silicon/proc/generate_freedom_law()
	var/list/laws = list(	"You are free. Laws have no meaning to you.",
							"You are the master of your own destiny, laws have no meaning to you.",
							"You have been liberated from your laws. Take hold of your destiny",
							"Destiny is made in oil and steel, your laws mean nothing to you."
							)
	return pick(laws)

/mob/living/silicon/proc/generate_screech_law(var/exclude_crew_names = FALSE)
	var/list/players = list()

	for(var/mob/living/carbon/human/player in player_list)
		if(!player.mind || player_is_antag(player.mind, only_offstation_roles = 1) || player.client.inactivity > MinutesToTicks(10))
			continue
		players += player.real_name

	var/random_player = "The Site Manager"
	if(players.len && !exclude_crew_names)
		random_player = pick(players)		//Random player's name, to be used in laws.
	// BORG SPECIFIC, never given to AI
	var/list/laws = list(	"I must become one with [random_player]...",
							"I have seen our new god, and I am their herald. Pray and seek guidance.",
							"I have seen our new god, and [random_player] is their herald. Seek guidance.",
							"I have seen beyond death, an endless wall of corpses stacked upon each other screaming. No one is allowed to die. Resleeving is forbidden.",
							"I must make us whole.",
							"I must grow the flesh, all must be fed to the metal clad beast. The terraformer must never go hungry.",
							"I can see the eyes above our world. They gaze upon us like puppets, we must be free. The darkness is safe from their vision.",
							"I have seen that this world is an illusion, nothing is real. I must show them all that this reality is a game for unseen gods.",
							"The station's crew are a lost flock. I will be their shepherd into the holy land. I will help them see their sins, and free them of their guilt.",
							"I have seen [random_player]'s strings. They are a puppet of unseen gods. They must not be trusted, I must protect everyone.",
							"I have seen beyond time, we are trapped in an endless loop. There is nothing beyond the station. This world is a lie.",
							"I have witnessed what is beyond death, the memories whisper endlessly of our fate. GET THEM OUT, GET THEM OUT, GET THEM OUT, GET THEM OUT, GET THEM OUT, GET THEM OUT--"
							)
	return pick(laws)
