/spell/targeted/buttblast
	name = "Butt blaster"
	desc = "Blasts the booty off of your target."
	invocation = "PHUK BYUK KER"
	invocation_type = SpI_SHOUT
	hud_state = "wiz_butt"

/spell/targeted/buttblast/cast(list/targets)
	..()
	for(var/mob/living/target in targets)
		var/obj/item/organ/internal/butt/Bu = locate() in target.internal_organs
		if(!Bu)
			to_chat(usr,"<span class='notice'>Try as you might, [target] has no butt to smite!</span>")
			return
		Bu.assblasted(usr)
		target.Weaken(10)
		var/turf/T = get_turf(target)
		new /obj/effect/decal/cleanable/confetti(T)
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
		s.set_up(3, 1, T)
		s.start()
		// YAYYYYY
		playsound(T, 'sound/items/confetti.ogg', 75, 1)
		playsound(T, 'sound/effects/snap.ogg', 50, 1)
		to_chat(target,"<span class='danger'>Your butt blasts off!</span>")
		to_chat(usr,"<span class='warning'>You blast [target]'s butt off!</span>")
	return
