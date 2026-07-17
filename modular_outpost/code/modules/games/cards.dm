/obj/item/deck/cards/blackjack
	name = "blackjack deck"
	desc = "A very large deck of playing cards."
	icon_state = "deck"
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/deck/cards/blackjack/Initialize(mapload)
	. = ..()
	// Remove original jokers
	for(var/datum/playingcard/C in cards)
		if(C.name == "joker")
			cards -= C
			qdel(C)
	// Six times the fun! +1 original deck
	var/datum/playingcard/P
	for(var/i = 0, i<5, i++) // Six times the fun! +1 original deck
		for(var/suit in list("spades","clubs","diamonds","hearts"))

			var/colour
			if(suit == "spades" || suit == "clubs")
				colour = "black_"
			else
				colour = "red_"

			for(var/number in list("ace","two","three","four","five","six","seven","eight","nine","ten"))
				P = new()
				P.name = "[number] of [suit]"
				P.card_icon = "[colour]num"
				P.back_icon = "card_back"
				cards += P

			for(var/number in list("jack","queen","king"))
				P = new()
				P.name = "[number] of [suit]"
				P.card_icon = "[colour]col"
				P.back_icon = "card_back"
				cards += P

/obj/item/deck/cards/bizcard
	name = "business card deck"
	desc = "A deck of preprinted business cards."
	icon_state = "deck"
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/deck/cards/bizcard/Initialize(mapload)
	. = ..()
	// Remove original deck
	for(var/datum/playingcard/C in cards)
		cards -= C
		qdel(C)

/obj/item/deck/cards/bizcard/verb/set_deck_info()
	set name = "Set Business Card Info"
	set desc = "Sets the name and description of the cards in the deck. Can only be done ONCE."
	set category = "Object"

	var/mob/current_user = usr

	var/set_name = tgui_input_text(current_user, "What are the cards named?", "Set Business Card Name","Business Card", MAX_NAME_LEN,FALSE)
	if(!set_name)
		return
	var/set_desc = tgui_input_text(current_user, "Haw are the cards described?", "Set Business Card Description","An unassuming business card.", MAX_MESSAGE_LEN,TRUE)
	if(!set_name)
		return
	if(QDELETED(src) || QDELETED(current_user))
		return
	if(!current_user.Adjacent(src))
		return

	var/datum/playingcard/P
	for(var/i = 0, i < 20, i++)
		P = new()
		P.name = "[set_name] ([set_desc])"
		P.card_icon = "biz_front"
		P.back_icon = "biz_back"
		cards += P

// This is godawful
/obj/item/hand/update_icon(direction)
	. = ..()
	if(length(cards))
		var/datum/playingcard/P = cards[1]
		if(P.card_icon == "biz_front" && icon == /obj/item/hand::icon)
			icon = 'modular_outpost/icons/obj/playing_cards.dmi'
			icon_state = P.card_icon
		if(cards.len > 1)
			name = "Business Cards"
			desc = "A business card stack"
		else
			name = "Business Card"
			desc = "A business card, flip it over for more info!"
