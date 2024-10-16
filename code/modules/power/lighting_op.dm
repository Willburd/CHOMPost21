/obj/item/light/bulb/blue
	brightness_range = 4
	color = "#1b02da"
	brightness_color = "#1b02da"
	init_brightness_range = 4

/obj/machinery/light/attack_ghost(mob/user)
	. = ..()
	if(!CONFIG_GET(flag/cult_ghostwriter))
		return
	// Ghosts can flicker lights
	var/says = "You influence \the [src]... "
	if(on && status == LIGHT_OK && prob(20))
		flicker(rand(3,5))
		says +=" Making it flicker!"
	else
		says +=" But nothing happens."
	to_chat(user,says)
