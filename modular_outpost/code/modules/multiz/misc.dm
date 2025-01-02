// Invisible object that blocks z transfer to/from its turf and the turf above.
/obj/effect/auto_roof
	icon = 'icons/mob/screen1.dmi'
	icon_state = "centermarker"
	var/roof_type // roof placed over tile
	invisibility = 101 // nope cant see this

/obj/effect/auto_roof/Initialize()
	var/turf/T = get_turf(src)
	T.outdoors = OUTDOORS_NO
	if (!T || !roof_type)
		return
	if(HasAbove(T.z))
		var/turf/TA = GetAbove(T)
		if(!istype(TA, roof_type))
			TA.ChangeTurf(roof_type, TRUE, TRUE, TRUE)
	del(src)
