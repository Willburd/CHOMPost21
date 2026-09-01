//Sprite from SS14 Main. Sprited by Orsoniks (rivey0 on discord)
// OP21: If you port this upstream to virgo, please do it properly with the dmi sprites moved to the correct files. This is a hackjob to avoid editing upstream dmis.
/obj/item/toy/plushie/expie
	name = "Experiment Plushie"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "expie"
	desc = "A plushie of a canid of sorts. It yearns to be detonated on a landmine."
	default_worn_icon = 'modular_zubbers/icons/mob/inhands/items/plushes_hand.dmi'
	attack_verb = list("bark", "growl", "whine")
	squeeze_sound = 'sound/voice/bork.ogg'
	pokephrase = "Bark!"
	slot_flags = SLOT_HEAD

/obj/item/toy/plushie/expie/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_REAGENT_EXPOSE_OBJ, PROC_REF(reagent_splashed))
	update_icon()

/obj/item/toy/plushie/expie/Destroy()
	UnregisterSignal(src, COMSIG_REAGENT_EXPOSE_OBJ)
	. = ..()

/obj/item/toy/plushie/expie/update_icon()
	. = ..()
	item_state_slots = list(slot_r_hand_str = "[icon_state]_R", slot_l_hand_str = "[icon_state]_L", slot_head_str = "[icon_state]_H") // Hacky

/obj/item/toy/plushie/expie/proc/reagent_splashed(datum/source, datum/reagent/reagent, amount) //spill milk on the expie to make it milky
	if(istype(src,/obj/item/toy/plushie/expie/milky))
		return
	if(reagent.id != REAGENT_ID_MILK)
		return
	name = /obj/item/toy/plushie/expie/milky::name
	desc = /obj/item/toy/plushie/expie/milky::desc
	icon_state = /obj/item/toy/plushie/expie/milky::icon_state
	update_icon()

/obj/item/toy/plushie/expie/milky
	name = "Milky Plushie"
	desc = "A plushie of snowy-white, furred canid. Maybe it'll trade something with you?"
	icon_state = "milky"
