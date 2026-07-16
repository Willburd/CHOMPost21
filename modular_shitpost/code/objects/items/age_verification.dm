/obj/item/orb_that_kills_old_people
	name = "orb that kills old people"
	desc = "dated shut up boomer meme here"

/obj/item/orb_that_kills_old_people/proc/r_u_old(mob/living/carbon/human/boomer)
	if(H.age >= 60)
		H.dust()
		QDEL(src) //Only one person per orb
		return TRUE
	return FALSE

/obj/item/orb_that_kills_old_people/apply_hit_effect(mob/living/target, mob/living/user, hit_zone, attack_modifier)
	if(!ishuman(target))
		return

	var/mob/living/carbon/human/H = target
	if(r_u_old(target))
		user.visible_message("[user] strikes [target] with \the [src], and [target.they()] instantaneously flash into a pile of ash and bones!")


/obj/item/orb_that_kills_old_people/throw_impact(atom/hit_atom)
	. = ..()
	if(ishuman(hit_atom))
		if(r_u_old(hit_atom))
			visible_message("[src] hits [hit_atom], and [hit_atom.they()] instantaneously flash into a pile of ash and bones!")

/obj/item/orb_that_kills_old_people/Crossed(mob/living/M)
	. = ..()
	if(ishuman(M))
		if(r_u_old(M))
			visible_message("[M] steps on \the [src] and [M.they()] instantaneously flashes into a pile of ash and bones!")
