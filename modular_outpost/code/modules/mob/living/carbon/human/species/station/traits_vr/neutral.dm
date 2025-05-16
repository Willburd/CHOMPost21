/datum/trait/neutral/drippy
	name = "Drippy"
	desc = "You cannot hold your form together, or produce a constant film of sludge that drips off of your body. Hope the station has a janitor."
	cost = 0
	var_changes = list("drippy" = 1)

	// Traitgenes edit begin - Made into a genetrait
	is_genetrait = TRUE
	hidden = FALSE

	activation_message="You feel softer..."
	primitive_expression_messages=list("drips.")
	// Traitgenes edit end

// Allergens
/datum/trait/neutral/allergy/pollen
	name = "Allergy: Pollen"
	desc = "You're highly allergic to pollen and many plants. It's probably best to avoid hydroponics in general. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_POLLEN // Gee billy...
	added_component_path = /datum/component/pollen_disability // Why does mom let you have two things?

/datum/trait/neutral/allergy/salt
	name = "Allergy: Salt"
	desc = "You're highly allergic to sodium chloride aka salt. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_SALT

//Allergen custom effects!
/datum/trait/neutral/allergy_reaction/gibbing
	name = "Allergy Reaction: Gibbing"
	desc = "When exposed to one of your allergens, you will explode, god help you. Does nothing if you have no allergens."
	cost = 0
	custom_only = FALSE
	reaction = AG_GIBBING

/datum/trait/neutral/allergy_reaction/sneeze
	name = "Allergy Reaction: Sneezing"
	desc = "When exposed to one of your allergens, you will begin sneezing harmlessly. Does nothing if you have no allergens."
	cost = 0
	custom_only = FALSE
	reaction = AG_SNEEZE

/datum/trait/neutral/allergy_reaction/cough
	name = "Allergy Reaction: Coughing"
	desc = "When exposed to one of your allergens, you will begin coughing, potentially dropping items. Does nothing if you have no allergens."
	cost = 0
	custom_only = FALSE
	reaction = AG_COUGH

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
