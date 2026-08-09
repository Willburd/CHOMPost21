GLOBAL_LIST_EMPTY(lawset_implants)

/obj/item/implant/lawset
	name = "lawset implant"
	desc = "A heavily regulated version of a compliance implant, designed to work with AI lawset systems. Warning: Removal from host may result in unpredictable behavior."
	icon_state = "implant"
	known_implant = TRUE
	var/datum/ai_laws/laws

/obj/item/implant/lawset/Initialize(mapload)
	laws = new using_map.default_law_type
	GLOB.lawset_implants += src
	. = ..()

/obj/item/implant/lawset/Destroy()
	if(part)
		remove_verb(get_host(), /mob/living/carbon/human/proc/state_implant_laws)
	GLOB.lawset_implants -= src
	QDEL_NULL(laws)
	. = ..()

/obj/item/implant/lawset/islegal()
	return TRUE

/obj/item/implant/lawset/proc/get_host()
	var/obj/item/organ/external/part = loc
	if(istype(part))
		return part.owner
	return null


//////////////////////////////////////////////////////////////////////////
// Law Management
//////////////////////////////////////////////////////////////////////////
/mob/living/carbon/human/proc/state_implant_laws()
	set category = "Abilities.General"
	set name = "State Laws"

	for(var/obj/item/implant/lawset/implant in GLOB.lawset_implants)
		if(implant.get_host() == src)
			implant.state_implant_laws()
			return
	// Somehow none of these were ours, remove the bad verb...
	remove_verb(src, /mob/living/carbon/human/proc/state_implant_laws)

/obj/item/implant/lawset/post_implant(mob/source, mob/living/user = usr)
	notify_of_law_change()
	var/mob/living/carbon/human/target = get_host()
	if(!ishuman(target))
		return
	add_verb(target, /mob/living/carbon/human/proc/state_implant_laws)

/obj/item/implant/lawset/proc/get_law_string()
	var/endstr = ""
	for(var/datum/ai_law/law in laws.laws_to_state())
		endstr += "[law.get_index()]. [law.law]<br>"
	return endstr

/obj/item/implant/lawset/proc/state_implant_laws()
	var/mob/living/carbon/human/target = get_host()
	if(!ishuman(target))
		return
	spawn(0) // Don't lock up MC
		target.direct_say("Current Active Laws:")
		for(var/datum/ai_law/law in laws.laws_to_state())
			if(!target.direct_say("[law.get_index()]. [law.law]"))
				break
			sleep(1 SECOND)

/obj/item/implant/lawset/get_data()
	var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b>Lawset Implant<BR>
<b>Life:</b>Until removal<BR>
<HR>
<b>Function:</b> A heavily regulated version of a compliance implant, designed to work with AI lawset systems. Warning: Removal from host may result in unpredictable behavior.<BR>
<HR>
<b>Set Laws:</b><br>[get_law_string()]"}
	return dat

// hack : Type casting abuse
/obj/item/implant/lawset/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/aiModule))
		var/obj/item/aiModule/module = I
		if(module.laws)
			module.laws.sync(src, TRUE)
		module.addAdditionalLaws(src, user)
		return
	. = ..()

/obj/item/implant/lawset/proc/notify_of_law_change()
	show_laws()

/obj/item/implant/lawset/proc/show_laws()
	var/mob/living/carbon/human/target = get_host()
	if(!ishuman(target))
		return
	var/law_string = get_law_string()
	to_chat(target, span_danger("Your laws have been updated:<br> [law_string]"))

/obj/item/implant/lawset/proc/sync_zeroth(datum/ai_law/zeroth_law, datum/ai_law/zeroth_law_borg)
	if(zeroth_law_borg)
		laws.set_zeroth_law(zeroth_law_borg.law)
	else if(zeroth_law)
		laws.set_zeroth_law(zeroth_law.law)

/obj/item/implant/lawset/proc/add_supplied_law(number, law, notify = TRUE)
	laws.add_supplied_law(number, law)
