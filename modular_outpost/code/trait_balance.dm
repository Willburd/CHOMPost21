#ifndef OUTPOST_FRIENDSHIP_MODE
// Only modify upstream traits here, do our own directly!!!
// They are in modular_outpost\code\modules\mob\living\carbon\human\species\station\traits_vr\X.dm

// Please mark your reasoning for later consideration if point cost is modified in the future.

/////////////////////////////////////////////////////////////////////////////////////////////////
/// POSITIVE
/////////////////////////////////////////////////////////////////////////////////////////////////
/datum/trait/positive/virus_immune // Cannot get viruses or malignant organs
	cost = 5 // upstream is: 1

/datum/trait/positive/stable_genetics // Cannot mutate
	cost = 5 // upstream is: 2

/datum/trait/positive/rad_immune // Cannot be irradiated
	cost = 6 // upstream is: 3

/datum/trait/positive/rad_resistance_extreme // like above but lesser
	cost = 5 // upstream is: 2

/datum/trait/positive/rad_resistance // like above but lesser
	cost = 3 // upstream is: 1

/datum/trait/positive/darksight // See in dark like xenochi
	cost = 2 // upstream is: 1

/datum/trait/positive/darksight_plus
	cost = 3 // upstream is: 2

/datum/trait/positive/photosynth
	cost = 1 //Base: 3. Can't get fat, kinda doodoo overall. It's fine.

/datum/trait/positive/trauma_tolerance
	cost = 3 //Base 2: Grit is REALLY strong, and hyper abusable if you use it right.

/datum/trait/positive/antiseptic_saliva
	cost = 3 //Base 1: Infinite free bandages, just needs food to cure bleeding, prevent infections, and rapid heal. IIRC very similar stats to a straight up bandage.

/datum/trait/positive/winged_flight
	cost = 2 //Base 0. You can go up/down z-levels and spont. vore anyone for the low cost of having wings selected on your character creator. Bruh.

/datum/trait/positive/melee_attack
	cost = 0 //Base 1: Literally every species except prommies and humans has this by default, no real advantage in combat. It's fair to have it at 0

/datum/trait/positive/melee_attack_fangs
	cost = 1 //Base 2: Balances with the above.

/datum/trait/positive/nonconductive_plus
	desc = "Decreases your susceptibility to electric shocks by 40%." //Slight nerf. Typically I feel 1 point for 10% is fair.. I'm being nice with this.
	var_changes = list("siemens_coefficient" = 0.6)

/datum/trait/positive/hardy
	banned_species = list(SPECIES_UNATHI, SPECIES_ZADDAT, SPECIES_SHADEKIN, SPECIES_DIONA) //Temp buff to a lot of these species. Only for the lowest level of hardy, though.
	// Species on banned list already have a better item slowdown modifier

/datum/trait/positive/strength
	cost = 3 //base 2. Extra attack and slowdown for the same cost as less slowdown? Seems a bit too strong.

/datum/trait/positive/shredding_attacks
	hidden = FALSE //Base: true. It's 6 points.. seems fair? This is pretty nuts though.
	cost = 6 //Base 6. Just incase, though...

/datum/trait/positive/linguist
	cost = 1 //Base 2. I think it's fine? Just means more RP sillies.

/datum/trait/positive/lowpressureresminor
	cost = 2 //base 1. This feels really strong, looking at the numbers. 66% resistance for 1 point?

/datum/trait/positive/lowpressureresmajor
	cost = 4 //Base 2: No immunity should be under 4 points.

/datum/trait/positive/highpressureresminor
	cost = 2 //Base 1: Bringing in-line with low pressure.

/datum/trait/positive/highpressureresmajor
	cost = 4 //Base 2: Brings in like with low pressure, and x4 might as well be immunity.

/datum/trait/positive/pressureres
	cost = 4 //Base 3. Combines the two above. Brings in line

/datum/trait/positive/pressureresmajor
	cost = 7 //Base 4. Immunity to both high and low? Nah bruh.

/datum/trait/positive/more_blood
	desc = "You have 50% more blood. Species with lower blood volumes get bonus blood for free."

/datum/trait/positive/more_blood_extreme
	desc = "You have 150% more blood. Species with lower blood volumes get bonus blood for free."

/datum/trait/positive/burn_resist_plus
	cost = 4 //Base 3. 40% reduced damage, 1 point per 10%

/datum/trait/positive/brute_resist_plus
	cost = 4 //Base 3. Ibid

/datum/trait/positive/pain_tolerance_advanced
	cost = 4 //Base 3. Reduces pain by 40%, should be in-line with the others.

/datum/trait/positive/photoresistant_plus
	cost = 4 //Base 2. 50% reduction for 2 points? Nah yawn. Not today.

/datum/trait/positive/hardy_extreme
	banned_species = list(SPECIES_ALRAUNE, SPECIES_TESHARI, SPECIES_UNATHI, SPECIES_DIONA, SPECIES_PROMETHEAN, SPECIES_PROTEAN) //These species can't take the other two hardies, why can they take this one? Make it make sense.
	cost = 20 //fuck you cost of points, for being IMMUNE to all slowdown of armor, hardsuits, etc. Which is a major balancing factor

/datum/trait/positive/sonar
	cost = 0 //This trait is el barbagio. It needs to be free.

/datum/trait/positive/toxin_gut
	cost = 4 //Immunities should not be cheap.

/////////////////////////////////////////////////////////////////////////////////////////////////
/// NEUTRAL
/////////////////////////////////////////////////////////////////////////////////////////////////
/* NOTE: Until neutral traits actually give or cost points, these are not even usable...
/datum/trait/neutral/allergy_reaction/gibbing // Sploot gives some bonus points
	cost = -2 // upstream is: 0

/datum/trait/neutral/venom_bite
	cost = 2 // Base 0. Lets you give various toxins for mechanical benefit, too stronk for free.

/datum/trait/neutral/long_vore
	cost = 1 //Base 0. Free ranged spontaneous vore with a 5 tile range? Wuh?

/datum/trait/neutral/allergen_increased_effect
	cost = -1 //Base 0: A lot of reactions can HURT. This feels fair.

/datum/trait/neutral/colorblind/mono
	cost = -1 //Base 0: No colors makes the game HELL, and it affects wire hacking.

/datum/trait/neutral/colorblind/para_vulp
	cost = -1 //Base 0: All colorblindness makes things harder, and it effects wires and various mechanics.

/datum/trait/neutral/colorblind/para_taj
	cost = -1 //Base 0. Ibid.
*/
/datum/trait/neutral/strongimmunesystem
	hidden = TRUE //Base False. This is virus immunity reflavored. Fukkin why?

/////////////////////////////////////////////////////////////////////////////////////////////////
/// NEGATIVE
/////////////////////////////////////////////////////////////////////////////////////////////////
/datum/trait/negative/disability_censored // Free points begone
	cost = 0 // upstream is: -1

/datum/trait/negative/disability_nervousness // Free points begone
	cost = 0 // upstream is: -1

/datum/trait/negative/speed_slow
	cost = -4 //Base -3. Haste is 4, this is the same numbers. Should match.

/datum/trait/negative/endurance_low
	cost = -3 //Base -4. Endurance is a 25 point increase for 3 points.  Why do you get more points going down?

/datum/trait/negative/endurance_very_low
	cost = -6 //Base -8. Same as above, gaining 50 points costs 6. Going down should only grant 6.

/datum/trait/negative/brute_weak_plus
	cost = -4 //Base -3. Matches the cost for brute bonus.

/datum/trait/negative/burn_weak_plus
	cost = -4 //Base -3. Matches burn resist of the same tier.

/datum/trait/negative/haemophilia
	cost = -3 //Base -2. This is ROUGH in gameplay, especially with our traps.

/datum/trait/negative/haemophilia_plus
	cost = -5 //Base -3. This means you die REALLY fast. You can legit die in seconds from a beartrap.

/datum/trait/negative/lightweight
	cost = -3 //Base -2. Combat is a big part, this makes it brutal, and EVERY DIPSHIT walking around on harm intent crushes you under foot.
	desc = "Your light weight and poor balance make you very susceptible to unhelpful bumping. Think of it like a bowling ball versus a pin." //Don't have admin notices in descriptions, it's petty.

/datum/trait/negative/breathes
	cost = -5 //Base -2. This effects more than you think. Surgery, anesthetics, backpacks, hardsuits, just getting knocked over, getting stripped. Only benefit is forever internals.

/datum/trait/negative/monolingual
	cost = -2 //base -1. Languages come into play a LOT.

/datum/trait/negative/bad_shooter
	cost = -3 //Base -3. 35% reduction, 1 point per 10%

/datum/trait/negative/neural_hypersensitivity
	cost = -4 //Base -1. Apparently this applies to most damage effects. Pain slowdown, halloss, paincrit

/datum/trait/negative/low_blood_sugar
	cost = -2 //Base -1. Yeah it's easy to ignore, but this can effect hard, and we want to encourage interacting with the game.

/datum/trait/negative/blindness
	hidden = FALSE //Base:True. This used to be a disability you could just take. Let people take it again.

/datum/trait/negative/agoraphobia
	cost = -4 //Base -3. This can be really rough in groups, and hard to mitigate.

/datum/trait/negative/lonely
	cost = -2 //Base -1. Lowpop servers SUFFER with this

/datum/trait/negative/lonely/major
	cost = -4 //Base -3, brings in line with agora

/datum/trait/negative/reduced_biocompat_minor
	cost = -1 //Base -2. There's a TON of other ways to heal other than chems. Surgery, cryo, first aid kits, certain foods. These three are way too much of freebie points.

/datum/trait/negative/reduced_biocompat
	cost = -2 //Base -4 //Makes the same values as the sensitive biochem traits

/datum/trait/negative/reduced_biocompat_extreme
	cost = -3 //Base -8 //Same as extreme biochem.

/datum/trait/negative/light_sensitivity
	cost = -2 //Base -1. This even effects pen lights, and really screws with gameplay. Might increase welder damage.

/datum/trait/negative/light_sensitivity_plus
	cost = -4 //Base -2. Flashers and such are already insane.

/datum/trait/negative/pain_intolerance_advanced
	cost = -4 //Base -3. Gives 50% reduction, standard 10 for 1.

/datum/trait/negative/thick_digits
	cost = -7 //Base -4. NO guns? at all? That effects so damn much.

/datum/trait/negative/nodefib
	cost = -3 //Base -1. ONE point? For no revive at all? That forces resleeving at best.
	desc = "For whatever strange genetic reason, defibs cannot restart your heart. Make sure this is in your medical records!"

/datum/trait/negative/nodefib
	banned_species = list(SPECIES_VOX, SPECIES_PROMETHEAN, SPECIES_DIONA) // TEMP TILL FIXED UPSTREAM

/datum/trait/negative/noresleeve
	cost = -5 //Base -1. BRUH.
	custom_only = FALSE //Fuck custom species locks.
	banned_species = list(SPECIES_LLEILL, SPECIES_SHADEKIN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN, SPECIES_SHADEKIN_CREW, SPECIES_DIONA, SPECIES_XENOCHIMERA, SPECIES_PROTEAN) // TEMP TILL FIXED UPSTREAM

/datum/trait/negative/onelife
	cost = -12 //Base -2. For hard mode? I don't think so. Have you SEEN our maintenance tunnels?
	custom_only = FALSE //Fuck custom species locks.
	banned_species = list(SPECIES_LLEILL, SPECIES_SHADEKIN, SPECIES_ALRAUNE, SPECIES_PROMETHEAN, SPECIES_SHADEKIN_CREW, SPECIES_DIONA, SPECIES_XENOCHIMERA, SPECIES_PROTEAN) // TEMP TILL FIXED UPSTREAM

/datum/trait/negative/neural_hypersensitivity/xenochimera
	cost = -3 //Base 0. Brings in line with the other one. Plus its funny for xenochi to always be feral

/datum/trait/negative/photodegeneration
	cost = -6 //Base -4. The liiiiiiiiight.

/datum/trait/neutral/addiction_bliss
	cost = -1 //Base 0. This one's hard to sate, and you don't start with bliss.

/datum/trait/neutral/addiction_hyper
	cost = -1 //Base 0. Ibid

/datum/trait/neutral/addiction_oxy
	cost = -1 //Base 0. Ibid

/datum/trait/neutral/addiction_painkiller
	cost = -1 //Base 0. Ibid

/datum/trait/neutral/addiction_asustenance
	cost = -2 //Base 0. Unlike other addictions, you can't wean this one off. You WILL die without your gatoraid, if someone steals it: GG.

/datum/trait/negative/boneless
	custom_only = FALSE // Base TRUE, let anyone suffer

/datum/trait/negative/ambulant_blood
	is_genetrait = TRUE // Base FALSE, We want it to be a gene...
	hidden = TRUE // Base FAlSE, ...Because taking it from the start is too disruptive to ling gameplay

#endif
