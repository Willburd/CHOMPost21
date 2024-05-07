//
//Roulette Table
//

/obj/structure/casino_table/roulette_table/long
	icon_state = "roulette_wheel_long"
	//spin_state = "roulette_wheel_long_spinning"

/obj/structure/casino_table/roulette_long
	name = "roulette table"
	desc = "Roulette table."
	icon_state = "roulette_long"

/obj/item/roulette_ball
	name = "roulette ball"
	desc = "A small ball used for roulette wheel. This one is made of regular metal."
	var/ball_desc = "a small metal ball"
	icon = 'icons/obj/casino.dmi'
	icon_state = "roulette_ball"

	var/cheatball = FALSE

/obj/item/roulette_ball/proc/get_cheated_result()
	return rand(0,37)		// No cheating by default

/obj/item/roulette_ball/proc/get_ball_desc()
	return ball_desc

/obj/item/roulette_ball/proc/on_spin()
	return

/obj/item/roulette_ball/gold
	name = "golden roulette ball"
	desc = "A small ball used for roulette wheel. This one is particularly gaudy."
	ball_desc = "a shiny golden ball"
	icon_state = "roulette_ball_gold"

/obj/item/roulette_ball/red
	name = "red roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate red."
	ball_desc = "a striped red ball"
	icon_state = "roulette_ball_red"

/obj/item/roulette_ball/orange
	name = "orange roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate orange."
	ball_desc = "a striped orange ball"
	icon_state = "roulette_ball_orange"

/obj/item/roulette_ball/green
	name = "green roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate green."
	ball_desc = "a smooth green ball"
	icon_state = "roulette_ball_green"

/obj/item/roulette_ball/blue
	name = "blue roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate blue."
	ball_desc = "a striped blue ball"
	icon_state = "roulette_ball_blue"

/obj/item/roulette_ball/yellow
	name = "yellow roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate yellow."
	ball_desc = "a smooth yellow ball"
	icon_state = "roulette_ball_yellow"

/obj/item/roulette_ball/purple
	name = "purple roulette ball"
	desc = "A small ball used for roulette wheel. This one is ornate purple."
	ball_desc = "a dotted purple ball"
	icon_state = "roulette_ball_purple"

/obj/item/roulette_ball/planet
	name = "planet roulette ball"
	desc = "A small ball used for roulette wheel. This one looks like a small earth-like planet."
	ball_desc = "a planet-like ball"
	icon_state = "roulette_ball_earth"

/obj/item/roulette_ball/moon
	name = "moon roulette ball"
	desc = "A small ball used for roulette wheel. This one looks like a small moon."
	ball_desc = "a moon-like ball"
	icon_state = "roulette_ball_moon"

/obj/item/roulette_ball/hollow
	name = "glass roulette ball"
	desc = "A small ball used for roulette wheel. This one is made of glass and seems to be openable."
	ball_desc = "a small glass ball"
	icon_state = "roulette_ball_glass"

	var/obj/item/weapon/holder/trapped

/obj/item/roulette_ball/hollow/examine(mob/user)
	.=..()
	if(trapped)
		. += "You can see [trapped] trapped inside!"
	else
		. += "It appears to be empty."

/obj/item/roulette_ball/hollow/get_ball_desc()
	.=..()
	if(trapped && trapped.held_mob)
		. += " with [trapped.name] trapped within"
	return

/obj/item/roulette_ball/hollow/attackby(var/obj/item/W, var/mob/user)
	if(trapped)
		to_chat(user, "<span class='notice'>This ball already has something trapped in it!</span>")
		return
	if(istype(W, /obj/item/weapon/holder))
		var/obj/item/weapon/holder/H = W
		if(!H.held_mob)
			to_chat(user, "<span class='warning'>This holder has nobody in it? Yell at a developer!</span>")
			return
		if(H.held_mob.get_effective_size(TRUE) > 50)
			to_chat(user, "<span class='warning'>\The [H] is too big to fit inside!</span>")
			return
		user.drop_from_inventory(H)
		H.forceMove(src)
		trapped = H
		to_chat(user, "<span class='notice'>You trap \the [H] inside the glass roulette ball.</span>")
		to_chat(H.held_mob, "<span class='warning'>\The [user] traps you inside a glass roulette ball!</span>")
		update_icon()

/obj/item/roulette_ball/hollow/update_icon()
	if(trapped && trapped.held_mob)
		icon_state = "roulette_ball_glass_full"
	else
		icon_state = "roulette_ball_glass"

/obj/item/roulette_ball/hollow/attack_self(mob/user as mob)
	if(!trapped)
		to_chat(user, "<span class='notice'>\The [src] is empty!</span>")
		return
	else
		user.put_in_hands(trapped)
		if(trapped.held_mob)
			to_chat(user, "<span class='notice'>You take \the [trapped] out of the glass roulette ball.</span>")
			to_chat(trapped.held_mob, "<span class='notice'>\The [user] takes you out of a glass roulette ball.</span>")
		trapped = null
		update_icon()

/obj/item/roulette_ball/hollow/on_holder_escape()
	trapped = null
	update_icon()

/obj/item/roulette_ball/hollow/on_spin()
	if(trapped && trapped.held_mob)
		to_chat(trapped.held_mob, "<span class='critical'>THE WHOLE WORLD IS SENT WHIRLING AS THE ROULETTE SPINS!!!</span>")

/obj/item/roulette_ball/hollow/Destroy()
	if(trapped)
		trapped.forceMove(src.loc)
		trapped = null
	return ..()

/obj/item/roulette_ball/cheat
	cheatball = TRUE

/obj/item/roulette_ball/cheat/first_twelve
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on first 12."

/obj/item/roulette_ball/cheat/first_twelve/get_cheated_result()
	return pick(list(1,2,3,4,5,6,7,8,9,10,11,12))

/obj/item/roulette_ball/cheat/second_twelve
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on second 12."

/obj/item/roulette_ball/cheat/second_twelve/get_cheated_result()
	return pick(list(13,14,15,16,17,18,19,20,21,22,23,24))

/obj/item/roulette_ball/cheat/third_twelve
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on third 12."

/obj/item/roulette_ball/cheat/third_twelve/get_cheated_result()
	return pick(list(25,26,27,28,29,30,31,32,33,34,35,36))

/obj/item/roulette_ball/cheat/zeros
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on 0 or 00."

/obj/item/roulette_ball/cheat/zeros/get_cheated_result()
	return pick(list(0, 37))

/obj/item/roulette_ball/cheat/red
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on red."

/obj/item/roulette_ball/cheat/red/get_cheated_result()
	return pick(list(1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36))

/obj/item/roulette_ball/cheat/black
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on black."

/obj/item/roulette_ball/cheat/black/get_cheated_result()
	return pick(list(2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35))

/obj/item/roulette_ball/cheat/even
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on even."

/obj/item/roulette_ball/cheat/even/get_cheated_result()
	return pick(list(2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36))

/obj/item/roulette_ball/cheat/odd
	desc = "A small ball used for roulette wheel. This one is made of regular metal. Its weighted to only land on odd."

/obj/item/roulette_ball/cheat/odd/get_cheated_result()
	return pick(list(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35))
