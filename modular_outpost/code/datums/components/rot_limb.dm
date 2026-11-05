/datum/component/limb_rot
	// Targeted limb that will rot
	VAR_PRIVATE/list/target_limbs = list()
	// Raises each tick till it eventually triggers
	VAR_PRIVATE/end_probability = 0

/datum/component/limb_rot/Initialize(list/possible_limbs)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	if(!islist(possible_limbs))
		if(possible_limbs && (possible_limbs in BP_ALL))
			// had a valid limb that wasn't a list, just wrap it
			possible_limbs = list(possible_limbs)
		else
			// Otherwise target any limb
			possible_limbs = BP_ALL
	target_limbs += possible_limbs

// Easy subtypes
/datum/component/limb_rot/hands/Initialize(list/possible_limbs)
	. = ..(list(BP_L_HAND, BP_R_HAND))

/datum/component/limb_rot/feet/Initialize(list/possible_limbs)
	. = ..(list(BP_L_FOOT, BP_R_FOOT))

/datum/component/limb_rot/arms/Initialize(list/possible_limbs)
	. = ..(list(BP_L_HAND, BP_R_HAND, BP_L_ARM, BP_R_ARM))

/datum/component/limb_rot/legs/Initialize(list/possible_limbs)
	. = ..(list(BP_L_FOOT, BP_R_FOOT, BP_L_LEG, BP_R_LEG))

/datum/component/limb_rot/head/Initialize(list/possible_limbs)
	. = ..(list(BP_HEAD))

/datum/component/limb_rot/body/Initialize(list/possible_limbs)
	. = ..(list(BP_TORSO, BP_GROIN))

/datum/component/limb_rot/all_limbs/Initialize(list/possible_limbs)
	. = ..(BP_ALL)
// end subtypes

/datum/component/limb_rot/RegisterWithParent()
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(process_component))

/datum/component/limb_rot/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_LIVING_LIFE)

/datum/component/limb_rot/proc/process_component()
	SIGNAL_HANDLER
	if(QDELETED(src) || QDELETED(parent))
		return

	// Chance to do nothing
	if(prob(10))
		return

	// Probability to end raises over time
	if(prob(end_probability / 2))
		qdel(src)
		return
	end_probability++

	// Check if we can event melt them
	var/limb = pick(target_limbs)
	var/mob/living/carbon/human/target = parent

	// These cure infections, lets not confuse medical...
	if(target.reagents.has_reagent(REAGENT_ID_SPACEACILLIN) || target.reagents.has_reagent(REAGENT_ID_SPACOMYCAZE))
		qdel(src)
		return

	// Robotic limbs don't count
	var/obj/item/organ/external/affecting = target.get_organ(limb)
	if(affecting.robotic)
		qdel(src)
		return

	// Damage the limb, and if enough melt it... Higher chance to melt over time.
	affecting.adjust_germ_level(rand(1,1 + end_probability))
	if((affecting.damage + end_probability) >= (affecting.max_damage - end_probability) && prob(6))
		affecting.droplimb(TRUE, DROPLIMB_ACID)
