/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/banana_mortar
	name = "Banana Mortar"
	icon = 'icons/mecha/mecha_equipment_vr.dmi'
	icon_state = "mecha_bananamrtr"
	projectile = /obj/item/bananapeel
	fire_sound = 'sound/items/bikehorn.ogg'
	projectiles = 15
	missile_speed = 1.5
	projectile_energy_cost = 100
	equip_cooldown = 1 SECOND
	equip_type = EQUIP_WEAPON

/obj/item/mecha_parts/mecha_equipment/weapon/honker
	name = "\improper HoNkER BlAsT 5000"
	icon = 'icons/mecha/mecha_equipment_vr.dmi'
	icon_state = "mecha_honker"
	energy_drain = 200
	equip_cooldown = 15 SECONDS
	range = MELEE|RANGED
	equip_type = EQUIP_WEAPON

/obj/item/mecha_parts/mecha_equipment/weapon/honker/action(target)
	if(!chassis)
		return 0
	if(energy_drain && chassis.get_charge() < energy_drain)
		return 0
	if(!equip_ready)
		return 0

	set_ready_state(FALSE)
	playsound(chassis, 'sound/items/AirHorn.ogg', 100, 1)
	chassis.occupant_message(span_danger(span_giant("HONK")))
	for(var/mob/living/carbon/M in ohearers(6, chassis))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.l_ear, /obj/item/clothing/ears/earmuffs) || istype(H.r_ear, /obj/item/clothing/ears/earmuffs))
				continue
		to_chat(M, span_danger(span_massive("HONK")))
		M.sleeping = 0
		M.stuttering += 20
		M.ear_deaf += 30
		M.deaf_loop.start()
		M.Weaken(3)
		if(prob(30))
			M.Stun(10)
			M.Paralyse(4)
		else
			M.make_jittery(500)
	chassis.use_power(energy_drain)
	do_after_cooldown()
	return
