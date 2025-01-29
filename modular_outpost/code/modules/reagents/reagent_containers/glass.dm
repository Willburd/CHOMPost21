/obj/item/reagent_containers/glass/beaker/vial/hemocyanin
	name = "vial (hemocyanin)"
	prefill = list(REAGENT_ID_HEMOCYANIN = 30)

/obj/item/reagent_containers/glass/beaker/vial/sustenance
	name = "vial (artificial sustenance)"
	prefill = list(REAGENT_ID_ASUSTENANCE = 30)



// Randomized protein powder
/obj/item/reagent_containers/glass/beaker/wheymax
	name = "WHEYMAX"
	desc = "A small plastic container with an absurdly decorated label."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-5"
	item_state = "bottle-5"

/obj/item/reagent_containers/glass/beaker/wheymax/Initialize()
	prefill = list(REAGENT_ID_PROTEINPOWDER = 20, REAGENT_ID_SUGAR = 10) // 4/6ths nutriment, 1/6th sugar, 1/6th flavor
	var/name_pick
	switch(rand(1,8))
		if(1)
			prefill += list(REAGENT_ID_INSTANTAPPLE = 30)
			name_pick = list("APPLESNAPZ YOUR KNEECAPS","CYANIDE LUST","SEEDS OF DEATH")
		if(2)
			prefill += list(REAGENT_ID_INSTANTGRAPE = 30)
			name_pick = list("SOUR PUCKER SENSATION","SOUR DESPAIR STORM","SULTRY SOUR SECCUBUS")
		if(3)
			prefill += list(REAGENT_ID_INSTANTJUICE = 30)
			name_pick = list("FRUITY DEATHSQUAD","DEATH FROM THE LOOM","RAINBOW OF FUCK")
		if(4)
			prefill += list(REAGENT_ID_INSTANTORANGE = 30)
			name_pick = list("FLORIDA ONE MAN RIOT","CITRUS CASTRATION","CITRUS CONCUBINE")
		if(5)
			prefill += list(REAGENT_ID_INSTANTWATERMELON = 30)
			name_pick = list("HUGE BAZONGAS","MASSIVE DOBONHONKAROOS","WATERHELLON")
		if(6)
			prefill += list(REAGENT_ID_HOTCOCO = 30)
			name_pick = list("COCOCAINE","BITTER ADORATION","BLACK LIQUID SORROW")
		if(7)
			prefill += list(REAGENT_ID_CAPSAICIN = 30)
			name_pick = list("RECTAL RAMPAGE","ASSASSIN OF ASS DEVASSTATION","BOTTLE OF WOES")
		if(8)
			prefill += list(REAGENT_ID_COFFEE = 30)
			name_pick = list("RAW PESTICIDES","TESHARI RATTLER","MORNING BANSHEE")
	name = "WHEYMAX ([pick(name_pick)])"
	var/icons = list("bottle5","bottle6","bottle7","bottle8","bottle9")
	icon_state = pick(icons)
	item_state = icon_state
	. = ..()
