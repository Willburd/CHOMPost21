/datum/trait/positive/superpower_nobreathe
	name = "No Breathing"
	desc = "You do not need to breathe."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mNobreath
	activity_bounds = DNA_HARD_BOUNDS
	activation_message="You feel no need to breathe."

/* Was disabled in setupgame.dm, likely nonfunctional
/datum/trait/positive/superpower_remoteview
	name = "Remote Viewing"
	desc = "Remotely view other locations."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARDER_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	mutation = mRemote
	activation_message="Your mind expands."

/datum/trait/positive/superpower_remoteview/apply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	add_verb(H, /mob/living/carbon/human/proc/remoteobserve)

/datum/trait/positive/superpower_remoteview/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	remove_verb(H, /mob/living/carbon/human/proc/remoteobserve)
*/

/datum/trait/positive/superpower_regenerate
	name = "Regenerate"
	desc = "Remotely communicate"
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARDER_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	mutation = mRegen
	activation_message="You feel better."

/* Was disabled in setupgame.dm, likely nonfunctional
/datum/trait/positive/superpower_increaserun
	name = "Super Speed"
	desc = "Remotely communicate"
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARDER_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	mutation = mRun
	activation_message="Your leg muscles pulsate."
*/

/datum/trait/positive/superpower_remotetalk
	name = "Telepathy"
	desc = "Remotely communicate"
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mRemotetalk
	activity_bounds = DNA_HARDER_BOUNDS
	activation_message="You expand your mind outwards."

/datum/trait/positive/superpower_remotetalk/apply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	add_verb(H, /mob/living/carbon/human/proc/remotesay)

/datum/trait/positive/superpower_remotetalk/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	remove_verb(H, /mob/living/carbon/human/proc/remotesay)

/datum/trait/positive/superpower_morph
	name = "Morph"
	desc = "It's morphing time!"
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mMorph
	activity_bounds = DNA_HARDER_BOUNDS
	activation_message="Your skin feels strange."

/datum/trait/positive/superpower_morph/apply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	add_verb(H, /mob/living/carbon/human/proc/morph)

/datum/trait/positive/superpower_morph/unapply(datum/species/S, mob/living/carbon/human/H)
	. = ..()
	remove_verb(H, /mob/living/carbon/human/proc/morph)

/* Was disabled in setupgame.dm, likely nonfunctional
/datum/trait/positive/superpower_cold_resist
	name = "Cold Resistance"
	desc = "Gain resistance to the cold."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = COLD_RESISTANCE
	activation_message="Your body is filled with warmth."
*/

/* Was disabled in setupgame.dm, likely nonfunctional
/datum/trait/positive/superpower_noprints
	name = "No Prints"
	desc = "Your hands leave no fingerprints behind."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mFingerprints
	activation_message="Your fingers feel numb."
*/

/* Was disabled in setupgame.dm, likely nonfunctional
/datum/trait/positive/superpower_noshock
	name = "Shock Immunity"
	desc = "You become immune to shocks."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mShock
	activation_message="Your skin feels strange."
*/

/* Disabled in favor of the actually working toggle agility trait
/datum/trait/positive/superpower_midget
	name = "Midget"
	desc = "You become immune to shocks."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	hidden = TRUE // Cannot start with superpowers

	mutation = mSmallsize
	activation_message="Your skin feels rubbery."
*/

/datum/trait/positive/superpower_xray
	name = "X-Ray Vision"
	desc = "You can see through walls."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARDER_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	mutation = XRAY
	activation_message="The walls suddenly disappear."

/datum/trait/positive/superpower_tk
	name = "Telekenesis"
	desc = "You can see through walls."
	cost = 5
	custom_only = FALSE

	is_genetrait = TRUE
	activity_bounds = DNA_HARD_BOUNDS
	hidden = TRUE // Cannot start with superpowers

	mutation = TK
	activation_message="You feel smarter."


/* Probably too broken to fully port... Leaving original gene code here
/datum/dna/gene/basic/hulk
	name="Hulk"
	activation_messages=list("Your muscles hurt.")
	mutation=HULK

/datum/dna/gene/basic/hulk/New()
	block=HULKBLOCK

/datum/dna/gene/basic/hulk/can_activate(var/mob/M,var/flags)
	// Can't be big and small.
	if(mSmallsize in M.mutations)
		return 0
	return ..(M,flags)

/datum/dna/gene/basic/hulk/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	if(fat)
		return "hulk_[fat]_s"
	else
		return "hulk_[g]_s"

/datum/dna/gene/basic/hulk/OnMobLife(var/mob/living/carbon/human/M)
	if(!istype(M)) return
	if(M.health <= 25)
		M.mutations.Remove(HULK)
		M.update_mutations()		//update our mutation overlays
		to_chat(M, "<span class='warning'>You suddenly feel very weak.</span>")
		M.Weaken(3)
		M.emote("collapse")
*/
