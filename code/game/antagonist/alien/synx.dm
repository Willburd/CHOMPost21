var/datum/antagonist/synx/synxes

// Inherits most of its vars from the base datum.
/datum/antagonist/synx
	id = MODE_SYNX
	role_text = "Synx"               // special_role text.
	role_text_plural = "Synx"       // As above but plural.
	bantype = "synxhunt"
	hard_cap = 2
	mob_path = /mob/living/simple_mob/animal/synx
	initial_spawn_target = 1
	welcome_text = "You awaken once again to the hunt. Stalk the crew, and strike when they least expect it... You are an ambush predator after all."
	antag_sound = 'sound/rakshasa/Breath1.ogg'
	role_type = BE_ALIEN
	antag_indicator = "synxhunt"
	flags = ANTAG_OVERRIDE_MOB | ANTAG_RANDSPAWN | ANTAG_OVERRIDE_JOB | ANTAG_VOTABLE | ANTAG_CHOOSE_NAME
	victory_text = "Synx win - more later"
	loss_text = "Synx lost - more later!"
	victory_feedback_tag = "win - synx win"
	loss_feedback_tag = "loss - staff killed or captured the synx"
	can_speak_aooc = FALSE	// Silly IC fun if you somehow manage to convince someone to help you...... somehow....

/datum/antagonist/synx/New()
	..()
	synxes = src

/datum/antagonist/synx/create_objectives(var/datum/mind/synx)
	if(!..())
		return

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = synx
	synx.objectives += survive_objective

	var/datum/objective/consume/hunter/consume_objective = new(3,6)
	consume_objective.owner = synx
	synx.objectives += consume_objective


/datum/antagonist/synx/equip(var/mob/living/carbon/human/synx_mob)
	if(!..())
		return 0
	// what would a synx even get?
