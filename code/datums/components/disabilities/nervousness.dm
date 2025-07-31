/datum/component/nervousness_disability
	var/mob/owner

/datum/component/nervousness_disability/Initialize()
	if (!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	owner = parent
	RegisterSignal(owner, COMSIG_HANDLE_DISABILITIES, PROC_REF(process_component))

/datum/component/nervousness_disability/proc/process_component()
	if(QDELETED(parent))
		return
	if(isbelly(owner.loc))
		return
	if(owner.stat != CONSCIOUS)
		return
	if(owner.anxietymedcount == 1) // Outpost 21 edit - Medications calm disabilities, yes this is meant to be == 1
		return
	if(owner.transforming)
		return
	if(prob(5) && prob(7))
		owner.stuttering = max(15, owner.stuttering)
		if(owner.get_jittery() < 50)
			owner.make_jittery(65)

/datum/component/nervousness_disability/Destroy(force = FALSE)
	UnregisterSignal(owner, COMSIG_HANDLE_DISABILITIES)
	owner = null
	. = ..()
