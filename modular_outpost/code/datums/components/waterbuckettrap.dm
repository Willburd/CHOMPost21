/datum/component/waterbuckettrap
	var/activated = FALSE
	var/obj/host
	var/obj/item/reagent_containers/glass/bucket/bucket

/datum/component/waterbuckettrap/Initialize(obj/item/reagent_containers/glass/bucket/G)
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent
	bucket = G

/datum/component/waterbuckettrap/Destroy(force = FALSE)
	. = ..()
	host = null
	qdel(bucket)
	bucket = null

/datum/component/waterbuckettrap/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attackhand))
	RegisterSignal(parent, COMSIG_ATOM_BUMPED, PROC_REF(on_bumped))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(trigger_trap))

/datum/component/waterbuckettrap/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_ATTACKBY)
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(parent, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(parent, COMSIG_ATOM_BUMPED)
	UnregisterSignal(parent, COMSIG_QDELETING)


// Signal handlers
//////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/component/waterbuckettrap/proc/on_attackhand(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/waterbuckettrap/proc/on_attackby(obj/item/source, obj/item/W, mob/user, params)
	SIGNAL_HANDLER
	if(!bucket)
		return
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/waterbuckettrap/proc/on_bumped(datum/source, atom/A)
	SIGNAL_HANDLER
	if(HAS_TRAIT(A, TRAIT_AMBIENT_PEST_MOB)) // Miniture things don't set off the trap
		return
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/waterbuckettrap/proc/on_examine(datum/source, mob/user, list/examine_texts)
	SIGNAL_HANDLER
	var/turf/T = get_turf(host)
	if(T.Adjacent(get_turf(user)))
		examine_texts += span_danger("A [bucket] is tapped to it.")

/datum/component/waterbuckettrap/proc/trigger_trap()
	SIGNAL_HANDLER
	if(!bucket) // Somehow it deleted?
		qdel(src)
		return
	var/turf/T = get_turf(host)
	T.visible_message(span_danger("A [bucket] drops off \the [host]!"),span_danger("CLUNK!"))
	for(var/mob/living/L in range(1, get_turf(host))) // Splash the nearest mob to us
		if(bucket.reagents.total_volume > 0)
			bucket.reagents.splash(L, bucket.reagents.total_volume)
			L.balloon_alert_visible("\The [bucket]'s contents splashes onto \the [L]!")
			playsound(src, 'sound/effects/footstep/water2.ogg', 95, 1)
		T = get_turf(L) // update to drop onto the mob
		break
	if(bucket.reagents.total_volume > 0) // If we missed the mob, just splash the turf of the door
		bucket.reagents.splash(T, bucket.reagents.total_volume)
	if(bucket.drop_sound)
		playsound(src, bucket.drop_sound, 95, 1)
	bucket.forceMove(T)
	bucket = null
	qdel(src)

// Helper procs
//////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/proc/attach_waterbucket_trap(mob/user, obj/item/reagent_containers/glass/bucket/bucket)
	var/datum/component/waterbuckettrap/GT = GetComponent(/datum/component/waterbuckettrap)
	if(GT)
		to_chat(user, span_warning("There is already a [GT.bucket] tapped to \the [src]!"))
		return
	if(!istype(user.get_inactive_hand(), /obj/item/tape_roll))
		to_chat(user, span_warning("You need some tape to attach \the [bucket] to \the [src]!"))
		return
	to_chat(user, span_notice("You begin to carefully tape \the [bucket] to \the [src]..."))
	if(do_after(user, 2 SECONDS, target = src))
		user.drop_from_inventory(bucket,src)
		AddComponent(/datum/component/waterbuckettrap, bucket)
		to_chat(user, span_notice("You finish taping \the [bucket] to \the [src]."))

// Hook
/obj/machinery/door/airlock/attackby(obj/item/C, mob/user)
	if(istype(C,/obj/item/reagent_containers/glass/bucket))
		attach_waterbucket_trap(user, C)
		return TRUE

	var/datum/component/waterbuckettrap/GT = GetComponent(/datum/component/waterbuckettrap)
	if(GT && C.has_tool_quality(TOOL_WIRECUTTER))
		playsound(src, C.usesound, 50, 1)
		to_chat(user, span_warning("You take \the [GT.bucket] down from \the [src]."))
		GT.bucket.forceMove(get_turf(user))
		GT.bucket = null
		qdel(GT)
		return TRUE

	. = ..()
