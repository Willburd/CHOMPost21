/datum/element/hiccups
	var/cure_chance = 3
	var/hiccup_chance = 7

/datum/element/hiccups/Attach(atom/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_LIVING_LIFE, PROC_REF(handle_life))
	hiccup(target)

/datum/element/hiccups/Detach(atom/target)
	. = ..()
	UnregisterSignal(target, COMSIG_LIVING_LIFE)

/datum/element/hiccups/proc/handle_life(mob/source)
	SHOULD_CALL_PARENT(TRUE)
	PROTECTED_PROC(TRUE)
	SIGNAL_HANDLER

	if(prob(cure_chance) || source.stat == DEAD)
		source.RemoveElement(/datum/element/hiccups)
		return

	if(prob(hiccup_chance))
		hiccup(source)

/datum/element/hiccups/proc/hiccup(mob/source)
	source.automatic_custom_emote(AUDIBLE_MESSAGE,"hiccups", check_stat = TRUE)
