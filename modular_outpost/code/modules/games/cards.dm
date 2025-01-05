/obj/item/deck/cards/blackjack
	name = "blackjack deck"
	desc = "A very large deck of playing cards."
	icon_state = "deck"
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/deck/cards/blackjack/New()
	..()
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
