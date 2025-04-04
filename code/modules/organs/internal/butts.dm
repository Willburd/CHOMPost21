/obj/item/organ/internal/butt
	name = "butt"
	icon_state = "butt"
	icon = 'modular_chomp/icons/obj/surgery_op.dmi'
	desc = "It jiggles like jello when you shake it."
	gender = PLURAL
	organ_tag = O_BUTT
	parent_organ = BP_GROIN
	decays = FALSE
	butcherable = TRUE
	var/allowcolor = TRUE
	var/structural_integrity = 100
	var/safety_system = TRUE

/obj/item/organ/internal/butt/set_dna(var/datum/dna/new_dna)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(!owner || !istype(H) || !isnull(H.species.greater_form)) // Kinda hacky monkey check
		desc = initial(desc) + " How vulgar!"
		if(allowcolor)
			color = "#f1acac"
	else
		desc = initial(desc) + " It looks like it might be [owner.real_name]'s."
		if(allowcolor)
			color = rgb(H.r_skin, H.g_skin, H.b_skin)

/obj/item/organ/internal/butt/robotize()
	. = ..()
	allowcolor = FALSE
	color = null

/obj/item/organ/internal/butt/proc/can_super_fart()
	if(robotic >= ORGAN_ASSISTED)
		return safety_system
	return TRUE

/obj/item/organ/internal/butt/emag_act(remaining_charges, mob/user, emag_source)
	if(robotic < ORGAN_ASSISTED)
		return FALSE
	if(safety_system)
		safety_system = FALSE
		to_chat(user, "You break the pressure safety system of \the [src].")
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(2, 1, src)
		s.start()
		playsound(src, 'sound/machines/defib_charge.ogg', 50, 0) // beep boop
		visible_message(span_warning("BZZzZZzZZzZT"))
	return TRUE

/obj/item/organ/internal/butt/proc/assblasted(mob/living/user,var/fling = FALSE)
	// wizard spells, super fart
	structural_integrity = 0 // If they get it reattached, their next toot will be their last! Nyeheheheh!
	removed(user)
	if(fling)
		throw_at_random( FALSE, 4, 3)

/obj/item/organ/internal/butt/robot
	name = "Hydraulic Butt"
	desc = "The pinnacle of robuttics engineering"
	allowcolor = FALSE

/obj/item/organ/internal/butt/robot/Initialize(mapload, internal)
	. = ..()
	robotize()

/obj/item/organ/internal/butt/assisted
	name = "Assisted Butt"
	desc = "A butt with an implant commonly refered to as 'the third cheek.'"

/obj/item/organ/internal/butt/assisted/Initialize(mapload, internal)
	. = ..()
	mechassist()
