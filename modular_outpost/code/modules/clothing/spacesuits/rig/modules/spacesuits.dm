//Outpost Edit: Undoes spacesuits being breach immune.

/obj/item/clothing/suit/space

	can_breach = TRUE
	breach_threshold = 10 //Up the breach threshold

/obj/item/clothing/suit/space/emergency
	can_breach = TRUE //Keeping this here incase upstream ever disables.

/obj/item/clothing/suit/space/void
	can_breach = TRUE

/obj/item/clothing/suit/space/rig
	can_breach = TRUE //Ditto
	breach_threshold = 20 //Lowered from 38 -> 20
