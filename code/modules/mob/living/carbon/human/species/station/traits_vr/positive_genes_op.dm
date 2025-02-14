/datum/trait/positive/superpower_superfart
	name = "Super Fart"
	desc = "Sin beyond mortal comprehension, this could only be the geneticist's fault."
	cost = 6
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARD_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	activation_message="You feel incredible pressure inside of you."
	deactivation_message="The pressure inside of you vanishes."
	primitive_expression_messages=list("toots.")

/datum/trait/positive/superpower_superfart/apply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	add_verb(H, /mob/living/proc/super_fart)

/datum/trait/positive/superpower_superfart/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	if(!(/mob/living/proc/super_fart in S.inherent_verbs))
		remove_verb(H, /mob/living/proc/super_fart)
