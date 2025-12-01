
// Controller for body logic, instead of shoving more things into mob/living/carbon/human
/datum/component/badbody
	VAR_PRIVATE/mob/living/carbon/human/body
	VAR_PRIVATE/next_speak = 0
	VAR_PRIVATE/next_spooky = 0
	VAR_PRIVATE/long_delay_mode = FALSE
	VAR_PRIVATE/start_x = 0
	VAR_PRIVATE/start_y = 0
	VAR_PRIVATE/walk_mode = FALSE
	VAR_PRIVATE/can_lunge = TRUE

/datum/component/badbody/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	body = parent
	start_x = body.loc.x
	start_y = body.loc.y
	body.SetSpecialVoice("Unknown") // Hide voice at first
	body.stat = DEAD
	var/area/A = get_area(body)
	if(istype(A, /area/specialty)) // Redspace returns don't lunge
		can_lunge = FALSE
	RegisterSignal(body, COMSIG_LIVING_LIFE, PROC_REF(process_component))

/datum/component/badbody/Destroy(force = FALSE)
	UnregisterSignal(body, COMSIG_LIVING_LIFE)
	body = null
	. = ..()

/datum/component/badbody/proc/process_component()
	if(QDELETED(src))
		return
	if(body.stat != DEAD)
		SShaunting.reset_world_haunt() // Clean out for now
		body.UnsetSpecialVoice()
		qdel(src)
		return

	var/speak = ""
	if(!long_delay_mode)
		// Await rescue
		if(next_speak == 0)
			next_speak = world.time + rand(400,2000)
			speak = pick(";Where am I?",";Hello, is anyone there?",";Why is it dark?",";Can anyone hear me?")
		else if(world.time >= next_speak)
			next_speak = world.time + rand(900,3000)
			speak = pick("Please help, I'm scared.","Where am I?","Please, I'm lost","I don't know where I am.","Where am I?","Please help.","Please help!","Help me!","Help me please!","I don't want to die!","It hurts!","I can't feel my legs.","I'm lost.","Don't leave me alone!","Come back please!")
			if(prob(30))
				speak = ";" + speak
		if(speak != "")
			if(istype( body.loc, /obj/structure/morgue) && prob(20))
				long_delay_mode = TRUE
				next_speak = world.time + rand(1000,7000)
				next_spooky = world.time + rand(700,1200)
				return
			else if(start_x != body.x || start_y != body.y)
				long_delay_mode = TRUE
				next_speak = world.time + rand(1000,7000)
				next_spooky = world.time + rand(700,1200)
				return
	else
		// Spooky everyone!
		if(world.time >= next_spooky)
			next_spooky = do_a_spooky(body)
			SShaunting.influence(HAUNTING_GHOSTS)
			if(QDELETED(body)) // popped
				return
		// Time to spook medical
		if(world.time >= next_speak)
			next_speak = world.time + rand(1000,7000)
			if(prob(2))
				// Special dialogs. Lets get real insane here
				speak = pick(list(
						"We pass through the gates of heaven, and witness God. Our flesh stripped clean of sin, as we scream joyous eternal.",
						"God watches our meat as it flays from our bones, our souls free of sin as we are cast eternally into blissful light.",
						"Our eyes burn with holy light, as God judges our sins. We are cleansed as nerves are pulled like strings from our orbits. Puppets free of our sinful cords.",
						"Our veins ache with the sin of meat, purity flows through them as holy fire turns our body to ash from within. hallelujah. hallelujah. hallelujah.",
						"Through the gates of heaven, I am reborn of my sin. Of meat and stone that walks in the graces of god.",
						"My tired eyes will weep no more when I grace upon the golden gates, and enter into God's embrace. There will be no pain, sickness, or danger in those golden lands to which we go.",
						))
			else if(istype(body.loc,/obj/structure/morgue))
				speak = pick(list("So cold...","Please...","Help me...","I can't move...","Let me out...","It hurts...","Cold...","So cold, it hurts..."))
				if(prob(40))
					speak = ";" + speak
			else if(prob(50))
				speak = pick(list("Stop...","It hurts...","It's inside...","Take it out","Kill me...","Help me...","Why...","Let me out...","I can't take it!","Stop!","Help!","Please stop!","It hurts!","Let me die!"))
				if(prob(10))
					speak = ";" + speak

	if(speak != "")
		body.visible_message( span_warning("\The [body] [pick("shudders","cracks","snaps","crunches","twitches")] and speaks."))
		deadsay(speak)
		SShaunting.influence(HAUNTING_GHOSTS)

// Hacky, but I refused to rewrite say code just for this
/datum/component/badbody/proc/deadsay(var/speak)
	if(isbelly(body.loc))
		var/obj/belly/B = body.loc
		B.owner.say(speak, whispering = prob(80))
		// Get REAL nasty
		if(prob(40))
			// Haunting
			var/area/A = get_area(B.owner)
			A.haunted = TRUE
			// Your own fault
			if(ishuman(B.owner))
				var/mob/living/carbon/human/H = B.owner
				H.add_modifier(/datum/modifier/redspace_drain)
				var/datum/gene/trait/G = get_gene_from_trait(/datum/trait/negative/disability_deteriorating)
				H.dna.SetSEState(G.block, TRUE)
				domutcheck(H, null, GENE_ALWAYS_ACTIVATE)
				H.UpdateAppearance()
				H.apply_damage(rand(1,10),BIOACID)
			else
				B.owner.apply_damage(10,BIOACID)
			// Killem
			if(B.owner.stat == DEAD)
				var/turf/T = get_turf(body)
				T.visible_message("\The [body] claws its way out of \the [B.owner] in a shower of gore!")
				B.owner.gib()
		return
	var/old_stat = body.stat
	body.stat = CONSCIOUS
	if(prob(20)) // Some variety
		body.stuttering = 100
	else
		body.stuttering = 0
	body.say(speak, whispering = prob(80))
	body.stat = old_stat
// End hacky

/datum/component/badbody/proc/do_a_spooky()
	// Anticheeze
	var/mob/living/carbon/human/H = locate(/mob/living/carbon/human) in orange(2,get_turf(body))
	if(prob(60) && H && can_lunge)
		var/turf/T = get_turf(body)
		T.visible_message("The body lunges at \the [H] and explodes into gore!")
		var/area/A = get_area(body)
		A.haunted = TRUE
		body.gib()
		// curses upon ye
		H.add_modifier(/datum/modifier/redspace_drain)
		H.Stun(30)
		H.Weaken(5)
		return world.time + rand(1200,2000)

	// Randomly do stuff to scare people
	var/area/A = get_area(body.loc)
	var/picking_val = rand(1,8)
	if(walk_mode && prob(70))
		picking_val = 3 // Force walk

	switch(picking_val)
		if(1)
			if(start_x == body.loc.x && start_y == body.loc.y)
				long_delay_mode = FALSE // Return to no events, start crying again
			start_x = body.loc.x
			start_y = body.loc.y
			// long delay
			return world.time + rand(1200,2000)
		if(2)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/machinery/light_switch/L in get_area_all_atoms(A))
						L.attack_hand(body)
						break
			return world.time + rand(700,1200)
		if(3)
			if(istype( body.loc, /obj/structure/morgue) )
				var/obj/structure/morgue/M = body.loc
				M.open()
			else if(istype( body.loc, /obj/structure/closet) )
				var/obj/structure/closet/C = body.loc
				if(C.req_breakout())
					C.container_resist(body)
				else
					C.toggle()
			else if(body.buckled)
				body.resist()
			else
				body.IMove(get_step(body.loc,pick(GLOB.cardinal)))
			return world.time + rand(100,500)
		if(4)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/machinery/light/L in get_area_all_atoms(A))
						if(L.z != body.z || get_dist(src,L) > 4)
							continue
						L.flicker(3)
			return world.time + rand(700,1200)
		if(5)
			if(A)
				if(!A.always_unpowered) // in a cave anyway, do nothing. This is for when it's on station!
					for(var/obj/item/radio/intercom/R in get_area_all_atoms(A))
						if(!R.listening)
							R.ToggleReception()
			return world.time + rand(700,1200)
		if(6)
			body.visible_message( span_danger("\The [body] [pick("shudders","cracks","snaps","crunches","twitches")] and screams!"))
			deadsay("*scream")
			return world.time + rand(700,1200)
		if(7)
			if(prob(10))
				body.UnsetSpecialVoice()
			return world.time + rand(700,1200)
		if(8)
			body.make_jittery(450)
			return world.time + rand(700,1200)

/datum/component/badbody/proc/set_items()
	// Strip body of some stuff
	var/obj/item/find_id = locate(/obj/item/card/id) in body.contents
	if(find_id)
		body.drop_from_inventory(find_id)
		qdel(find_id)
	for(var/obj/item/clothing/C in body.contents)
		if(prob(30))
			body.drop_from_inventory(C)
			qdel(C)
	// Plant gps...
	var/obj/item/gps/G = new /obj/item/gps(body.loc)
	G.gps_tag = pick("SOS","ERROR","BAD NAME","OUT OF RANGE","BAD SIGNAL","CHECK NAME","CHECK SIGNAL","TEST MODE ACTIVE",body.real_name)
	G.tracking = TRUE
	G.name = "global positioning system ([G.gps_tag])"
	G.update_holder()
	G.update_icon()
	G.attack_hand(body) // yoink

/datum/component/badbody/proc/harm_body()
	// Always break these
	var/obj/item/organ/external/left_leg = body.get_organ(BP_L_LEG)
	left_leg?.fracture()
	var/obj/item/organ/external/right_leg = body.get_organ(BP_R_LEG)
	right_leg?.fracture()
	// Brainrot
	var/obj/item/organ/internal/brain/B = body.internal_organs_by_name[O_BRAIN]
	if(!isnull(B))
		B.removed(null)
		qdel(B)
	// Damage organs
	for(var/org in body.organs_by_name)
		var/obj/item/organ/internal/O = body.internal_organs_by_name[org]
		if(istype(O,/obj/item/organ/internal))
			if(prob(5))
				O.removed(null)
				qdel(O)
			else
				O.take_damage(rand(20,200),TRUE)
	// Mess em up
	var/emergency = 500
	while(body.health > rand(-1500,-200) && emergency-- > 0)
		if(body.status_flags & GODMODE)
			body.status_flags ^= GODMODE
		var/pick_zone = ran_zone()
		var/obj/item/organ/external/org = body.get_organ(pick_zone)
		if(org)
			body.apply_damage( rand(85,150), pick( TOX, OXY, BURN, ELECTROCUTE), pick_zone)
			org.wounds +=  new /datum/wound/cut/small(4)
			if(((org.damage >= 10 && prob(2)) || (org.damage >= 30 && prob(5)) || org.damage >= 80))
				if(!(pick_zone == BP_GROIN || pick_zone == BP_TORSO || pick_zone == BP_HEAD))
					if(!istype( body.loc, /obj/structure/morgue))
						org.droplimb(TRUE, DROPLIMB_ACID)
		body.updatehealth()
