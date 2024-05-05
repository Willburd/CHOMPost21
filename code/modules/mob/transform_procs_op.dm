/mob/living/carbon/human/proc/chuify()
	if (transforming)
		return
	for(var/obj/item/W in src)
		drop_from_inventory(W)
	regenerate_icons()
	transforming = 1
	canmove = 0
	stunned = 1
	for(var/t in organs)
		qdel(t)

	// lets not make this pleasant
	emote("scream")
	transforming = 0
	stunned = 0
	update_canmove()

	var/mob/living/simple_mob/vore/alienanimals/chu/new_mob = new /mob/living/simple_mob/vore/alienanimals/chu(src.loc)
	new_mob.isOriginal = FALSE // only the first is with no color overlays!
	new_mob.overlay_colors["Body"] = rgb(r_skin,g_skin,b_skin)
	new_mob.overlay_colors["Eyes"] = rgb(r_eyes,g_eyes,b_eyes)
	new_mob.overlay_colors["Blood"] = species.blood_color
	new_mob.glow_color = new_mob.overlay_colors["Eyes"]
	new_mob.a_intent = a_intent
	if(species.name == "Vox")
		new_mob.overlay_colors["Body"] = "#226622"

	// transfer!
	if(mind)
		mind.transfer_to(new_mob)
	if(key)
		new_mob.key = key

	to_chat(new_mob, "You suddenly feel more... happy. You should make more \"friends\" happy like you are!")
	spawn()
		qdel(src)
	return new_mob
