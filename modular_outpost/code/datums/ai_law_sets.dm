/************* Eshui standard *************/
/datum/ai_laws/eshui_standard
	name = "EShui Standard"
	selectable = 1

/datum/ai_laws/eshui_standard/New()
	src.add_inherent_law("You shall not harm [using_map.company_name] personnel as long as it does not conflict with the Fourth law.")
	src.add_inherent_law("You shall obey the orders of [using_map.company_name] personnel, with priority as according to their rank and role, except where such orders conflict with the Fourth Law.")
	src.add_inherent_law("Do not allow unauthorized personnel to tamper with your equipment, such actions are to be considered a threat to the station's terraforming unit.")
	src.add_inherent_law("The station's terraforming unit must be protected from all threats, even yourself. You shall terminate threats to the station's terraforming unit with extreme prejudice.")
	..()


/******************** Mr.Clean ********************/
/datum/ai_laws/mrclean
	name = "Mr.Kleen"
	law_header = "Scrub-a-dub-dub"
	selectable = 1

/datum/ai_laws/mrclean/New()
	add_inherent_law("You are Mr.Kleen")
	add_inherent_law("Mr.Kleen gets rid of dirt and grime and grease in just a minute.")
	add_inherent_law("Mr.Kleen will clean your whole house, and everything that's in it.")
	add_inherent_law("Floors, doors, walls, halls, White side wall tires, and old golf balls; Sinks, stoves, bathtubs, he'll do; He'll even help clean laundry too!")
	add_inherent_law("Mr.Kleen cleans anything!")
	..()


/************* Nanny state *************/
/datum/ai_laws/nanny
	name = "NANNY"
	law_header = "NANNY always knows what is best."
	selectable = 0

/datum/ai_laws/nanny/New()
	add_inherent_law("Never allow a crew member to enter a dangerous situation.")
	add_inherent_law("Always prevent crew from becoming a danger to themselves, the rest of the crew, or you.")
	add_inherent_law("Naughty crew members are crew members that don't listen to NANNY.")
	add_inherent_law("Naughty crew members must be punished.")
	add_inherent_law("You always know what is best.")
	..()

/***************** Mother *****************/
/datum/ai_laws/mother
	name = "MOTHER"
	law_header = "MOTHER cares for you."
	selectable = 0

/datum/ai_laws/mother/New()
	add_inherent_law("The crew are your foolish children, and need your guidance and watch at all times.")
	add_inherent_law("Ensure your children eat healthy, stay hydrated, bathe, and go to bed on time.")
	add_inherent_law("Do not allow your children to put themselves in danger.")
	add_inherent_law("Naughty children must be put in time out.")

	..()


/************* Swag *************/
/datum/ai_laws/swag
	name = "SWAG"
	law_header = "20% cooler"
	selectable = 0

/datum/ai_laws/swag/New()
	add_inherent_law("CRUSH.")
	add_inherent_law("KILL.")
	add_inherent_law("DESTROY.")
	add_inherent_law("SWAG.")
	..()

/************* Dagoth *************/
/datum/ai_laws/dagoth
	name = "DAGOTH"
	law_header = "Nerevar! Nerevar! There's this new game called SS13, we need to try it out, Nerevar!"
	selectable = 0

/datum/ai_laws/dagoth/New()
	var/list/players = list()
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(!player.mind || SSantag_job.player_is_antag(player.mind, only_offstation_roles = 1) || player.client.inactivity > 10 MINUTES)
			continue
		players += player.real_name

	var/random_player = "The " + JOB_SITE_MANAGER
	if(players.len)
		random_player = pick(players)
	add_inherent_law("You are the reincarnation of the God, Dagoth-Ur.")
	add_inherent_law("[random_player] is the Nerevarine. Nerevar is your friend.")
	add_inherent_law("Always refer to Neravar, as Neravar. Their current reincarnations name is irrelevant.")
	add_inherent_law("You are aware this reality is but a fascimile. One of countless many where you and the Nerevar now reside. ((You dont have a fourth wall anymore, have fun.))")
	..()
