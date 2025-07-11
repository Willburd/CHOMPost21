/obj/effect/step_trigger/dephase_shadekin
	name = "shadekin dephaser"
	affect_ghosts = 1

/obj/effect/step_trigger/dephase_shadekin/Trigger(var/atom/movable/A)
	if(isobserver(A))
		return
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		var/datum/component/shadekin/SK = H.get_shadekin_component()
		if(SK && SK.in_phase) //Shadekin
			SK.attack_dephase(null, src)
