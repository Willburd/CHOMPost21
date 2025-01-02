/obj/effect/auto_crayon
	name = "autografitti"
	desc = "Automagically draws grafitti by name"
	icon = 'icons/effects/crayondecal.dmi'
	icon_state = "dwarf"
	invisibility = 100
	var/colour = null
	var/shadeColour = null

/obj/effect/auto_crayon/Initialize()
	. = ..()
	if(colour == null)
		switch(rand(1,6))
			if(1)
				colour = "#DA0000"
				shadeColour = "#810C0C"

			if(2)
				colour = "#FF9300"
				shadeColour = "#A55403"

			if(3)
				colour = "#FFF200"
				shadeColour = "#886422"

			if(4)
				colour = "#A8E61D"
				shadeColour = "#61840F"

			if(5)
				colour = "#00B7EF"
				shadeColour = "#0082A8"

			if(6)
				colour = "#DA00FF"
				shadeColour = "#810CFF"

	new /obj/effect/decal/cleanable/crayon(loc,colour,shadeColour,icon_state)
	qdel(src)
