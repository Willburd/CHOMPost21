/obj/item/dogborg/sleeper/container_resist(mob/living/prey)
	hound = src.loc
	if(istype(prey,/mob/living/voice)) //Voices shouldn't be able to resist but we have this here just in case.
		return
	if(!istype(hound))
		return ..(prey)
	if(prob(98))
		to_chat(prey, "<span class='notice'>The walls of \the [src] resist your struggling!</span>")
		return

	var/escape_time = 20 SECONDS
	to_chat(prey, "<span class='notice'>You find the emergency ejection controls, and quickly begin using them!</span>")
	to_chat(hound, "<span class='danger'>Something is trying to operate your emergency ejection system!</span>")
	if(!do_after(prey, escape_time, hound))
		to_chat(prey, "<span class='danger'>You were jostled around, losing hold of the ejection controls!</span>")
		to_chat(hound, "<span class='danger'>You jostle the escapee around, making them lose hold of your ejection controls!</span>")
		return

	// Eject
	go_out()

/obj/item/dogborg/sleeper/K9/container_resist(mob/living/prey)
	to_chat(prey, "<span class='notice'>The walls of \the [src] resist your struggling! \The [src] does not have an ejection system!</span>")
	return // No resisting out of brig
