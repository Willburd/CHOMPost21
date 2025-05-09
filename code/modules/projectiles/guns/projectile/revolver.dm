/*
 * Revolver
 */
/obj/item/gun/projectile/revolver
	name = "revolver"
	desc = "The MarsTech HE Colt is a choice revolver for when you absolutely, positively need to put a hole in the other guy. Uses .357 rounds."
	description_fluff = "MarsTech first made their name in the Second Cold War as the 'Lunar Arms Company' providing home-grown arms to the Selene Federation, \
	but after the formation of the SCG rebranded and relocated to Mars where they remain based to this day. \
	The company was acquired by Hephaestus in the mid 23rd century, and its branding used to present an image of historical prestige and Solar unity for their latest product line. \
	MarsTech operates production facilities out of many of the SCG’s larger colonies."
	icon_state = "revolver"
	item_state = "revolver"
	caliber = ".357"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	handle_casings = CYCLE_CASINGS
	max_shells = 6
	ammo_type = /obj/item/ammo_casing/a357
	projectile_type = /obj/item/projectile/bullet/pistol/strong
	var/chamber_offset = 0 //how many empty chambers in the cylinder until you hit a round
	fire_sound = 'sound/weapons/gunshot4.ogg' //CHOMPedit

/obj/item/gun/projectile/revolver/verb/spin_cylinder()
	set name = "Spin cylinder"
	set desc = "Fun when you're bored out of your skull."
	set category = "Object"

	chamber_offset = 0
	visible_message(span_warning("\The [usr] spins the cylinder of \the [src]!"), \
	span_notice("You hear something metallic spin and click."))
	playsound(src, 'sound/weapons/revolver_spin.ogg', 100, 1)
	loaded = shuffle(loaded)
	if(rand(1,max_shells) > loaded.len)
		chamber_offset = rand(0,max_shells - loaded.len)

/obj/item/gun/projectile/revolver/consume_next_projectile()
	if(chamber_offset)
		chamber_offset--
		return
	return ..()

/obj/item/gun/projectile/revolver/load_ammo(var/obj/item/A, mob/user)
	chamber_offset = 0
	return ..()

/obj/item/gun/projectile/revolver/stainless
	icon_state = "revolver_stainless"

/*
 * Detective Revolver
 */
/obj/item/gun/projectile/revolver/detective
	name = "revolver"
	desc = "A standard MarsTech R1 snubnose revolver, popular among some law enforcement agencies for its simple, long-lasting construction. Uses .38-Special rounds."
	description_fluff = "The leading civilian-sector high-quality small arms brand of Hephaestus Industries, MarsTech has been the provider of choice for law enforcement and security forces for over 300 years."
	icon_state = "detective"
	caliber = ".38"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/a38

/obj/item/gun/projectile/revolver/detective/verb/rename_gun()
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun. If you're the detective."

	var/mob/M = usr
	if(!M.mind)	return 0
	if(!M.mind.assigned_role == JOB_SECURITY_OFFICER) // Outpost 21 edit - Detective is officer now
		to_chat(M, span_notice("You don't feel cool enough to name this gun, chump."))
		return 0

	var/input = sanitizeSafe(tgui_input_text(M, "What do you want to name the gun?","Rename Revolver" ,"",MAX_NAME_LEN))

	if(src && input && !M.stat && in_range(M,src))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1

/obj/item/gun/projectile/revolver/detective45
	name = ".45 revolver"
	desc = "A basic revolver, popular among some law enforcement agencies for its simple, long-lasting construction, modified for .45 rounds and a seven-shot cylinder."
	icon_state = "detective"
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/a45/rubber
	max_shells = 6

/obj/item/gun/projectile/revolver/detective45/verb/rename_gun()
	set name = "Name Gun"
	set category = "Object"
	set desc = "Rename your gun. If you're the " + JOB_ALT_DETECTIVE  + "." // Outpost 21 edit - Detective is officer now

	var/mob/M = usr
	if(!M.mind)	return 0
	var/job = M.mind.assigned_role
	if(job != JOB_SECURITY_OFFICER) // Outpost 21 edit - Detective is officer now
		to_chat(M, span_notice("You don't feel cool enough to name this gun, chump."))
		return 0

	var/input = sanitizeSafe(tgui_input_text(M, "What do you want to name the gun?","Rename Revolver" ,"", MAX_NAME_LEN), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1

/obj/item/gun/projectile/revolver/detective45/verb/reskin_gun()
	set name = "Resprite gun"
	set category = "Object"
	set desc = "Click to choose a sprite for your gun."

	var/mob/M = usr
	var/list/options = list()
	options["MarsTech R1 Snubnose"] = "detective"
	options["MarsTech R1 Snubnose (Blued)"] = "detective_blued"
	options["MarsTech R1 Snubnose (Stainless)"] = "detective_stainless"
	options["MarsTech R1 Snubnose (Gold)"] = "detective_stainless"
	options["MarsTech R1 Snubnose (Leopard)"] = "detective_leopard"
	options["MarsTech Frontiersman Classic"] = "detective_peacemaker"
	options["MarsTech Frontiersman Shadow"] = "detective_peacemaker_dark"
	options["Jindal Duke"] = "detective_fitz"
	options["H-H M1895"] = "nagant"
	var/choice = tgui_input_list(M,"Choose your sprite!","Resprite Gun", options)
	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		to_chat(M, "Your gun is now sprited as [choice]. Say hello to your new friend.")
		return 1

/*
 * Lombardi Revolvers
 * 		Use to be detective revolvers until seperated
 */
/obj/item/gun/projectile/revolver/lombardi
	name = "Lombardi Buzzard"
	desc = "A rugged revolver that is mostly used by small law enforcement agencies across the frontier as a cheap, reliable sidearm. Uses .357 rounds."
	icon_state = "lombardi_police"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)

/obj/item/gun/projectile/revolver/lombardi/panther
	name = "Lombardi Panther"
	icon_state = "lombardi_panther"

/obj/item/gun/projectile/revolver/lombardi/gold
	name = "Lombardi Deluxe 2502"
	desc = "A sweet looking revolver that is decorated with false gold and silver plating. Favored among by gamblers and criminals alike. Uses .357 rounds."
	icon_state = "lombardi_gold"

/*
 * Captain's Peacekeeper
 */
/obj/item/gun/projectile/revolver/cappeacekeeper
	name = "decorated peacekeeper"
	desc = "A MarsTech Frontiersman revolver that has been heavily modified. It has been decorated for personal use by command officers. Uses .44 rounds."
	description_fluff = "The leading civilian-sector high-quality small arms brand of Hephaestus Industries, \
	MarsTech has been the provider of choice for law enforcement and security forces for over 300 years."
	icon_state = "captains_peacemaker"
	caliber = ".44"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/a44

/*
 * Mateba
 */
/obj/item/gun/projectile/revolver/mateba
	name = "mateba"
	desc = "This unique looking handgun is named after an Italian company famous for the original manufacture of \
	these revolvers, and pasta kneading machines. Uses .357 rounds." // Yes I'm serious. -Spades
	icon_state = "mateba"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)

/*
 * Deckard (Blade Runner)
 */
/obj/item/gun/projectile/revolver/deckard
	name = "\improper \"Deckard\" .38"
	desc = "A custom-built revolver, based off the semi-popular Detective Special model. Uses .38-Special rounds."
	icon_state = "deckard-empty"
	caliber = ".38"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/a38
	move_delay = 0 // CHOMPEdit: Pistols have move_delay of 0

/obj/item/gun/projectile/revolver/deckard/emp
	ammo_type = /obj/item/ammo_casing/a38/emp


/obj/item/gun/projectile/revolver/deckard/update_icon()
	..()
	if(loaded.len)
		icon_state = "deckard-loaded"
	else
		icon_state = "deckard-empty"

/obj/item/gun/projectile/revolver/deckard/load_ammo(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/ammo_magazine))
		flick("deckard-reload",src)
	..()

/*
 * Judge
 */
/obj/item/gun/projectile/revolver/judge
	name = "\"The Judge\""
	desc = "A revolving hand-shotgun by Jindal Arms that packs the power of a 12 guage in the palm of your hand (if you don't break your wrist). Uses 12g rounds."
	description_fluff = "While wholly owned by Hephaestus Industries, the Jindal Arms brand does not appear \
	prominently in most company catalogues (Perhaps owing to its less than prestigious image), \
	instead being sold almost exclusively through retailers and advertising platforms targeting the \
	'independent roughneck' demographic."
	icon_state = "judge"
	caliber = "12g"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ILLEGAL = 4)
	max_shells = 5
	recoil = 2 // ow my fucking hand
	accuracy = -15 // smooth bore + short barrel = shit accuracy
	ammo_type = /obj/item/ammo_casing/a12g
	projectile_type = /obj/item/projectile/bullet/shotgun
	// ToDo: Remove accuracy debuf in exchange for slightly injuring your hand every time you fire it.

/*
 * Mako
 */
/obj/item/gun/projectile/revolver/lemat
	name = "Mako revolver"
	desc = "The Bishamonten P100 Mako is a 9 shot revolver with a secondary firing barrel loading shotgun shells. For when you really need something dead. A rare yet deadly collector's item. Uses .38-Special and 12g rounds depending on the barrel."
	description_fluff = "The Bishamonten Company operated from roughly 2150-2280 - the height of the first extrasolar colonisation boom - before filing for bankruptcy and selling off its assets to various companies that would go on to become today’s TSCs. \
	Focused on sleek ‘futurist’ designs which have largely fallen out of fashion but remain popular with collectors and people hoping to make some quick thalers from replica weapons. \
	Bishamonten weapons tended to be form over function - despite their flashy looks, most were completely unremarkable one way or another as weapons, and used very standard firing mechanisms - \
	the Mako was a notable exception, so original examples are much sought after."
	icon_state = "combatrevolver"
	item_state = "revolver"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	handle_casings = CYCLE_CASINGS
	max_shells = 9
	caliber = ".38"
	ammo_type = /obj/item/ammo_casing/a38
	projectile_type = /obj/item/projectile/bullet/pistol
	var/secondary_max_shells = 1
	var/secondary_caliber = "12g"
	var/secondary_ammo_type = /obj/item/ammo_casing/a12g
	var/flipped_firing = 0
	var/list/secondary_loaded = list()
	var/list/tertiary_loaded = list()


/obj/item/gun/projectile/revolver/lemat/Initialize(mapload)
	. = ..()
	for(var/i in 1 to secondary_max_shells)
		secondary_loaded += new secondary_ammo_type(src)

/obj/item/gun/projectile/revolver/lemat/verb/swap_firingmode()
	set name = "Swap Firing Mode"
	set category = "Object"
	set desc = "Click to swap from one method of firing to another."

	var/mob/living/carbon/human/M = usr
	if(!M.mind)
		return 0

	to_chat(M, span_notice("You change the firing mode on \the [src]."))
	if(!flipped_firing)
		if(max_shells && secondary_max_shells)
			max_shells = secondary_max_shells

		if(caliber && secondary_caliber)
			caliber = secondary_caliber

		if(ammo_type && secondary_ammo_type)
			ammo_type = secondary_ammo_type

		if(secondary_loaded)
			tertiary_loaded = loaded.Copy()
			loaded = secondary_loaded

		flipped_firing = 1

	else
		if(max_shells)
			max_shells = initial(max_shells)

		if(caliber && secondary_caliber)
			caliber = initial(caliber)

		if(ammo_type && secondary_ammo_type)
			ammo_type = initial(ammo_type)

		if(tertiary_loaded)
			secondary_loaded = loaded.Copy()
			loaded = tertiary_loaded

		flipped_firing = 0

/obj/item/gun/projectile/revolver/lemat/spin_cylinder()
	set name = "Spin cylinder"
	set desc = "Fun when you're bored out of your skull."
	set category = "Object"

	chamber_offset = 0
	visible_message(span_warning("\The [usr] spins the cylinder of \the [src]!"), \
	span_notice("You hear something metallic spin and click."))
	playsound(src, 'sound/weapons/revolver_spin.ogg', 100, 1)
	if(!flipped_firing)
		loaded = shuffle(loaded)
		if(rand(1,max_shells) > loaded.len)
			chamber_offset = rand(0,max_shells - loaded.len)

/obj/item/gun/projectile/revolver/lemat/examine(mob/user)
	. = ..()
	if(secondary_loaded)
		var/to_print
		for(var/round in secondary_loaded)
			to_print += round
		. += "It has a secondary barrel loaded with \a [to_print]"
	else
		. += "It has a secondary barrel that is empty."


/*
 * Webley (Bay Port)
 */
/obj/item/gun/projectile/revolver/webley
	name = "patrol revolver"
	desc = "A rugged top break revolver commonly issued to planetary law enforcement offices. Uses .44 magnum rounds."
	description_fluff = "The Heberg-Hammarstrom Althing is a simple, head-wearing revolver made with an anti-corrosive alloy. \
	The Althing is advertised as being 'able to survive six months on the bottom of a frozen river and emerge full ready to \
	save a life'. Issued as standard sidearms to SifGuard frontier patrol."
	icon_state = "webley2"
	item_state = "webley2"
	caliber = ".44"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	handle_casings = CYCLE_CASINGS
	ammo_type = /obj/item/ammo_casing/a44

/*
 * Webley (Eris Port)
 */
/obj/item/gun/projectile/revolver/consul
	name = "\improper \"Consul\" Revolver"
	desc = "Are you feeling lucky, punk? Uses .44 rounds."
	icon_state = "inspector"
	item_state = "revolver"
	caliber = ".44"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	handle_casings = CYCLE_CASINGS
	ammo_type = /obj/item/ammo_casing/a44/rubber

/obj/item/gun/projectile/revolver/consul/proc/update_charge()
	cut_overlays()
	if(loaded.len==0)
		add_overlay("inspector_off")
	else
		add_overlay("inspector_on")

/obj/item/gun/projectile/revolver/consul/update_icon()
	update_charge()
