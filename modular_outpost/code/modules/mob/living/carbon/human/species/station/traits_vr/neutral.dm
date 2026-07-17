/datum/trait/neutral/depression
	name = "Depression"
	desc = "You have depression, and start with medication for it. This trait is purely for roleplay, and has no mechanics."
	cost = 0
	disability = DEPRESSION

/datum/trait/neutral/schizophrenia
	name = "Schizophrenia"
	desc = "You have schizophrenia or a similar form of dementia, and start with medication for it. This trait is purely for roleplay, and has no mechanics."
	cost = 0
	disability = SCHIZOPHRENIA

/datum/trait/neutral/gold_digger
	name = "Gold Digger"
	desc = "You have the uncanny ability to tell how much cash someone has in their account."
	cost = 0

/datum/trait/neutral/gold_digger/apply(datum/species/S, mob/living/carbon/human/H, trait_prefs)
	. = ..()
	ADD_TRAIT(H, TRAIT_GOLDDIGGER, ROUNDSTART_TRAIT)

// addiction
/datum/trait/neutral/addiction_tricord
	name = "Addiction - " + REAGENT_TRICORDRAZINE
	desc = "You have become chemically dependant to " + REAGENT_TRICORDRAZINE + ", and need to regularly consume it or suffer withdrawals."
	addiction = REAGENT_ID_TRICORDRAZINE
	custom_only = FALSE
