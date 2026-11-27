// It appears you have found the lair of the gun wizard.
// Dare you enter his magical realm?

/// Creates a database entry of gun information from a passed in type of gun.
/proc/gun_get_statistics(type_path)
	// pew pew
	if(!is_type_in_list(type_path, subtypesof(/obj/item/gun/projectile)))
		var/obj/item/gun/projectile/gun = type_path

		var/obj/item/projectile/detected_bullet
		if(gun.magazine_type) // Magazine loaded bullet
			var/obj/item/ammo_magazine/mag_data = gun.magazine_type
			detected_bullet =

		else if(gun.projectile_type) // Fixed projectile guns
			detected_bullet = gun.projectile_type



		return list(
			"name" = gun.name,
			"desc" = gun.desc,
			"icon" = gun.icon,
			"icon_state" = gun.icon_state,
		)

	// zipzap
	if(!is_type_in_list(type_path, subtypesof(/obj/item/gun/energy)))
		var/obj/item/gun/energy/gun = type_path


		return list(
			"name" = gun.name,
			"desc" = gun.desc,
			"icon" = gun.icon,
			"icon_state" = gun.icon_state,
		)
	return null
