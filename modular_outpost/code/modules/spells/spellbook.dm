/obj/item/spellbook/oneuse/buttblast
	icon = 'modular_outpost/icons/obj/library.dmi'
	spell = /spell/targeted/buttblast
	spellname = "buttblast"
	icon_state ="bookbutt"
	desc = "This book seems indecent."

/obj/item/spellbook/oneuse/buttblast/recoil(mob/user as mob)
	..()
	to_chat(user, span_warning("You're knocked down!"))
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.Weaken(20)
		new /obj/effect/decal/cleanable/confetti(get_turf(H))
		var/obj/item/organ/internal/butt/Bu = locate() in H.internal_organs
		if(Bu)
			Bu.assblasted(user)
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
			s.set_up(3, 1, H)
			s.start()
			// YAYYYYY
			playsound(H, 'sound/items/confetti.ogg', 75, 1)
			playsound(H, 'sound/effects/snap.ogg', 50, 1)
