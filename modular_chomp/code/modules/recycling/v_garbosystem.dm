/obj/machinery/v_garbosystem
	icon = 'modular_chomp/icons/obj/machines/other.dmi'
	icon_state = "cronchy_off"
	name = "garbage grinder"
	desc = "Mind your fingers. Filter access hatch can be opened with crowbar to release trapped contents within."
	plane = TURF_PLANE
	layer = ABOVE_TURF_LAYER
	anchored = TRUE
	idle_power_usage = 5
	active_power_usage = 100
	var/operating = FALSE
	var/obj/machinery/recycling/crusher/crusher //Connects to regular crusher
	var/obj/vehicle/train/trolly_tank/sump //Reagent trap for extraction and sorting
	var/obj/machinery/button/garbosystem/button
	var/list/affecting
	var/voracity = 5 //How much stuff is swallowed at once.

/obj/machinery/v_garbosystem/Initialize()
	. = ..()
	for(var/dir in cardinal)
		src.crusher = locate(/obj/machinery/recycling/crusher, get_step(src, dir))
		if(src.crusher)
			crusher.hand_fed = FALSE
			break
	for(var/dir in cardinal)
		src.button = locate(/obj/machinery/button/garbosystem, get_step(src, dir))
		if(src.button)
			button.grinder = src
			break
	return

/obj/machinery/v_garbosystem/attack_hand(mob/living/user as mob)
	operating = !operating
	validate_tank() // Outpost 21 edit - attaching vehicle tanks
	update()

/obj/machinery/v_garbosystem/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/v_garbosystem/power_change()
	if((. = ..()))
		update()

/obj/machinery/v_garbosystem/proc/update()
	if(stat & (BROKEN | NOPOWER))
		operating = FALSE
		update_use_power(USE_POWER_OFF)
		return
	if(!operating)
		update_use_power(USE_POWER_OFF)
		return
	icon_state = "cronchy_active"
	START_MACHINE_PROCESSING(src)
	update_use_power(USE_POWER_ACTIVE)

/obj/machinery/v_garbosystem/process()
	if(!operating || !crusher || crusher.stat & (NOPOWER|BROKEN))
		icon_state = "cronchy_off"
		return PROCESS_KILL
	if(stat & (BROKEN | NOPOWER))
		icon_state = "cronchy_off"
		return PROCESS_KILL
	icon_state = "cronchy_active"

	affecting = loc.contents - src
	spawn(1)
		var/items_taken = 0
		for(var/atom/movable/A in affecting)
			if(!isobj(A) && !isliving(A))
				continue
			if(istype(A, /obj/effect/decal/cleanable) || istype(A, /mob/living/voice))
				qdel(A)
			if(!A.anchored)
				if(A.loc == src.loc)
					if(isliving(A))
						var/mob/living/L = A
						if(!emagged && ishuman(L) && L.mind)
							playsound(src, 'sound/machines/warning-buzzer.ogg', 50, 0, 0)
							visible_message(span_warning("POSSIBLE CREW MEMBER DETECTED! EMERGENCY STOP ENGAGED!"))
							global_announcer.autosay("Possible crew member detected in grinder feed. Emergency Stop Protocols engaged!", "Recycling Grinder Alert", "Supply")
							operating = FALSE
							update()
							break
						if(L.stat == DEAD)
							playsound(src, 'sound/effects/splat.ogg', 50, 1)
							L.gib()
							items_taken++
							// Outpost 21 addition begin - Sludge production, bodily transfers
							transfer_organic_to_tank(5)
							if(ishuman(L))
								// Splorch
								var/mob/living/carbon/human/H = L
								transfer_reagent_to_tank(H.bloodstr,1)
								transfer_reagent_to_tank(H.ingested,1)
								transfer_reagent_to_tank(H.vessel,0.5)
							// Outpost 21 addition end
						else
							L.adjustBruteLoss(25)
							items_taken++
							break
					for(var/atom/movable/C in A.contents)
						if(C.anchored)
							C.anchored = FALSE
						C.forceMove(loc)
					if(isitem(A))
						A.SpinAnimation(5,3)
						spawn(15)
							if(A.loc == loc)
								// Outpost 21 addition begin - Allow reagent extraction
								if(A.reagents)
									transfer_reagent_to_tank(A.reagents,1)
								// Outpost 21 addition end
								// Outpost 21 addition begin - Ores grind to reagents
								if(istype(A,/obj/item/ore))
									transfer_ore_to_tank(A,1)
								// Outpost 21 addition end
								A.forceMove(src)
								if(!is_type_in_list(A,item_digestion_blacklist))
									crusher.take_item(A) //Force feed the poor bastard.
						items_taken++
					else
						A.SpinAnimation(5,3)
						spawn(15)
							if(A)
								A.forceMove(src)
								// Outpost 21 addition begin - Allow reagent extraction
								if(A.reagents)
									transfer_reagent_to_tank(A.reagents,1)
								// Outpost 21 addition end
								if(istype(A, /obj/structure/closet))
									new /obj/item/stack/material/steel(loc, 2)
								qdel(A)
						items_taken++
			if(items_taken >= voracity)
				break
		if(items_taken) //Lazy coder sound design moment.
			GLOB.Recycled_Items = GLOB.Recycled_Items + items_taken
			playsound(src, 'sound/items/poster_being_created.ogg', 50, 1)
			playsound(src, 'sound/items/electronic_assembly_emptying.ogg', 50, 1)
			playsound(src, 'sound/effects/metalscrape2.ogg', 50, 1)

/obj/machinery/v_garbosystem/emag_act(var/remaining_charges, var/mob/user, var/emag_source)
	emagged = !emagged
	update()

/obj/machinery/v_garbosystem/attackby(obj/item/W as obj, mob/user as mob)
	if(W.is_crowbar())
		if(!operating)
			to_chat(user, "You crowbar the filter hatch open, releasing the items trapped within.")
			for(var/atom/movable/A in contents)
				A.forceMove(loc)
			return
		else
			to_chat(user, "Unable to empty filter while the machine is running.")
	return ..()

// Outpost 21 edit begin - transfering fluids to vehicle tanks
/obj/machinery/v_garbosystem/proc/transfer_reagent_to_tank(var/datum/reagents/reg,var/multiplier)
	if(!validate_tank())
		return
	var/volume_magic = reg.total_volume * multiplier
	volume_magic -= rand(2,10) // reagent tax
	if(volume_magic > 0)
		reg.trans_to_holder( sump.reagents, volume_magic)
		transfer_sludge_to_tank(rand(1,5))
	sump.update_icon()

/obj/machinery/v_garbosystem/proc/transfer_ore_to_tank(var/obj/item/ore/R,var/multiplier)
	if(!validate_tank())
		return
	if(global.ore_reagents[R.type])
		var/list/ore_components = global.ore_reagents[R.type]
		if(islist(ore_components))
			var/amount_to_take = (REAGENTS_PER_ORE/(ore_components.len))
			for(var/i in ore_components)
				sump.reagents.add_reagent(i, amount_to_take * multiplier)
		else
			sump.reagents.add_reagent(ore_components, REAGENTS_PER_ORE * multiplier)
		transfer_sludge_to_tank(rand(1,5))
	sump.update_icon()

/obj/machinery/v_garbosystem/proc/transfer_organic_to_tank(var/amt)
	if(!validate_tank())
		return
	var/ratioA = FLOOR(amt*0.2,1)
	var/ratioB = FLOOR(amt*0.8,1)
	if(ratioA > 0)
		sump.reagents.add_reagent("protein", ratioA)
	if(ratioB > 0)
		sump.reagents.add_reagent("triglyceride", ratioB)
	if(ratioB > 0 || ratioA > 0)
		transfer_sludge_to_tank(rand(4,9))
	sump.update_icon()

/obj/machinery/v_garbosystem/proc/transfer_sludge_to_tank(var/amt)
	if(prob(10) || amt >= 5)
		sump.reagents.add_reagent("toxin",amt)
		visible_message("\The [src] gurgles.")

/obj/machinery/v_garbosystem/proc/validate_tank()
	if(!sump)
		return link_grinder()
	var/turf/T = loc
	if(!T.AdjacentQuick(sump))
		return link_grinder()
	return TRUE

/obj/machinery/v_garbosystem/proc/link_grinder()
	// Link to vehicle fluid tanker
	var/sump_prev = sump
	sump = locate(/obj/vehicle/train/trolly_tank) in loc.contents
	if(!sump)
		for(var/dir in alldirs)
			sump = locate(/obj/vehicle/train/trolly_tank, get_step(src, dir))
			if(sump)
				break
	if(!isnull(sump) && sump_prev != sump)
		visible_message("\The [src] automatically connects a hose to \the [sump].")
		return
// Outpost 21 edit end

/obj/machinery/button/garbosystem
	name = "garbage grinder switch"
	desc = "A power button for the big grinder."
	icon = 'icons/obj/machines/doorbell_vr.dmi'
	icon_state = "doorbell-standby"
	var/obj/machinery/v_garbosystem/grinder

/obj/machinery/button/garbosystem/attack_hand(mob/living/user as mob)
	if(grinder)
		return grinder.attack_hand(user)

GLOBAL_VAR_INIT(Recycled_Items, 0)
