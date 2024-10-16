/obj/structure/bed/chair/office/attack_ghost(mob/user)
	. = ..()
	//SPEEN
	if(!CONFIG_GET(flag/cult_ghostwriter))
		return
	var/spintime = 3
	var/speed = 1
	spawn()
		var/D = dir
		while(spintime >= speed)
			sleep(speed)
			switch(D)
				if(NORTH)
					D = EAST
				if(SOUTH)
					D = WEST
				if(EAST)
					D = SOUTH
				if(WEST)
					D = NORTH
			set_dir(D)
			for(var/mob/M in buckled_mobs)
				M.dir = D
				M.set_dir(D)
			spintime -= speed
