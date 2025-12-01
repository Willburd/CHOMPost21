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

// allergen
/datum/trait/neutral/allergy/tricord
	name = "Allergy: " + REAGENT_TRICORDRAZINE
	desc = "You're highly allergic to " + REAGENT_TRICORDRAZINE + " and " + REAGENT_TRICORLIDAZE + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -1
	allergen = ALLERGEN_TRICORD

/datum/trait/neutral/allergy/bicard
	name = "Allergy: " + REAGENT_BICARIDINE
	desc = "You're highly allergic to " + REAGENT_BICARIDINE + " and " + REAGENT_BICARIDAZE + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -1
	allergen = ALLERGEN_BICARD

/datum/trait/neutral/allergy/dylo
	name = "Allergy: " + REAGENT_ANTITOXIN
	desc = "You're highly allergic to " + REAGENT_ANTITOXIN + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -2
	allergen = ALLERGEN_DYLO

/datum/trait/neutral/allergy/spacacillin
	name = "Allergy: " + REAGENT_SPACEACILLIN
	desc = "You're highly allergic to " + REAGENT_SPACEACILLIN + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -1
	allergen = ALLERGEN_SPACACIL

/datum/trait/neutral/allergy/peridaxon
	name = "Allergy: " + REAGENT_PERIDAXON
	desc = "You're highly allergic to " + REAGENT_PERIDAXON + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -2
	allergen = ALLERGEN_PERIDAX

/datum/trait/neutral/allergy/kelotane
	name = "Allergy: " + REAGENT_KELOTANE
	desc = "You're highly allergic to " + REAGENT_KELOTANE + ", be sure to write that in your medical record! NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = -1
	allergen = ALLERGEN_KELOTANE

// addiction
/datum/trait/neutral/addiction_tricord
	name = "Addiction - " + REAGENT_TRICORDRAZINE
	desc = "You have become chemically dependant to " + REAGENT_TRICORDRAZINE + ", and need to regularly consume it or suffer withdrawals."
	addiction = REAGENT_ID_TRICORDRAZINE
	custom_only = FALSE
