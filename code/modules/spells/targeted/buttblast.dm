/spell/targeted/buttblast
	name = "Butt blaster"
	desc = "Blasts the booty off of your target."
	invocation = "PHUK BYUK KER"
	invocation_type = SpI_SHOUT

/spell/targeted/buttblast/cast(list/targets)
	..()
	for(var/mob/living/target in targets)
		var/obj/item/organ/internal/butt/Bu = locate() in target.internal_organs
		if(!Bu)
			to_chat(usr,"<span class='notice'>Try as you might, [target] has no butt to smite!</span>")
			return
		Bu.assblasted(usr)
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(5, 0, target)
		sparks.attach(target.loc)
		sparks.start()
		playsound(target, 'sound/effects/tape.ogg', 50)
		to_chat(target,"<span class='danger'>Your butt blasts off!</span>")
		to_chat(usr,"<span class='warning'>You blast [target]'s butt off!</span>")
	return
