/obj/effect/step_trigger/dephase_shadekin
	name = "shadekin dephaser"
	affect_ghosts = 1

/obj/effect/step_trigger/dephase_shadekin/Trigger(var/atom/movable/A)
	if(isobserver(A))
		return
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		if(H.get_species() == SPECIES_SHADEKIN && (H.ability_flags & AB_PHASE_SHIFTED))
			H.attack_dephase(null, src)
