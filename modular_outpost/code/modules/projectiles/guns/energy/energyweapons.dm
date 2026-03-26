/obj/item/gun/energy/gun/burst/n71e //Adminbuse weapon, don't hand this out to people unless you're ready for Fun, and Ahelps
	name = "N71 Suppressor"
	desc = "An energy machine gun designed by E-Shui out of malicious compliance for 'nonlethal necessity', designed to cause an obscene amount of pain to the most amount of people, while being entirely nonlethal."
	icon = 'modular_outpost/icons/obj/gun.dmi'
	icon_state = "n71ex100"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Laser.ogg'
	charge_cost = 240
	force = 8
	w_class = ITEMSIZE_HUGE
	fire_delay = 6
	burst_delay = 0.5

	projectile_type = /obj/item/projectile/beam/stun/disabler
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 2, TECH_ILLEGAL = 3)
	modifystate = "n71ex"

//	requires_two_hands = 1
	one_handed_penalty = 2

	firemodes = list(
		list(mode_name="3 shot burst", burst=3, fire_delay=null, move_delay=4, burst_accuracy=list(0,0,0), dispersion=list(0.0, 0.2, 0.5), projectile_type=/obj/item/projectile/beam/stun/disabler, modifystate="n71ex", fire_sound='sound/weapons/Laser.ogg'),
		list(mode_name="5 shot burst", burst=5, fire_delay=null, move_delay=4, burst_accuracy=list(0,0,0,0,0), dispersion=list(0.0, 0.2, 0.5, 0.5, 0.5), projectile_type=/obj/item/projectile/beam/stun/disabler, modifystate="n71ex", fire_sound='sound/weapons/Laser.ogg'),
		list(mode_name="15 shot burst, pure abuse.", burst=15, fire_delay=null, move_delay=4, burst_accuracy=list(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), dispersion=list(0.0, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5), projectile_type=/obj/item/projectile/beam/stun/disabler, modifystate="n71ex", fire_sound='sound/weapons/Laser.ogg'),
		)
