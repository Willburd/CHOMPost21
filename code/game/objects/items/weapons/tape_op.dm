/obj/item/tape_roll/cyborg
	name = "tape dispenser"
	desc = "A roll of sticky tape. Possibly for taping ducks... or was that ducts?"
	icon = 'icons/obj/bureaucracy.dmi'

/obj/item/tape_roll/cyborg/attack(var/mob/living/carbon/human/H, var/mob/user)
	return FALSE // No taping people up with this
