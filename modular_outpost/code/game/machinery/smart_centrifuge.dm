/obj/machinery/smart_centrifuge
	name = "smart centrifuge"
	desc = "Isolates various compounds and stores them in chemical cartridges."
	icon = 'icons/obj/hydroponics_machines_vr.dmi' //VOREStation Edit
	icon_state = "sextractor"
	density = TRUE
	anchored = TRUE
	circuit = /obj/item/weapon/circuitboard/smart_centrifuge

	var/working = FALSE

/obj/machinery/smart_centrifuge/Initialize()
	. = ..()
	// TODO - Remove this bit once machines are converted to Initialize
	if(ispath(circuit))
		circuit = new circuit(src)
	create_reagents(5000)
	flags |= OPENCONTAINER
	default_apply_parts()

/obj/machinery/smart_centrifuge/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(in_use)
		to_chat(user, "<span class='notice'>\The [src] is still spinning.</span>")
		return
	if(O.has_tool_quality(TOOL_CROWBAR))
		return dismantle()
	if(default_unfasten_wrench(user, O, 20))
		return
	return ..()

/obj/machinery/smart_centrifuge/attack_hand(mob/user)
	if(working)
		to_chat(user, "<span class='notice'>\The [src] is still spinning.</span>")
		return
	else if(reagents.reagent_list.len == 0)
		to_chat(user, "<span class='notice'>\The [src] is empty.</span>")
		return
	else
		playsound(src, 'sound/machines/buttonbeep.ogg', 50, 1)
		playsound(src, 'sound/machines/airpumpidle.ogg', 100, 1)
		to_chat(user, "<span class='notice'>You activate \the [src].</span>")
		working = TRUE
		flags ^= OPENCONTAINER
		spawn(200) // Do it itself
			while(reagents.reagent_list.len > 0)
				for(var/datum/reagent/RL in reagents.reagent_list)
					if(RL.volume > 0)
						// Lets solve how much we need to drain into the container...
						var/obj/item/weapon/reagent_containers/chem_disp_cartridge/CD = new(src)
						var/remain_vol = RL.volume - CD.reagents.maximum_volume
						if(remain_vol < 0)
							remain_vol = 0
						var/trans_vol = RL.volume - remain_vol
						// Transfer if possible
						if(trans_vol > 0)
							playsound(src, 'sound/machines/reagent_dispense.ogg', 25, 1)
							CD.reagents.add_reagent( RL.id, trans_vol, RL.data, FALSE)
							reagents.remove_reagent( RL.id, trans_vol, FALSE )
							// Lets finish by naming it
							CD.setLabel(RL.name)
							CD.forceMove(loc) // Drop it outside
							sleep(30)
						else
							qdel(CD) // Nah.. nothing...
			sleep(10)
			visible_message("\The [src] finishes processing.")
			playsound(src, 'sound/machines/biogenerator_end.ogg', 50, 1)
			playsound(src, 'sound/machines/buttonbeep.ogg', 50, 1)
			working = FALSE
			flags |= OPENCONTAINER

/obj/machinery/smart_centrifuge/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || !user.Adjacent(C) || !istype(C) || (user == C && !user.canmove))
		return
	if(istype(C,/obj/vehicle/train/trolly_tank))
		// Drain it!
		C.reagents.trans_to_holder( src.reagents, src.reagents.maximum_volume)
		visible_message("\The [user] drains \the [C] into \the [src].")
		return
	. = ..()
