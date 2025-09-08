/datum/element/headbonk
	var/bonk_chance = 1

/datum/element/headbonk/Attach(atom/target)
	. = ..()
	if(!isobj(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_MOVABLE_CROSS, PROC_REF(headbonk))

/datum/element/headbonk/Detach(atom/target)
	. = ..()
	UnregisterSignal(target, COMSIG_MOVABLE_CROSS)

/datum/element/headbonk/proc/headbonk(atom/source,atom/movable/AM)
	SIGNAL_HANDLER
	// Chance to bonk is handled by parent call!
	SHOULD_CALL_PARENT(TRUE)
	if(!isliving(AM))
		return FALSE
	if(!prob(bonk_chance))
		return FALSE
	return TRUE

/datum/element/headbonk/proc/clonk(atom/source,var/mob/living/M)
	playsound(source,'sound/effects/clang1.ogg')
	playsound(source,"punch")
	M.visible_message(span_danger("\The [M] bonks their head into \the [source]!"))
	M.Stun(5)
	M.Weaken(5)
	M.apply_damage(rand(1,3),BRUTE,BP_HEAD)

/// Subtypes
/datum/element/headbonk/railing/headbonk(atom/source,atom/movable/AM)
	if(!..(source,AM))
		return
	var/obj/structure/railing/R = source
	var/mob/M = AM
	if(M.m_intent == I_WALK)
		return // Safe to walk into
	if(M.size_multiplier <= (RESIZE_MINIMUM + 0.25))
		return // No bonk
	if(M.mob_size <= MOB_TINY)
		return // No bonk on minis
	if(!M.checkpass(PASSTABLE))
		return // Climbed over
	if(!R.anchored)
		return // Can't bonk this
	if(M.loc != get_step(R,R.dir))
		return // Not passing onto it from blocking dir
	clonk(source,M)

/datum/element/headbonk/table/headbonk(atom/source,atom/movable/AM)
	if(!..(source,AM))
		return
	var/obj/structure/table/T = source
	var/mob/M = AM
	if(M.m_intent == I_WALK)
		return // Safe to walk into
	if(M.size_multiplier <= (RESIZE_MINIMUM + 0.25))
		return // No bonk
	if(M.mob_size <= MOB_TINY)
		return // No bonk on minis
	if(!M.checkpass(PASSTABLE))
		return // Climbed over
	if(T.flipped)
		return // Can't bonk a flipped table
	// Check that we are not climb over tables already
	var/obj/structure/table/table = locate(/obj/structure/table) in get_turf(M)
	if(table && !table.flipped)
		return // Crawling from another table
	clonk(source,M)
	if(prob(60))
		T.flip(M.dir)

/datum/element/headbonk/door/headbonk(atom/source,atom/movable/AM)
	if(!..(source,AM))
		return
	var/mob/M = AM
	if(M.m_intent == I_WALK)
		return // Safe to walk into
	if(M.size_multiplier <= (RESIZE_MAXIMUM - 0.1))
		return // No bonk
	// This one is just simple and silly
	clonk(source,M)
