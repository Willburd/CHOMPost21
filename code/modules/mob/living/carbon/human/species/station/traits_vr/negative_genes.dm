/datum/trait/negative
	category = TRAIT_TYPE_NEGATIVE

/* // Has not effects ingame
/datum/trait/negative/disability_hallucinations
	name = "Disability: Hallucinations"
	desc = "..."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	mutation = mHallucination
	activation_message="Your mind says 'Hello'."
*/

/datum/trait/negative/disability_epilepsy
	name = "Disability: Epilepsy"
	desc = "You experience periodic seizures."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=EPILEPSY
	activation_message="You get a headache."

/datum/trait/negative/disability_cough
	name = "Disability: Cough"
	desc = "You can't stop yourself from coughing."
	cost = -1
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=COUGHING
	activation_message="You start coughing."

/datum/trait/negative/disability_clumsy
	name = "Disability: Clumsiness"
	desc = "You often make silly mistakes, or drop things."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=CLUMSY
	activation_message="You feel lightheaded."

/datum/trait/negative/disability_tourettes
	name = "Disability: Tourettes"
	desc = "You have periodic motor seizures, and cannot stop yourself from yelling profanity."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=TOURETTES
	activation_message="You twitch."

/datum/trait/negative/disability_tourettes
	name = "Disability: Nervousness"
	desc = "You have extreme anxiety, often stuttering words."
	cost = -1
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=NERVOUS
	activation_message="You feel nervous."

/datum/trait/negative/disability_tourettes
	name = "Disability: Blindness"
	desc = "You are unable to see anything."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=BLIND
	activation_message="You can't seem to see anything."

/datum/trait/negative/disability_deaf
	name = "Disability: Deafness"
	desc = "You are unable to hear anything."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=DEAF
	activation_message="It's kinda quiet."

/datum/trait/negative/disability_deaf/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	. = ..()
	H.ear_deaf = 1
	H.deaf_loop.start(skip_start_sound = TRUE) // CHOMPStation Add: Ear Ringing/Deafness

/datum/trait/negative/disability_nearsighted
	name = "Disability: Nearsightedness"
	desc = "You are unable to hear anything."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=NEARSIGHTED
	activation_message="Your eyes feel weird..."
