/datum/trait/negative
	category = TRAIT_TYPE_NEGATIVE

/* Was disabled in setupgame.dm, likely nonfunctional
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
	name = "Epilepsy"
	desc = "You experience periodic seizures."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=EPILEPSY
	activation_message="You get a headache."

/datum/trait/negative/disability_cough
	name = "Coughing Fits"
	desc = "You can't stop yourself from coughing."
	cost = -1
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=COUGHING
	activation_message="You start coughing."

/datum/trait/negative/disability_clumsy
	name = "Clumsy"
	desc = "You often make silly mistakes, or drop things."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=CLUMSY
	activation_message="You feel lightheaded."

/datum/trait/negative/disability_tourettes
	name = "Tourettes Syndrome"
	desc = "You have periodic motor seizures, and cannot stop yourself from yelling profanity."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=TOURETTES
	activation_message="You twitch."

/datum/trait/negative/disability_anxiety
	name = "Anxiety Disorder"
	desc = "You have extreme anxiety, often stuttering words."
	cost = -1
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=NERVOUS
	activation_message="You feel nervous."

/datum/trait/negative/disability_blind
	name = "Blinded"
	desc = "You are unable to see anything."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	sdisability=BLIND
	activation_message="You can't seem to see anything."

/datum/trait/negative/disability_mute
	name = "Mute"
	desc = "You are unable to speak."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	sdisability=MUTE
	activation_message="Your throat feels strange..."

/datum/trait/negative/disability_deaf
	name = "Deaf"
	desc = "You are unable to hear anything."
	cost = -3
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	sdisability=DEAF
	activation_message="It's kinda quiet."

/datum/trait/negative/disability_deaf/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	. = ..()
	H.ear_deaf = 1
	H.deaf_loop.start(skip_start_sound = TRUE) // CHOMPStation Add: Ear Ringing/Deafness

/datum/trait/negative/disability_deaf/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	H.ear_deaf = 0
	H.deaf_loop.stop()

/datum/trait/negative/disability_nearsighted
	name = "Nearsighted"
	desc = "You have difficulty seeing things far away."
	cost = -2
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = FALSE

	disability=NEARSIGHTED
	activation_message="Your eyes feel weird..."
