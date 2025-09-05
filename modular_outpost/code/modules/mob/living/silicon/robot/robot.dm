/mob/living/silicon/robot
	var/haunted = FALSE

/mob/living/silicon/robot/proc/update_haunt(var/assign_law = FALSE)
	if(istype(src,/mob/living/silicon/robot/ai_shell) || istype(src,/mob/living/silicon/robot/drone))
		return
	if(assign_law) // we add a timer to callback this proc with assign_law as true, instead of having two haunting procs
		SShaunting.influence(HAUNTING_GHOSTS)
		to_chat(src, "<span class='danger'>You have detected a change in your laws information:</span>")
		var/law = generate_screech_law()
		add_ion_law(law)
		show_laws()
		haunted = TRUE // If you were not already you are now, just incase proc call is used.
		return
	if(haunted)
		return
	// Check if we're in the SPOOKYZONE, this should fail a majority of the time to prevent camping for laws
	var/area/A = get_area(src)
	if(prob(99) || !A || !A.haunted)
		return
	if(A.haunted && client && !away_from_keyboard && prob(2))
		SShaunting.influence(HAUNTING_GHOSTS)
		SShaunting.get_world_haunt_attention(src,20)
	// Make it unclear that the area CAUSED it by delaying it a significant amount of time
	addtimer(CALLBACK(src, PROC_REF(update_haunt), TRUE), rand(5 MINUTES, 25 MINUTES), TIMER_DELETE_ME)
	haunted = TRUE

// Technically the crew monitor exists, but this helps you learn the station easier
/mob/living/silicon/robot/verb/current_location()
	set category = "Abilities.Silicon"
	set name = "Display Location Name"
	var/area/A = get_area(src)
	if(A)
		to_chat(src, "Current Location: [sanitize(A.get_name())]")

/mob/living/silicon/robot/verb/toggle_prybar()
	set category = "Abilities.Silicon"
	set name = "Toggle Crowbar Jaws"
	// Because these are actually not puppyjaws and are a reskined cyborg crowbar...
	// And I am tired of chewing up the floors stupidly as I try to defend myself as a borg
	var/obj/item/tool/crowbar/cyborg/C = locate() in module.modules
	if(C)
		if(initial(C.pry))
			C.pry = !C.pry
			if(C.pry)
				C.tool_qualities = list(TOOL_CROWBAR)
				to_chat(usr,span_warning("Your [C] will now open doors and dismantle floors."))
			else
				C.tool_qualities = list()
				to_chat(usr,span_notice("You will no longer use your [C] to open doors or dismantle floors."))

// This better not be abused
/mob/living/silicon/robot/verb/detonate_self()
	set name = "Detonate Self-Destruct Explosive"
	set category = "Abilities.Silicon"

	var/choice = tgui_alert(usr, "Are you certain that you want to detonate your self-destruct explosive? Abuse of this action may result in OOC punishments. Admins will be notified.","Detonate Self",list("BAD DOG","No"))
	if(choice == "BAD DOG")
		var/turf/T = get_turf(src)
		log_admin("[key_name_admin(usr)] has detonated their self destruct explosives using the manual verb at: [T.x].[T.y].[T.z]")

		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(5, 0, src)
		sparks.attach(loc)
		sparks.start()

		addtimer(CALLBACK(src, PROC_REF(self_destruct)), 1 SECONDS, TIMER_DELETE_ME)
