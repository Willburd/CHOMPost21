/datum/trait/neutral/drippy
	name = "Drippy"
	desc = "You cannot hold your form together, or produce a constant film of sludge that drips off of your body. Hope the station has a janitor."
	cost = 0
	var_changes = list("drippy" = 1)

// Allergens
/datum/trait/neutral/allergy/pollen
	name = "Allergy: Pollen"
	desc = "You're highly allergic to pollen and many plants. It's probably best to avoid hydroponics in general. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_POLLEN

/datum/trait/neutral/allergy/salt
	name = "Allergy: Salt"
	desc = "You're highly allergic to sodium chloride aka salt. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_SALT

//Allergen custom effects!
/datum/trait/neutral/allergy_effects
	name = "Allergic Reaction : Sneezing"
	desc = "This trait causes spontanious sneezing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	var/allergeneffect = AG_SNEEZE

/datum/trait/neutral/allergy_effects/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	if(S.allergen_reaction & AG_FLAG_SPECIESBASE)
		S.allergen_reaction = 0 // this is the first to override! Wipe all effects, so we can setup our custom reaction!
	S.allergen_reaction |= allergeneffect
	..(S,H)

/datum/trait/neutral/allergy_effects/bruise
	name = "Allergic Reaction : Bruising"
	desc = "This trait causes spontanious bruising as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_PHYS_DMG

/datum/trait/neutral/allergy_effects/burns
	name = "Allergic Reaction : Burns"
	desc = "This trait causes spontanious burns as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_BURN_DMG

/datum/trait/neutral/allergy_effects/toxic
	name = "Allergic Reaction : Toxins"
	desc = "This trait causes spontanious bloodstream toxins as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_TOX_DMG

/datum/trait/neutral/allergy_effects/gasp
	name = "Allergic Reaction : Gasping"
	desc = "This trait causes spontanious airway constriction as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_OXY_DMG

/datum/trait/neutral/allergy_effects/twitch
	name = "Allergic Reaction : Twitch"
	desc = "This trait causes spontanious twitching as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_EMOTE

/datum/trait/neutral/allergy_effects/weakness
	name = "Allergic Reaction : Weakness"
	desc = "This trait causes spontanious weakness as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_WEAKEN

/datum/trait/neutral/allergy_effects/sleepy
	name = "Allergic Reaction : Blurred vision"
	desc = "This trait causes spontanious blurred vision as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_BLURRY

/datum/trait/neutral/allergy_effects/sleepy
	name = "Allergic Reaction : Sleepy"
	desc = "This trait causes spontanious sleepiness as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_SLEEPY

/datum/trait/neutral/allergy_effects/confusion
	name = "Allergic Reaction : Confusion"
	desc = "This trait causes spontanious confusion as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_CONFUSE

/datum/trait/neutral/allergy_effects/sneeze
	name = "Allergic Reaction : Sneezing"
	desc = "This trait causes spontanious sneezing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_SNEEZE

/datum/trait/neutral/allergy_effects/gibbing
	name = "Allergic Reaction : Gibbing"
	desc = "This trait causes spontanious gibbing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_GIBBING

/datum/trait/neutral/allergy_effects/cough
	name = "Allergic Reaction : Coughing"
	desc = "This trait causes spontanious coughing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_COUGH


// autohiss
/datum/trait/neutral/autohiss_zaddat
	name = "Autohiss (Yinglet)"
	desc = "You pronounce th's with a lisp"
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"thi" = list("z"),
			"shi" = list("z"),
			"tha" = list("z"),
			"tho" = list("z")
		),
	autohiss_extra_map = list(
			"the" = list("z"),
			"so" = list("z")
		),
	autohiss_exempt = list(LANGUAGE_UNATHI))
	excludes = list(/datum/trait/neutral/autohiss_unathi, /datum/trait/neutral/autohiss_tajaran, /datum/trait/neutral/autohiss_zaddat)
