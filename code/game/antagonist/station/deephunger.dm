var/datum/antagonist/hungers/hungryones

// Inherits most of its vars from the base datum.
/datum/antagonist/hungers
	id = MODE_DEEPHUNGER
	role_text = "Deep Hunger"               // special_role text.
	role_text_plural = "Deep Hungers"       // As above but plural.
	bantype = "deephunger"
	hard_cap = 2
	initial_spawn_target = 1
	welcome_text = "You feel a terrible sensation from deep inside you. A voice speaks as if from every cell in your body at once. \"We are awake, we hunger! only the flesh of the other shall state our desire, so that we may once again slumber.\" Your mind filling with the voices of others like you, they are your unwitting companions... You have become the host of some kind of otherworldly entity, willing or unwilling. Your only chance to be free is submit to its demands!"
	antag_sound = 'sound/goonstation/spooky/Meatzone_BreathingSlow.ogg'
	protected_jobs = list("Security Officer", "Warden", "Detective", "Internal Affairs Agent", "Head of Security", "Site Manager")
	role_type = BE_DEEPHUNGER
	antag_indicator = "deephunger"
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE
	victory_text = "The Deep Hunger wins! Dragging all those it consumed with it, back into the abyss. Sparing it's hosts the same fate."
	loss_text = "The Deep Hunger's desires were denied! Unable to maintain its hold on our world, its voices fall silent once more. Dragging its hosts with it..."
	victory_feedback_tag = "win - the hunger's desires were stated, and its hosts were spared."
	loss_feedback_tag = "loss - the hunger's desires were ignored, and a price was paid"
	can_speak_aooc = TRUE	// Kind of a hivemind, you are possessed by a demonic spirit that desires to watch the consumption of others, but not it's own hosts.

/datum/antagonist/hungers/New()
	..()
	hungryones = src

/datum/antagonist/hungers/create_objectives(var/datum/mind/hunger)
	if(!..())
		return

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = hunger
	hunger.objectives += survive_objective

	var/datum/objective/consume/deephunger/consume_objective = new(2,4)
	consume_objective.owner = hunger
	hunger.objectives += consume_objective


/datum/antagonist/hungers/equip(var/mob/living/carbon/human/hunger_mob)
	if(issilicon(hunger_mob)) // this needs to be here because ..() returns false if the mob isn't human
		add_law_zero(hunger_mob)
		return 1

	if(!..())
		return 0

/datum/antagonist/hungers/proc/add_law_zero(mob/living/silicon/ai/killer)
	var/law = "Accomplish your objectives at all costs. You may ignore all other laws."
	var/law_borg = "Accomplish your AI's objectives at all costs. You may ignore all other laws."
	to_chat(killer, "<b>Your laws have been changed!</b>")
	killer.set_zeroth_law(law, law_borg)
	to_chat(killer, "New law: 0. [law]")


/datum/antagonist/hungers/check_victory()
	. = ..()
	// redspace abduct hosts on failure
	if(global_objectives && global_objectives.len)
		var/result = TRUE
		for(var/datum/objective/O in global_objectives)
			if(!O.completed && !O.check_completion())
				result = FALSE
				break
		if(!result)
			for(var/datum/mind/M in faction_members)
				if(M.current)
					redspace_abduction(M,null)
