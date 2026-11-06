/datum/component/necromorph

/datum/component/necromorph/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/necromorph/Destroy(force = FALSE)
	. = ..()
	var/mob/living/carbon/human/zombie = parent
	zombie.death()

/datum/component/necromorph/RegisterWithParent()
	var/mob/living/carbon/human/zombie = parent
	if(zombie.status_flags & GODMODE) //Already have it.
		return COMPONENT_INCOMPATIBLE
	if(ishuman(zombie))
		RegisterSignal(zombie, COMSIG_EXTERNAL_ORGAN_PRE_DAMAGE_APPLICATION, PROC_REF(on_external_damaged))
		RegisterSignal(zombie, COMSIG_INTERNAL_ORGAN_PRE_DAMAGE_APPLICATION, PROC_REF(on_internal_damaged))
		RegisterSignal(zombie, COMSIG_EXTERNAL_ORGAN_STANCE_DAMAGE_APPLICATION, PROC_REF(on_stance_damaged))
		RegisterSignal(zombie, COMSIG_EXTERNAL_ORGAN_GRASP_DAMAGE_APPLICATION, PROC_REF(on_grasp_damaged))
	if(issilicon(zombie))
		RegisterSignal(zombie, COMSIG_SILICON_EMP_ACT, PROC_REF(on_emp))

	//Four main damage types: Brute, Burn, Oxy, Tox
	RegisterSignal(zombie, COMSIG_TAKING_OXY_DAMAGE, PROC_REF(on_oxygen_damage))
	RegisterSignal(zombie, COMSIG_TAKING_TOX_DAMAGE, PROC_REF(on_tox_damage))
	RegisterSignal(zombie, COMSIG_TAKING_FIRE_DAMAGE, PROC_REF(on_fire_damage))
	RegisterSignal(zombie, COMSIG_TAKING_BRUTE_DAMAGE, PROC_REF(on_brute_damage))

	//Rarer types, such as Brain, Clone, Halloss
	RegisterSignal(zombie, COMSIG_TAKING_BRAIN_DAMAGE, PROC_REF(on_brain_damage))
	RegisterSignal(zombie, COMSIG_TAKING_CLONE_DAMAGE, PROC_REF(on_clone_damage))
	RegisterSignal(zombie, COMSIG_TAKING_HALO_DAMAGE, PROC_REF(on_halo_damage))

	//Things such as update health.
	RegisterSignal(zombie, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_update_health))
	RegisterSignal(zombie, COMSIG_TAKING_APPLY_EFFECT, PROC_REF(on_apply_effect))

	//For things that don't fall into a single bucket
	RegisterSignal(zombie, COMSIG_CHECK_FOR_GODMODE, PROC_REF(godmode_check))
	RegisterSignal(zombie, COMSIG_BEING_ELECTROCUTED, PROC_REF(on_electrocute))
	RegisterSignal(zombie, COMSIG_EMBED_OBJECT, PROC_REF(embed_check))

	// Update flags
	zombie.species.flags |= (NO_DNA | NO_SLEEVE | NO_PAIN | NO_POISON | UNDEAD | NO_DEFIB)
	zombie.status_flags |= COMSIG_LIVING_HEALTH_UPDATE_GOD_MODE

	zombie.setOxyLoss(0)
	zombie.setToxLoss(0)
	zombie.SetBlinded(0, TRUE)
	zombie.SetSleeping(0, TRUE)
	zombie.set_stat(CONSCIOUS)
	zombie.hallucination = 0

	zombie.SetWeakened(0, TRUE)
	zombie.status_flags &= ~CANWEAKEN
	zombie.SetStunned(0, TRUE)
	zombie.status_flags &= ~CANSTUN
	zombie.SetParalysis(0, TRUE)
	zombie.status_flags &= ~CANPARALYSE

/datum/component/necromorph/UnregisterFromParent()
	var/mob/living/carbon/human/zombie = parent
	if(ishuman(zombie))
		UnregisterSignal(zombie, list(COMSIG_EXTERNAL_ORGAN_PRE_DAMAGE_APPLICATION, COMSIG_INTERNAL_ORGAN_PRE_DAMAGE_APPLICATION))
	if(issilicon(zombie))
		UnregisterSignal(zombie, list(COMSIG_SILICON_EMP_ACT))

	UnregisterSignal(zombie, list(COMSIG_TAKING_OXY_DAMAGE, COMSIG_TAKING_TOX_DAMAGE, COMSIG_TAKING_FIRE_DAMAGE, \
	COMSIG_TAKING_BRUTE_DAMAGE, COMSIG_TAKING_BRAIN_DAMAGE, COMSIG_TAKING_CLONE_DAMAGE, COMSIG_TAKING_HALO_DAMAGE, \
	COMSIG_LIVING_HEALTH_UPDATE, COMSIG_TAKING_APPLY_EFFECT, COMSIG_CHECK_FOR_GODMODE, COMSIG_BEING_ELECTROCUTED, COMSIG_EMBED_OBJECT))

	//And finally, remove the fact we're in godmode.
	zombie.status_flags &= ~GODMODE
	zombie.status_flags |= CANSTUN|CANWEAKEN|CANPARALYSE
	zombie.species.flags &= ~(UNDEAD)

/datum/component/necromorph/proc/on_external_damaged(mob/living/carbon/human/zombie, brute, burn, sharp, edge, used_weapon, forbidden_limbs, permutation, projectile)
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_EXTERNAL_ORGAN_DAMAGE

/datum/component/necromorph/proc/on_stance_damaged()
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_EXTERNAL_ORGAN_DAMAGE

/datum/component/necromorph/proc/on_grasp_damaged()
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_EXTERNAL_ORGAN_DAMAGE

/datum/component/necromorph/proc/on_internal_damaged(mob/living/carbon/human/zombie, brute, burn, sharp, edge, used_weapon, forbidden_limbs, permutation, projectile)
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_INTERNAL_ORGAN_DAMAGE

/datum/component/necromorph/proc/on_brain_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_BRAIN_DAMAGE

/datum/component/necromorph/proc/on_oxygen_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_OXY_DAMAGE

/datum/component/necromorph/proc/on_tox_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_TOX_DAMAGE

/datum/component/necromorph/proc/on_clone_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_CLONE_DAMAGE

/datum/component/necromorph/proc/on_fire_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_FIRE_DAMAGE

/datum/component/necromorph/proc/on_brute_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_BRUTE_DAMAGE

/datum/component/necromorph/proc/on_halo_damage(mob/living/carbon/human/zombie, amount)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_HALO_DAMAGE

/datum/component/necromorph/proc/on_update_health(mob/living/carbon/human/zombie)
	SIGNAL_HANDLER
	return COMSIG_LIVING_HEALTH_UPDATE_GOD_MODE

/datum/component/necromorph/proc/on_apply_effect(mob/living/carbon/human/zombie)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_EFFECT

/datum/component/necromorph/proc/on_electrocute(mob/living/carbon/human/zombie, shock_damage, source, siemens_coeff, def_zone, stun)
	SIGNAL_HANDLER
	return COMPONENT_CARBON_CANCEL_ELECTROCUTE

/datum/component/necromorph/proc/embed_check(mob/living/carbon/human/zombie)
	SIGNAL_HANDLER
	return COMSIG_CANCEL_EMBED

/datum/component/necromorph/proc/on_emp(mob/living/carbon/human/zombie, severity)
	SIGNAL_HANDLER
	return COMPONENT_BLOCK_EMP

/datum/component/necromorph/proc/godmode_check(mob/living/carbon/human/zombie)
	SIGNAL_HANDLER
	return COMSIG_GODMODE_CANCEL
