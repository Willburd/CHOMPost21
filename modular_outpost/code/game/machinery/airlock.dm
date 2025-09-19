/obj/machinery/door/airlock
	var/obj/item/airlock_brace/brace = null

/obj/machinery/door/airlock/Initialize(mapload, obj/structure/door_assembly/assembly)
	. = ..()

	// Airlock brace
	var/obj/item/airlock_brace/B = locate(/obj/item/airlock_brace) in loc
	if(!brace && B)
		B.lock_brace(src)

	// Maint breaks airlocks sometimes
	if(istype(get_area(src),/area/maintenance))
		// Break wires
		if(prob(10))
			wires.cut(pick(list(WIRE_ELECTRIFY, WIRE_IDSCAN, WIRE_MAIN_POWER1, WIRE_MAIN_POWER2, WIRE_DOOR_BOLTS, WIRE_SAFETY, WIRE_SPEED, WIRE_AI_CONTROL)))
		if(prob(5))
			wires.cut(pick(list(WIRE_ELECTRIFY, WIRE_IDSCAN, WIRE_MAIN_POWER1, WIRE_MAIN_POWER2, WIRE_DOOR_BOLTS, WIRE_SAFETY, WIRE_SPEED, WIRE_AI_CONTROL)))
		if(prob(2))
			wires.cut(pick(list(WIRE_ELECTRIFY, WIRE_IDSCAN, WIRE_MAIN_POWER1, WIRE_MAIN_POWER2, WIRE_DOOR_BOLTS, WIRE_SAFETY, WIRE_SPEED, WIRE_AI_CONTROL)))
		// Other issues
		if(prob(3))
			p_open = TRUE
		else if(prob(2))
			welded = TRUE


/obj/machinery/door/airlock/attackby(obj/item/C, mob/user as mob)
	if(brace)
		if(istype(C, /obj/item/tool/crowbar/brace_jack) && user.a_intent == I_HELP) // Pry off with help
			return brace.attackby(C, user)

	if(!brace && istype(C, /obj/item/airlock_brace))
		var/obj/item/airlock_brace/A = C
		if(!density)
			to_chat(user, span_warning("You must close \the [src] before installing \the [A]!"))
			return

		playsound(user, 'sound/machines/lockreset.ogg', 50, 1) // pulling doorjack down!
		if(do_after(user, 6 SECONDS, target = src) && density && A && user.unEquip(A, src))
			to_chat(user, span_notice("You successfully install \the [A]."))
			A.lock_brace(src)
		return

	. = ..()

/obj/machinery/door/airlock/can_open(var/forced=0)
	if(brace)
		return FALSE
	. = ..()

/obj/machinery/door/airlock/user_toggle_open(mob/user)
	if(brace)
		to_chat(user, span_warning(text("The airlock's brace holds it firmly in place.")))
		return FALSE
	. = ..()

/obj/machinery/door/airlock/take_damage(var/damage)
	if(brace)
		brace.cur_health = clamp(brace.cur_health - damage, 0, brace.max_health)
		if(brace.cur_health <= 0)
			var/obj/item/airlock_brace/braceTemp = brace // store the brace reference so it can be deleted after
			visible_message(span_danger(text("\The [braceTemp] is smashed off of the airlock!")))
			braceTemp.unlock_brace(null)
			qdel(braceTemp)
		return
	. = ..(damage)

/obj/machinery/door/airlock/examine(mob/user)
	. = ..()
	if(brace)
		. += span_danger(text("A [brace] is installed on the airlock, preventing it from opening."))
		. += brace.examine_health()
