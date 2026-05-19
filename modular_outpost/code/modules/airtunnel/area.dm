/*
 *	Airtunnel -- the airtunnel area
 *				 Holds the datum for the airtunnel, used to locate the parts inside the area that are extending and contracting
 *
 */

/area/airtunnel
	name = "airtunnel"

/area/airtunnel/Initialize(mapload)
	. = ..()
	for(var/obj/move/airtunnel/A in locate(src))
		A.master = src
		A.create()
		connectors += A

/area/airtunnel/Destroy()
	connectors.Cut()
	connectors = null
	. = ..()

/area/airtunnel/proc/siphons()
	switch(siphon_status)
		if(0.0)
			for(var/obj/machinery/atmoalter/siphs/S in locate(linked_area))
				S.t_status = 3
		if(1.0)
			for(var/obj/machinery/atmoalter/siphs/fullairsiphon/S in locate(linked_area))
				S.t_status = 2
				S.t_per = 1000000.0
			for(var/obj/machinery/atmoalter/siphs/scrubbers/S in locate(linked_area))
				S.t_status = 3
		if(2.0)
			for(var/obj/machinery/atmoalter/siphs/S in locate(linked_area))
				S.t_status = 4
		if(3.0)
			for(var/obj/machinery/atmoalter/siphs/fullairsiphon/S in locate(linked_area))
				S.t_status = 1
				S.t_per = 1000000.0
			for(var/obj/machinery/atmoalter/siphs/scrubbers/S in locate(linked_area))
				S.t_status = 3

/area/airtunnel/proc/stop()
	operating = 0
	return

/area/airtunnel/proc/extend()
	if (operating)
		return

	spawn(0)
		operating = 2
		while(operating == 2)
			var/ok = 1
			for(var/obj/move/airtunnel/connector/A in connectors)
				if (!( A.current.next ))
					operating = 0
					return
				if (!( A.move_left() ))
					ok = 0
			if (!( ok ))
				operating = 0
			else
				for(var/obj/move/airtunnel/connector/A in connectors)
					if (A.current)
						A.current.next.loc = get_step(A.current.loc, EAST)
						A.current = A.current.next
						A.current.deployed = 1
					else
						operating = 0
			sleep(20)
		return

/area/airtunnel/proc/retract()
	if (operating)
		return
	spawn(0)
		operating = 1
		while(operating == 1)
			var/ok = 1
			for(var/obj/move/airtunnel/connector/A in connectors)
				if (A.current == A)
					operating = 0
					return
				if (A.current)
					A.current.loc = null
					A.current.deployed = 0
					A.current = A.current.previous
				else
					ok = 0
			if (!( ok ))
				operating = 0
			else
				for(var/obj/move/airtunnel/connector/A in connectors)
					if (!( A.current.move_right() ))
						operating = 0
			sleep(20)
		return




















// Subtunnels
/area/airtunnel/tunnel_one
	name = "airtunnel 1"

/area/airtunnel/tunnel_two
	name = "airtunnel 2"
