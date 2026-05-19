/obj/move/airtunnel
	name = "airtunnel"
	icon = 'modular_outpost/icons/obj/airtunnel/airtunnel.dmi'
	icon_state = "floor"
	var/deployed = 0.0
	var/obj/move/airtunnel/next = null
	var/obj/move/airtunnel/previous = null
	var/r_master = null

/obj/move/airtunnel/connector
	name = "connector"
	icon_state = "floor-c"
	var/obj/move/airtunnel/current = null
	deployed = 1.0

/obj/move/airtunnel/connector/wall
	name = "wall"
	icon_state = "wall-c"
	opacity = 1
	density = 1
	updatecell = 0.0

/obj/move/airtunnel/wall
	name = "wall"
	icon_state = "wall"
	opacity = 1
	density = 1
	updatecell = 0.0

/obj/move/airtunnel/process()

	if (!( deployed ))
		return null
	else
		..()
	return

/obj/move/airtunnel/connector/create()

	current = src
	next = new /obj/move/airtunnel( null )
	next.master = master
	next.previous = src
	spawn( 0 )
		next.create(36, y)
		return
	return

/obj/move/airtunnel/connector/wall/create()

	current = src
	next = new /obj/move/airtunnel/wall( null )
	next.master = master
	next.previous = src
	spawn( 0 )
		next.create(36, y)
		return
	return

/obj/move/airtunnel/connector/wall/process()

	return

/obj/move/airtunnel/wall/create(num, y_coord)

	if (((num < 7 || (num > 14 && num < 21)) && y_coord == 72))
		next = new /obj/move/airtunnel( null )
	else
		next = new /obj/move/airtunnel/wall( null )
	next.master = master
	next.previous = src
	if (num > 1)
		spawn( 0 )
			next.create(num - 1, y_coord)
			return
	return

/obj/move/airtunnel/wall/move_right()

	flick("wall-m", src)
	return ..()
	return

/obj/move/airtunnel/wall/move_left()

	flick("wall-m", src)
	return ..()
	return

/obj/move/airtunnel/wall/process()

	return

/obj/move/airtunnel/proc/move_left()

	relocate(get_step(src, WEST))
	if ((next && next.deployed))
		return next.move_left()
	else
		return next
	return

/obj/move/airtunnel/proc/move_right()

	relocate(get_step(src, EAST))
	if ((previous && previous.deployed))
		previous.move_right()
	return previous
	return

/obj/move/airtunnel/proc/create(num, y_coord)

	if (y_coord == 72)
		if ((num < 7 || (num > 14 && num < 21)))
			next = new /obj/move/airtunnel( null )
		else
			next = new /obj/move/airtunnel/wall( null )
	else
		next = new /obj/move/airtunnel( null )
	next.master = master
	next.previous = src
	if (num > 1)
		spawn( 0 )
			next.create(num - 1, y_coord)
			return
	return
