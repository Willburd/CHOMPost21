/obj/item/weapon/spellbook/oneuse/buttblast
	spell = /spell/targeted/buttblast
	spellname = "buttblast"
	icon_state ="bookknock"
	desc = "This book seems indecent."

/obj/item/weapon/spellbook/oneuse/buttblast/recoil(mob/user as mob)
	..()
	to_chat(user, "<span class='warning'>You're knocked down!</span>")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		user.Weaken(20)
		var/obj/item/organ/internal/butt/Bu = locate() in H.internal_organs
		if(Bu)
			Bu.assblasted(user)
