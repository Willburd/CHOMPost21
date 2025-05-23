var/datum/antagonist/cultist/cult

/proc/iscultist(var/mob/player)
	if(!cult || !player.mind)
		return 0
	if(player.mind in cult.current_antagonists)
		return 1

/datum/antagonist/cultist
	id = MODE_CULTIST
	role_text = "Cultist"
	role_text_plural = "Cultists"
	bantype = "cultist"
	restricted_jobs = list(JOB_CHAPLAIN)
	avoid_silicons = TRUE
	protected_jobs = list(JOB_SECURITY_OFFICER, JOB_WARDEN, /*JOB_DETECTIVE,*/ JOB_INTERNAL_AFFAIRS_AGENT, JOB_HEAD_OF_SECURITY, JOB_SITE_MANAGER) // Outpost 21 edit - Detective is officer now
	roundstart_restricted = list(JOB_INTERNAL_AFFAIRS_AGENT, JOB_HEAD_OF_SECURITY, JOB_SITE_MANAGER)
	role_type = BE_CULTIST
	feedback_tag = "cult_objective"
	antag_indicator = "cult"
	welcome_text = "You have a talisman in your possession; one that will help you start the cult on this station. Use it well and remember - there are others."
	antag_sound = 'sound/effects/antag_notice/cult_alert.ogg'
	victory_text = "The cult wins! It has succeeded in serving its dark masters!"
	loss_text = "The staff managed to stop the cult!"
	victory_feedback_tag = "win - cult win"
	loss_feedback_tag = "loss - staff stopped the cult"
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	hard_cap = 5
	hard_cap_round = 6
	initial_spawn_req = 4
	initial_spawn_target = 6
	antaghud_indicator = "hudcultist"

	var/allow_narsie = 1
	var/datum/mind/sacrifice_target
	var/list/startwords = list("blood","join","self","hell")
	var/list/allwords = list("travel","self","see","hell","blood","join","tech","destroy", "other", "hide")
	var/list/sacrificed = list()
	var/list/harvested = list()

/datum/antagonist/cultist/New()
	..()
	cult = src

/datum/antagonist/cultist/create_global_objectives()

	if(!..())
		return

	global_objectives = list()
	if(prob(50))
		global_objectives |= new /datum/objective/cult/survive
	else
		global_objectives |= new /datum/objective/cult/eldergod

	var/datum/objective/cult/sacrifice/sacrifice = new()
	sacrifice.find_target()
	sacrifice_target = sacrifice.target
	global_objectives |= sacrifice

/datum/antagonist/cultist/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	var/obj/item/paper/talisman/supply/T = new(get_turf(player))
	var/list/slots = list (
		"backpack" = slot_in_backpack,
		"left pocket" = slot_l_store,
		"right pocket" = slot_r_store,
		"left hand" = slot_l_hand,
		"right hand" = slot_r_hand,
	)
	for(var/slot in slots)
		player.equip_to_slot(T, slot)
		if(T.loc == player)
			break
	var/obj/item/storage/S = locate() in player.contents
	if(S && istype(S))
		T.loc = S

/datum/antagonist/cultist/greet(var/datum/mind/player)
	if(!..())
		return 0
	grant_runeword(player.current)

/datum/antagonist/cultist/proc/grant_runeword(mob/living/carbon/human/cult_mob, var/word)

	if (!word)
		if(startwords.len > 0)
			word=pick(startwords)
			startwords -= word
		else
			word = pick(allwords)

	// Ensure runes are randomized.
	if(!GLOB.cultwords["travel"])
		runerandom()

	var/wordexp = "[GLOB.cultwords[word]] is [word]..."
	to_chat(cult_mob, span_warning("You remember one thing from the dark teachings of your master... [wordexp]"))
	cult_mob.mind.store_memory("You remember that <B>[wordexp]</B>", 0, 0)

/datum/antagonist/cultist/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	if(!..())
		return 0
	to_chat(player.current, span_danger("An unfamiliar white light flashes through your mind, cleansing the taint of the dark-one and the memories of your time as his servant with it."))
	player.memory = ""
	if(show_message)
		player.current.visible_message(span_large("[player.current] looks like they just reverted to their old faith!"))

/datum/antagonist/cultist/add_antagonist(var/datum/mind/player)
	. = ..()
	if(.)
		to_chat(player, "You catch a glimpse of the Realm of Nar-Sie, the Geometer of Blood. You now see how flimsy the world is, you see that it should be open to the knowledge of That Which Waits. Assist your new compatriots in their dark dealings. Their goals are yours, and yours are theirs. You serve the Dark One above all else. Bring It back.")
		if(player.current && !istype(player.current, /mob/living/simple_mob/construct))
			player.current.add_language(LANGUAGE_CULT)

/datum/antagonist/cultist/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	. = ..()
	if(. && player.current && !istype(player.current, /mob/living/simple_mob/construct))
		player.current.remove_language(LANGUAGE_CULT)

/datum/antagonist/cultist/can_become_antag(var/datum/mind/player)
	if(!..())
		return 0
	for(var/obj/item/implant/loyalty/L in player.current)
		if(L && (L.imp_in == player.current))
			return 0
	return 1
