#define SHEET_TO_REAGENT_EQUIVILENT *(1/REAGENTS_PER_SHEET) // 0.05 normally 1/20

// Use these, unless it had a sheet analog to match,    VAL * 0.05 * 5000 = per full tank points
#define EXPORT_VALUE_NO 0.1 SHEET_TO_REAGENT_EQUIVILENT			// 25 per tank
#define EXPORT_VALUE_UNWANTED 0.24 SHEET_TO_REAGENT_EQUIVILENT	// 60 per tank
#define EXPORT_VALUE_COMMON 1 SHEET_TO_REAGENT_EQUIVILENT		// 250 per tank
#define EXPORT_VALUE_RARE 2 SHEET_TO_REAGENT_EQUIVILENT			// 500 per tank
#define EXPORT_VALUE_PROCESSED 3 SHEET_TO_REAGENT_EQUIVILENT	// 750 per tank
#define EXPORT_VALUE_HIGHREFINED 4 SHEET_TO_REAGENT_EQUIVILENT	// 1000 per tank
#define EXPORT_VALUE_MASSINDUSTRY 8 SHEET_TO_REAGENT_EQUIVILENT	// 2000 per tank
#define EXPORT_VALUE_PEAK 16 SHEET_TO_REAGENT_EQUIVILENT		// 4000 per tank
#define EXPORT_VALUE_GODTIER 20 SHEET_TO_REAGENT_EQUIVILENT		// 5000 per tank

// Use these or you'll get weird endround lists
#define EXPORT_REASON_BIOHAZARD "unwanted biohazards"
#define EXPORT_REASON_RAW "raw industrial materials"
#define EXPORT_REASON_PHORON "Nanotrasen patent violations" // Outpost 21 specific
#define EXPORT_REASON_DRUG "pharmaceutical drugs"
#define EXPORT_REASON_ILLDRUG "illegal drugs"
#define EXPORT_REASON_RECDRUG "widespread recreational drugs"
#define EXPORT_REASON_CLONEDRUG "vat cloning stablizers"
#define EXPORT_REASON_SPECIALDRUG "specialized high end drugs"
#define EXPORT_REASON_DIET "dietary supplements"
#define EXPORT_REASON_FOOD "culinary ingredients"
#define EXPORT_REASON_MATSCI "material science research"
#define EXPORT_REASON_MEDSCI "medical science research"
#define EXPORT_REASON_INDUSTRY "heavy industrial materials"
#define EXPORT_REASON_PRECURSOR "industrial precursor chemicals"
#define EXPORT_REASON_WEAPONS "chemical weaponry"
#define EXPORT_REASON_COMSTIM "combat stimulants"
#define EXPORT_REASON_COSMETIC "cosmetic coatings and drugs"
#define EXPORT_REASON_CLEAN "cleaning products"
#define EXPORT_REASON_LUBE "industrial lubricants"

// End of round global list, each macro above is used as a list index for the amount of that export type sold!
GLOBAL_LIST_EMPTY(refined_chems_sold)

// The tl;dr here is that the supply_conversion_value of the reagent should just match the per sheet value with the macro above.
// That should keep everything inline and not cause any cargo exploits.
/datum/reagent
	var/supply_conversion_value = 0 SHEET_TO_REAGENT_EQUIVILENT
	var/industrial_use = "uncommon uses" // unique description for export off station

/datum/reagent/nutriment // Generic food mush
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/drink // Generic drinks
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/ethanol
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

// code\modules\reagents\reagents\core.dm
/datum/reagent/blood
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/water
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/antibodies
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/fuel
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/phororeagent
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_INDUSTRY

// code\modules\reagents\reagents\dispenser.dm
/datum/reagent/aluminum
	supply_conversion_value = 1 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/calcium
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/carbon
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/chlorine
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/copper
	supply_conversion_value = 0.5 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/tin
	supply_conversion_value = 0.5 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/fluorine
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/hydrogen
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/iron
	supply_conversion_value = 1 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/lithium
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/mercury
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/nitrogen
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/oxygen
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/phosphorus
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/potassium
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/radium
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/acid
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/silicon
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/sodium
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/sugar
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/sulfur
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/tungsten
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

// code\modules\reagents\reagents\dispenser_op.dm
/datum/reagent/titanium_dioxide
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_COSMETIC

/datum/reagent/titanium
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_INDUSTRY

// code\modules\reagents\reagents\drugs.dm
/datum/reagent/drugs/bliss
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED // bonus
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/drugs/ambrosia_extract
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED // bonus
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/drugs/psilocybin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED // bonus
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/drugs/talum_quem
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/drugs/nicotine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_RECDRUG

/datum/reagent/drugs/methylphenidate
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/drugs/citalopram
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/drugs/paroxetine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/drugs/qerr_quem
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

// code\modules\reagents\reagents\food_drinks_vr.dm
/datum/reagent/toxin/meatcolony
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/toxin/plantcolony
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

// code\modules\reagents\reagents\food_drinks.dm
/datum/reagent/lipozine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DIET

/datum/reagent/sodiumchloride
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/blackpepper
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/enzyme
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/spacespice
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/browniemix
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/cakebatter
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/frostoil
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/frostoil/cryotoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/capsaicin
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/condensedcapsaicin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/toxin/poisonberryjuice
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_BIOHAZARD

// code\modules\reagents\reagents\medicine_ch.dm
/*
/datum/reagent/claridyl
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/claridyl/bloodburn
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/eden
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/eden/snake
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_BIOHAZARD
*/

/datum/reagent/tercozolam
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/*
/datum/reagent/hannoa
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/bullvalene
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/serazine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/alizene
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG
*/

// code\modules\reagents\reagents\medicine_op.dm
/datum/reagent/hemocyanin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/acid/artificial_sustenance
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

// code\modules\reagents\reagents\medicine_vr.dm
/datum/reagent/adranol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/numbing_enzyme
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/vermicetol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/prussian_blue
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/lipozilase
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DIET

/datum/reagent/lipostipo
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DIET

/datum/reagent/polymorph
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED // bonus
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/glamour
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_COSMETIC

// code\modules\reagents\reagents\medicine.dm
/datum/reagent/inaprovaline
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/inaprovaline/topical
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/bicaridine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/bicaridine/topical
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/calciumcarbonate
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/kelotane
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/dermaline
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/dermaline/topical
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/dylovene
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/carthatoline
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/dexalin
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/dexalinp
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/tricordrazine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/tricorlidaze
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/cryoxadone
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/clonexadone
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/mortiferin
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/necroxadone
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/paracetamol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/tramadol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/oxycodone
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/synaptizine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/hyperzine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_COMSTIM

/datum/reagent/alkysine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/imidazoline
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/peridaxon
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/osteodaxon
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/myelamine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/respirodaxon
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/gastirodaxon
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/hepanephrodaxon
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/cordradaxon
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/immunosuprizine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/skrellimmuno
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/ryetalyn
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/ethylredoxrazine
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_RECDRUG

/datum/reagent/hyronalin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_SPECIALDRUG

/datum/reagent/arithrazine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/spaceacillin
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/corophizine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/spacomycaze
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/sterilizine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_CLEAN

/datum/reagent/leporazine
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/rezadone
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/healing_nanites
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/menthol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/earthsblood
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_DRUG

// code\modules\reagents\reagents\modifiers.dm
/datum/reagent/modapplying/cryofluid
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/modapplying/vatstabilizer
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_PHORON

// code\modules\reagents\reagents\other_ch.dm
/datum/reagent/liquidspideregg
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/nutriment/pitcher_nectar
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/toxin/bluesap
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/purplesap
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/orangesap
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/benzilate
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phenethylamine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_RECDRUG

// code\modules\reagents\reagents\other_vr.dm
/datum/reagent/advmutationtoxin
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/firefighting_foam
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_INDUSTRY

/datum/reagent/liquid_protean
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/grubshock
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_PRECURSOR

// code\modules\reagents\reagents\other.dm
/datum/reagent/crayon_dust
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_COSMETIC

/datum/reagent/marker_ink
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_COSMETIC

/datum/reagent/paint
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_COSMETIC

/datum/reagent/adminordrazine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = "how did you get this?"

/datum/reagent/gold
	supply_conversion_value = 2 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/silver
	supply_conversion_value = 1 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/platinum
	supply_conversion_value = 5 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/uranium
	supply_conversion_value = 2 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/hydrogen/deuterium
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/hydrogen/tritium
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/lithium/lithium6
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/helium/helium3
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/boron/boron11
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/supermatter
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/adrenaline
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/water/holywater
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/ammonia
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_RAW

/datum/reagent/diethylamine
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/fluorosurfactant
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/foaming_agent
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/thermite
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/space_cleaner
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_CLEAN

/datum/reagent/lube
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_LUBE

/datum/reagent/silicate
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/glycerol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/nitroglycerin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/coolant
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_INDUSTRY

/datum/reagent/ultraglue
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/woodpulp
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/luminol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/nutriment/biomass
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_CLONEDRUG

/datum/reagent/mineralfluid
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/defective_nanites
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/nutriment/fishbait
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/nutriment/paper
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/carpet
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/essential_oil
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

// code\modules\reagents\reagents\toxins.dm
/datum/reagent/toxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/plasticide
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/amatoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/carpotoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/neurotoxic_protein
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/toxin/hydrophoron
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/lead
	supply_conversion_value = 0.5 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/spidertoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/toxin/phoron
	supply_conversion_value = 5 SHEET_TO_REAGENT_EQUIVILENT // has sheet value
	industrial_use = EXPORT_REASON_PHORON

/datum/reagent/toxin/cyanide
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/mold
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/toxin/expired_medicine
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/toxin/stimm
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/toxin/potassium_chloride
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/toxin/potassium_chlorophoride
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/toxin/zombiepowder
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/toxin/lichpowder
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/toxin/fertilizer
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_FOOD

/datum/reagent/toxin/plantbgone
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/sifslurry
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/acid/polyacid
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_INDUSTRY

/datum/reagent/acid/digestive
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/acid/diet_digestive
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/thermite/venom
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/condensedcapsaicin/venom
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/lexorin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/mutagen
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/slimejelly
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/soporific
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/chloralhydrate
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/serotrotium
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/serotrotium/venom
	supply_conversion_value = EXPORT_VALUE_UNWANTED
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/cryptobiolin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/impedrezene
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/mindbreaker
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/slimetoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/aslimetoxin
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/shredding_nanites
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/irradiated_nanites
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/neurophage_nanites
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

// code\modules\reagents\reagents\vore_ch.dm
/datum/reagent/aphrodisiac
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_RECDRUG

/datum/reagent/sorbitol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/radium/concentrated
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MATSCI

// code\modules\reagents\reagents\vore_vr.dm
/datum/reagent/macrocillin
	supply_conversion_value = EXPORT_VALUE_GODTIER
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/microcillin
	supply_conversion_value = EXPORT_VALUE_GODTIER
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/normalcillin
	supply_conversion_value = EXPORT_VALUE_GODTIER
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/sizeoxadone
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/ickypak
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/unsorbitol
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/amorphorovir
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/drugs/rainbow_toxin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_RECDRUG

/datum/reagent/paralysis_toxin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/pain_enzyme
	supply_conversion_value = EXPORT_VALUE_PROCESSED
	industrial_use = EXPORT_REASON_WEAPONS

// code\modules\xenobio\items\slime_objects.dm
/datum/reagent/xeyakinblood
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MATSCI

// modular_chomp\code\modules\reagents\reagents\dispenser.dm
/datum/reagent/miasma
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

// modular_chomp\code\modules\reagents\reagents\food_drinks.dm
/datum/reagent/slimedrink
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/cinnamonpowder
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_FOOD

// modular_chomp\code\modules\reagents\reagents\medicine.dm
/datum/reagent/change_drug/male
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/change_drug/female
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/change_drug/intersex
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/cleansingagent
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/purifyingagent
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/burncard
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/flamecure
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/neotane
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/bloodsealer
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/livingagent
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/performancepeaker
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/souldew
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/quadcord
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/juggernog
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/curea
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/modapplying/liquidhealer
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phoenixbreath
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/dryagent
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_INDUSTRY

// modular_chomp\code\modules\reagents\reagents\modapply.dm
/datum/reagent/modapplying/energybooster
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/modapplying/oceaniccure
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/modapplying/deathclawmutagen
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/modapplying/senseenhancer
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/modapplying/heatnullifer
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_MEDSCI

// modular_chomp\code\modules\reagents\reagents\toxin.dm
/datum/reagent/toxin/deathblood
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_PRECURSOR

/datum/reagent/toxin/liquidfire
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_INDUSTRY

/datum/reagent/toxin/neonliquidfire
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_INDUSTRY

/datum/reagent/toxin/liquidlife
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_MATSCI

// code\modules\Phorochemistry\phororeagent.dm
/datum/reagent/phororeagent/bicordrazine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/phororeagent/genedrazine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_DRUG

/datum/reagent/phororeagent/lacertusol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/love_potion
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/phororeagent/nasty
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/phororeagent/babelizine
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/calcisol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/malaxitol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/paralitol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/doloran
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/fulguracin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/mortemol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/tegoxane
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/expulsicol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/oculusosone
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/destitutionecam
	supply_conversion_value = EXPORT_VALUE_NO
	industrial_use = EXPORT_REASON_BIOHAZARD

/datum/reagent/phororeagent/sapoformator
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_CLEAN

/datum/reagent/phororeagent/rad_x
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/caloran
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/the_stuff
	supply_conversion_value = EXPORT_VALUE_MASSINDUSTRY
	industrial_use = EXPORT_REASON_ILLDRUG

/datum/reagent/phororeagent/frioline
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/luxitol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MEDSCI

/datum/reagent/phororeagent/liquid_skin
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/energized_phoron
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/induromol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/obscuritol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/tartrate
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/phororeagent/oxyphoromin
	supply_conversion_value = EXPORT_VALUE_PEAK
	industrial_use = EXPORT_REASON_PHORON

/datum/reagent/phororeagent/gaseous/occaecosone
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

/datum/reagent/phororeagent/gaseous/ignisol
	supply_conversion_value = EXPORT_VALUE_HIGHREFINED
	industrial_use = EXPORT_REASON_WEAPONS

// code\modules\Phorochemistry\misc_phoronics.dm
/datum/reagent/nitrate
	supply_conversion_value = EXPORT_VALUE_COMMON
	industrial_use = EXPORT_REASON_MATSCI

/datum/reagent/aluminum_nitrate
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_MATSCI

// code\game\gamemodes\changeling\powers\epinephrine_overdose.dm
/datum/reagent/epinephrine
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_MATSCI

// code\modules\mob\living\carbon\human\species\lleill\lleill_items.dm
/datum/reagent/glamour_scaling
	supply_conversion_value = EXPORT_VALUE_RARE
	industrial_use = EXPORT_REASON_MATSCI

#undef EXPORT_REASON_BIOHAZARD
#undef EXPORT_REASON_RAW
#undef EXPORT_REASON_PHORON
#undef EXPORT_REASON_DRUG
#undef EXPORT_REASON_ILLDRUG
#undef EXPORT_REASON_RECDRUG
#undef EXPORT_REASON_CLONEDRUG
#undef EXPORT_REASON_SPECIALDRUG
#undef EXPORT_REASON_DIET
#undef EXPORT_REASON_FOOD
#undef EXPORT_REASON_MATSCI
#undef EXPORT_REASON_MEDSCI
#undef EXPORT_REASON_INDUSTRY
#undef EXPORT_REASON_PRECURSOR
#undef EXPORT_REASON_WEAPONS
#undef EXPORT_REASON_COMSTIM
#undef EXPORT_REASON_COSMETIC
#undef EXPORT_REASON_CLEAN
#undef EXPORT_REASON_LUBE

#undef EXPORT_VALUE_NO
#undef EXPORT_VALUE_UNWANTED
#undef EXPORT_VALUE_COMMON
#undef EXPORT_VALUE_RARE
#undef EXPORT_VALUE_PROCESSED
#undef EXPORT_VALUE_HIGHREFINED
#undef EXPORT_VALUE_MASSINDUSTRY
#undef EXPORT_VALUE_GODTIER

#undef SHEET_TO_REAGENT_EQUIVILENT
