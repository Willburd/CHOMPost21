/datum/component/grenadetrap
	var/activated = FALSE
	var/obj/host
	var/obj/item/grenade/nade

/datum/component/grenadetrap/Initialize(var/obj/item/grenade/G)
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent
	nade = G
	RegisterSignal(host, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(host, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(host, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attackhand))
	RegisterSignal(host, COMSIG_ATOM_BUMPED, PROC_REF(on_bumped))
	RegisterSignal(host, COMSIG_QDELETING, PROC_REF(trigger_trap))

/datum/component/grenadetrap/Destroy(force = FALSE)
	UnregisterSignal(host, COMSIG_ATOM_ATTACKBY)
	UnregisterSignal(host, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(host, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(host, COMSIG_ATOM_BUMPED)
	UnregisterSignal(host, COMSIG_QDELETING)
	host = null
	qdel(nade)
	nade = null
	. = ..()

// Signal handlers
//////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/component/grenadetrap/proc/on_attackhand(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/grenadetrap/proc/on_attackby(obj/item/source, obj/item/W, mob/user, params)
	SIGNAL_HANDLER
	if(!nade)
		return
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/grenadetrap/proc/on_bumped(datum/source, atom/A)
	SIGNAL_HANDLER
	if(activated)
		return
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(trigger_trap)), 0.5 SECOND, TIMER_DELETE_ME)

/datum/component/grenadetrap/proc/on_examine(datum/source, mob/user, list/examine_texts)
	SIGNAL_HANDLER
	var/turf/T = get_turf(host)
	if(T.Adjacent(get_turf(user)))
		examine_texts += span_danger("A [nade] is rigged to it.")

/datum/component/grenadetrap/proc/trigger_trap()
	SIGNAL_HANDLER
	if(!nade) // Somehow it deleted?
		qdel(src)
		return
	var/turf/T = get_turf(host)
	playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 95, 1)
	T.visible_message(span_danger("A [nade] drops out of \the [host]!"),span_danger("CLUNK!"))
	nade.forceMove(T)
	nade.det_time = 1.2 SECONDS
	nade.activate()
	nade = null
	qdel(src)

// Helper procs
//////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/proc/attach_grenade_trap(mob/user,var/obj/item/grenade/nade)
	var/datum/component/grenadetrap/GT = GetComponent(/datum/component/grenadetrap)
	if(GT)
		to_chat(user, span_warning("There is already a [GT.nade] rigged to \the [src]!"))
		return
	if(nade.active)
		to_chat(user, span_vdanger("OH SHIT!"))
		return
	to_chat(user, span_danger("You begin to carefully rig \the [nade] to \the [src]..."))
	if(do_after(user, 2 SECONDS, target = src))
		if(nade.active)
			return
		user.drop_from_inventory(nade,src)
		AddComponent(/datum/component/grenadetrap,nade)
		to_chat(user, span_notice("You finish rigging \the [src]."))
	else
		to_chat(user, span_vdanger("\The [nade] slips and goes off!"))
		nade.det_time = 1.2 SECONDS
		nade.activate()

// Nade hook
/obj/machinery/door/airlock/attackby(obj/item/C, mob/user)
	if(istype(C,/obj/item/grenade))
		var/obj/item/grenade/G = C
		if(isElectrified())
			G.detonate()
		else
			attach_grenade_trap(user,G)
		return TRUE

	var/datum/component/grenadetrap/GT = GetComponent(/datum/component/grenadetrap) // Awaiting upstream fix, fucking door code
	if(GT && C.has_tool_quality(TOOL_WIRECUTTER))
		playsound(src, C.usesound, 50, 1)
		to_chat(user, span_warning("You cut the trap from \the [src]."))
		GT.nade.forceMove(get_turf(user))
		GT.nade = null
		qdel(GT)
		return TRUE

	. = ..()
