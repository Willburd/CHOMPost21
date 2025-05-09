#define DEFAULT_HUNGER_FACTOR 0.05 // Factor of how fast mob nutrition decreases

#define REM 0.2 // Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick

#define CHEM_TOUCH 1
#define CHEM_INGEST 2
#define CHEM_BLOOD 3
#define CHEM_VORE 4 // vore belly interactions

#define MINIMUM_CHEMICAL_VOLUME 0.01

#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REAGENTS_OVERDOSE 30

#define CHEM_SYNTH_ENERGY 500 // How much energy does it take to synthesize 1 unit of chemical, in Joules.

// Some on_mob_life() procs check for alien races.
#define IS_DIONA   1
#define IS_VOX     2
#define IS_SKRELL  3
#define IS_UNATHI  4
#define IS_TAJARA  5
#define IS_XENOS   6
#define IS_TESHARI 7
#define IS_SLIME   8
#define IS_ZADDAT  9
#define IS_ZORREN  10

#define CE_STABLE "stable" // Inaprovaline
#define CE_ANTIBIOTIC "antibiotic" // Antibiotics
#define CE_BLOODRESTORE "bloodrestore" // Iron/nutriment
#define CE_PAINKILLER "painkiller"
#define CE_ALCOHOL "alcohol" // Liver filtering
#define CE_ALCOHOL_TOXIC "alcotoxic" // Liver damage
#define CE_SPEEDBOOST "gofast" // Hyperzine
#define CE_SLOWDOWN "goslow" // Slowdown
#define CE_ANTACID "nopuke" // Don't puke.
#define CE_ALLERGEN "allergyreaction" // Self explanatory
#define CE_DARKSIGHT "darksight" // Gives perfect vision in dark

#define REAGENTS_PER_SHEET 20
#define REAGENTS_PER_ORE 20

// Attached to CE_ANTIBIOTIC
#define ANTIBIO_NORM	1
#define ANTIBIO_OD		2
#define ANTIBIO_SUPER	3

// Chemistry lists.
var/list/tachycardics  = list(REAGENT_ID_COFFEE, REAGENT_ID_INAPROVALINE, REAGENT_ID_HYPERZINE, REAGENT_ID_NITROGLYCERIN,REAGENT_ID_THIRTEENLOKO, REAGENT_ID_NICOTINE) // Increase heart rate.
var/list/bradycardics  = list(REAGENT_ID_NEUROTOXIN, REAGENT_ID_CRYOXADONE, REAGENT_ID_CLONEXADONE, REAGENT_ID_BLISS, REAGENT_ID_STOXIN, REAGENT_ID_AMBROSIAEXTRACT)   // Decrease heart rate.
var/list/heartstopper  = list(REAGENT_ID_POTASSIUMCHLOROPHORIDE, REAGENT_ID_ZOMBIEPOWDER) // This stops the heart.
var/list/cheartstopper = list(REAGENT_ID_POTASSIUMCHLORIDE)                       // This stops the heart when overdose is met. -- c = conditional

#define MAX_PILL_SPRITE 24 //max icon state of the pill sprites
#define MAX_BOTTLE_SPRITE 4 //max icon state of the pill sprites
#define MAX_PATCH_SPRITE 4 //max icon state of the patch sprites, CHOMPedit
#define MAX_MULTI_AMOUNT 20 // Max number of pills/patches that can be made at once
#define MAX_UNITS_PER_PILL 60 // Max amount of units in a pill
#define MAX_UNITS_PER_PATCH 60 // Max amount of units in a patch
#define MAX_UNITS_PER_BOTTLE 60 // Max amount of units in a bottle (it's volume)
#define MAX_CUSTOM_NAME_LEN 64 // Max length of a custom pill/condiment/whatever

#define ALCOHOLIC_EFFECT_MULTIPLIER 14 // Outpost 21 edit - Booze lasts LONG here
#define ALCOHOLIC_DIZZY_MULTIPLIER 1.7 // Outpost 21 edit - Booze wobbles more
