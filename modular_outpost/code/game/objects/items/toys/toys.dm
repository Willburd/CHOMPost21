/obj/item/toy/plushie/jil
	name = "Jil plushie"
	desc = "A small plush ball of fluff, this one will only steal your heart!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_jil"
	var/cooldown = 0

/obj/item/toy/plushie/jil/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'sound/voice/merp.ogg', 10, 0)
		src.visible_message(span_danger("Merp!"))
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()

/obj/item/toy/plushie/jil/proc/cooldownreset()
	cooldown = 0

/obj/item/toy/plushie/tinytin
	name = "tiny tin plushie"
	desc = "A tiny fluffy nevrean plush with the label 'Tiny-Tin.' Press his belly to hear a sound!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_tin"
	var/cooldown = 0

/obj/item/toy/plushie/tinytin/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'sound/voice/peep.ogg', 30, 0)
		src.visible_message(span_danger("Peep peep!"))
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()

/obj/item/toy/plushie/tinytin/proc/cooldownreset()
	cooldown = 0


/obj/item/toy/plushie/tinytin/sec
	name = "officer tiny tin plushie"
	desc = "Officer Tiny-Tin, now with rooty-tooty-shooty action! Press his belly to hear a sound!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_tinsec"


/obj/item/toy/plushie/tinytin/sec/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'modular_outpost/sound/misc/tinytin_fuckedup.ogg', 85, 0)
		src.visible_message(span_danger("That means you fucked up!"))
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()


/obj/item/toy/plushie/chu
	name = "Chu plushie"
	desc = "With a smile like that, who wouldn't be their friend!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_chu"
	var/cooldown = 0

/obj/item/toy/plushie/chu/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, pick('sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg') , 50, 0)
		src.visible_message(span_danger("Chitter!"))
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()

/obj/item/toy/plushie/chu/proc/cooldownreset()
	cooldown = 0


/obj/item/toy/plushie/pillow
	name = "plush pillow"
	desc = "A fluffy soft pillow!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_pillow"

/obj/item/toy/plushie/pillow/red
	name = "red plush pillow"
	desc = "A red fluffy soft pillow!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_pillowr"

/obj/item/toy/plushie/pillow/green
	name = "green plush pillow"
	desc = "A green fluffy soft pillow!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_pillowg"

/obj/item/toy/plushie/pillow/blue
	name = "blue plush pillow"
	desc = "A blue fluffy soft pillow!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "plushie_pillowb"


//Large plushies.
/obj/structure/plushie/tesh/taaa
	name = "Silly Teshari Plush"
	desc = "A large plush of some huge, colorful teshari."
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "taaa_plush"
	anchored = FALSE
	density = TRUE
	phrase = "WHY!"

/obj/structure/plushie/tesh/gold
	name = "Gold Teshari Plush"
	desc = "A large plush of some a colorful, golden teshari, very huggable!"
	icon = 'modular_outpost/icons/obj/toy.dmi'
	icon_state = "teshplush_gold"
	anchored = FALSE
	density = TRUE
	phrase = "Chirp!"

/* Outpost 21 TODO - custom tesh staff plushies

// Teshari plushes
/obj/item/toy/plushie/teshari/trashfire
	name = "Trashfire"
	desc = "This is Trashfire the plushie Teshari. Very soft, and looking grumpy! The toy is made well, as if alive. Looks like she is sleeping. Shhh!"
	icon_state = "teshariplushie_trashfire"
	item_state = "teshariplushie_trashfire"
	pokephrase = "Rya!"
	slot_flags = SLOT_BACK | SLOT_HEAD
	icon = 'modular_outpost/icons/obj/toy.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_toys_op.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_toys_op.dmi',
		slot_back_str = 'icons/mob/toy_worn_op.dmi',
		slot_head_str = 'icons/mob/toy_worn_op.dmi')

/obj/item/toy/plushie/teshari/schale
	name = "Schale"
	desc = "This is Schale the plushie Teshari. Very soft, and on the verge of a mental breakdown! The toy is made well, as if alive. Looks like she is sleeping. Shhh! Floorpills not included."
	icon_state = "teshariplushie_schale"
	item_state = "teshariplushie_schale"
	pokephrase = "Rya!"
	slot_flags = SLOT_BACK | SLOT_HEAD
	icon = 'modular_outpost/icons/obj/toy.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_toys_op.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_toys_op.dmi',
		slot_back_str = 'icons/mob/toy_worn_op.dmi',
		slot_head_str = 'icons/mob/toy_worn_op.dmi')

/obj/item/toy/plushie/teshari/tesum
	name = "Tesum"
	desc = "This is Tesum the plushie Teshari. The toy is made well, it's so lifelike it's started to deteriorate like its namesake! Looks like he is sleeping. Shhh!"
	icon_state = "teshariplushie_tesum"
	item_state = "teshariplushie_tesum"
	pokephrase = "Rya!"
	slot_flags = SLOT_BACK | SLOT_HEAD
	icon = 'modular_outpost/icons/obj/toy.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_toys_op.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_toys_op.dmi',
		slot_back_str = 'icons/mob/toy_worn_op.dmi',
		slot_head_str = 'icons/mob/toy_worn_op.dmi')

/obj/item/toy/plushie/teshari/mitz
	name = "Mitz"
	desc = "This is Mitz the plushie Teshari. The amount of detail makes it almost look lifelike! Looks like he is sleeping. Shhh!"
	icon_state = "teshariplushie_mitz"
	item_state = "teshariplushie_mitz"
	pokephrase = "Rya!"
	slot_flags = SLOT_BACK | SLOT_HEAD
	icon = 'modular_outpost/icons/obj/toy.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_toys_op.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_toys_op.dmi',
		slot_back_str = 'icons/mob/toy_worn_op.dmi',
		slot_head_str = 'icons/mob/toy_worn_op.dmi')

/obj/item/toy/plushie/teshari/taaa
	name = "Taaa"
	desc = "This is Taaa the plushie Teshari. The amount of detail makes it almost look lifelike! Looks like he is sleeping. Shhh!"
	icon_state = "teshariplushie_taaa"
	item_state = "teshariplushie_taaa"
	pokephrase = "Rya!"
	slot_flags = SLOT_BACK | SLOT_HEAD
	icon = 'modular_outpost/icons/obj/toy.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_toys_op.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_toys_op.dmi',
		slot_back_str = 'icons/mob/toy_worn_op.dmi',
		slot_head_str = 'icons/mob/toy_worn_op.dmi')

*/
