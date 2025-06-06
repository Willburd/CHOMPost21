/*	Photography!
 *	Contains:
 *		Camera
 *		Camera Film
 *		Photos
 *		Photo Albums
 */

/*******
* film *
*******/
/obj/item/camera_film
	name = "film cartridge"
	icon = 'icons/obj/items.dmi'
	desc = "A camera film cartridge. Insert it into a camera to reload it."
	icon_state = "film"
	item_state = "camera"
	w_class = ITEMSIZE_TINY


/********
* photo *
********/
GLOBAL_VAR_INIT(photo_count, 0)

/obj/item/photo
	name = "photo"
	icon = 'icons/obj/items.dmi'
	icon_state = "photo"
	item_state = "paper"
	w_class = ITEMSIZE_SMALL
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'
	var/id
	var/icon/img	//Big photo image
	var/scribble	//Scribble on the back.
	var/icon/tiny
	var/photo_size = 3

/obj/item/photo/Initialize(mapload)
	. = ..()
	id = GLOB.photo_count++

/obj/item/photo/attack_self(mob/user as mob)
	user.examinate(src)

/obj/item/photo/attackby(obj/item/P as obj, mob/user as mob)
	if(istype(P, /obj/item/pen))
		var/txt = sanitize(tgui_input_text(user, "What would you like to write on the back?", "Photo Writing", null, 128), 128)
		if(loc == user && user.stat == 0)
			scribble = txt
	..()

/obj/item/photo/examine(mob/user)
	//This is one time we're not going to call parent, because photos are 'secret' unless you're close enough.
	SHOULD_CALL_PARENT(FALSE)
	if(in_range(user, src))
		show(user)
		return list(desc)
	else
		return list(span_notice("It is too far away to examine."))

/obj/item/photo/proc/show(mob/user as mob)
	user << browse_rsc(img, "tmp_photo_[id].png")
	user << browse("<html><head><title>[name]</title></head>" \
		+ "<body style='overflow:hidden;margin:0;text-align:center'>" \
		+ "<img src='tmp_photo_[id].png' width='[64*photo_size]' style='-ms-interpolation-mode:nearest-neighbor' />" \
		+ "[scribble ? "<br>Written on the back:<br><i>[scribble]</i>" : ""]"\
		+ "</body></html>", "window=book;size=[64*photo_size]x[scribble ? 400 : 64*photo_size]")
	onclose(user, "[name]")
	return

/obj/item/photo/verb/rename()
	set name = "Rename photo"
	set category = "Object"
	set src in usr

	var/n_name = sanitizeSafe(tgui_input_text(usr, "What would you like to label the photo?", "Photo Labelling", null, MAX_NAME_LEN), MAX_NAME_LEN)
	//loc.loc check is for making possible renaming photos in clipboards
	if(( (loc == usr || (loc.loc && loc.loc == usr)) && usr.stat == 0))
		name = "[(n_name ? text("[n_name]") : "photo")]"
	add_fingerprint(usr)
	return


// Outpost 21 addition begin - The image of a...
/obj/item/photo/proc/statue_curse(var/user)
	var/t = rand(260, 560) SECONDS
	log_admin("[user] took a picture of an angel statue. It will spawn a statue in: [t / (1 SECOND)] seconds.")
	addtimer(CALLBACK(src, PROC_REF(statue_spawn)), t)

/obj/item/photo/proc/statue_spawn()
	if(statue_photos_allowed <= 0)
		return
	if(!QDELETED(src))
		var/turf/T = get_turf(src)
		if(isturf(T))
			visible_message("\The [src] flickers.")
			spawn(10)
				if(!QDELETED(src))
					visible_message("\The [src] shakes.")
					T = get_turf(src)
					if(isturf(T))
						for(var/obj/machinery/light/L in oview(12, T))
							L.flicker(rand(20, 50))
							spawn(rand(15,50))
								if(prob(80))
									L.broken()
			spawn(13)
				if(!QDELETED(src))
					T = get_turf(src)
					if(isturf(T))
						new /mob/living/simple_mob/animal/statue(T)
						statue_photos_allowed--
					desc += span_cult("Part of the photo is smeared unnaturally.")
// Outpost 21 edit end


/**************
* photo album *
**************/
/obj/item/storage/photo_album
	name = "Photo album"
	icon = 'icons/obj/items.dmi'
	icon_state = "album"
	item_state = "briefcase"
	can_hold = list(/obj/item/photo)

/obj/item/storage/photo_album/MouseDrop(obj/over_object as obj)

	if(ishuman(usr))
		var/mob/living/carbon/human/M = usr
		if(!( istype(over_object, /obj/screen) ))
			return ..()
		playsound(src, "rustle", 50, 1, -5)
		if((!( M.restrained() ) && !( M.stat ) && M.back == src))
			switch(over_object.name)
				if("r_hand")
					M.unEquip(src)
					M.put_in_r_hand(src)
				if("l_hand")
					M.unEquip(src)
					M.put_in_l_hand(src)
			add_fingerprint(usr)
			return
		if(over_object == usr && in_range(src, usr) || usr.contents.Find(src))
			if(usr.s_active)
				usr.s_active.close(usr)
			show_to(usr)
			return
	return

/*********
* camera *
*********/
/obj/item/camera
	name = "camera"
	icon = 'icons/obj/items.dmi'
	desc = "A polaroid camera. 10 photos left."
	icon_state = "camera"
	item_state = "camera"
	w_class = ITEMSIZE_SMALL
	slot_flags = SLOT_BELT
	matter = list(MAT_STEEL = 2000)
	var/pictures_max = 10
	var/pictures_left = 10
	var/on = 1
	var/icon_on = "camera"
	var/icon_off = "camera_off"
	var/size = 3
	var/list/picture_planes = list()

/obj/item/camera/verb/change_size()
	set name = "Set Photo Focus"
	set category = "Object"
	var/nsize = tgui_input_list(usr, "Photo Size","Pick a size of resulting photo.", list(1,3,5,7))
	if(nsize)
		size = nsize
		to_chat(usr, span_notice("Camera will now take [size]x[size] photos."))

/obj/item/camera/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/camera/attack_self(mob/user as mob)
	on = !on
	if(on)
		src.icon_state = icon_on
	else
		src.icon_state = icon_off
	to_chat(user, "You switch the camera [on ? "on" : "off"].")
	return

/obj/item/camera/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/camera_film))
		if(pictures_left)
			to_chat(user, span_notice("[src] still has some film in it!"))
			return
		to_chat(user, span_notice("You insert [I] into [src]."))
		user.drop_item()
		qdel(I)
		pictures_left = pictures_max
		return
	..()


/obj/item/camera/proc/get_icon(list/turfs, turf/center)

	//Bigger icon base to capture those icons that were shifted to the next tile
	//i.e. pretty much all wall-mounted machinery
	var/icon/res = icon('icons/effects/96x96.dmi', "")
	res.Scale(size*32, size*32)
	// Initialize the photograph to black.
	res.Blend("#000", ICON_OVERLAY)

	var/atoms[] = list()
	for(var/turf/the_turf in turfs)
		// Add outselves to the list of stuff to draw
		atoms.Add(the_turf);
		// As well as anything that isn't invisible.
		for(var/atom/A in the_turf)
			// Outpost 21 edit begin - allow ghosts into photos
			if(!istype(A,/mob/observer/dead))
				if(A.invisibility) continue
				if(A.plane > 0 && !(A.plane in picture_planes)) continue
			else
				var/mob/observer/dead/G = A
				if(G.admin_ghosted) continue // Hide Aghosts
				SShaunting.influence(HAUNTING_GHOSTS) // IT DA SPOOKY STATION!
			atoms.Add(A)
			// Outpost 21 edit end

	// Sort the atoms into their layers
	var/list/sorted = sort_atoms_by_layer(atoms)
	var/center_offset = (size-1)/2 * 32 + 1
	for(var/i; i <= sorted.len; i++)
		var/atom/A = sorted[i]
		if(A)
			var/icon/img = getFlatIcon(A, no_anim = TRUE)//, picture_planes = picture_planes)//build_composite_icon(A) //VOREStation Edit

			// If what we got back is actually a picture, draw it.
			if(istype(img, /icon))
				// Check if we're looking at a mob that's lying down
				if(isliving(A) && A:lying)
					// If they are, apply that effect to their picture.
					img.BecomeLying()
				// Calculate where we are relative to the center of the photo
				var/xoff = (A.x - center.x) * 32 + center_offset
				var/yoff = (A.y - center.y) * 32 + center_offset
				if (istype(A,/atom/movable))
					xoff+=A:pixel_x
					yoff+=A:pixel_y
				res.Blend(img, blendMode2iconMode(A.blend_mode),  A.pixel_x + xoff, A.pixel_y + yoff)

	// Lastly, render any contained effects on top.
	for(var/turf/the_turf in turfs)
		// Calculate where we are relative to the center of the photo
		var/xoff = (the_turf.x - center.x) * 32 + center_offset
		var/yoff = (the_turf.y - center.y) * 32 + center_offset
		res.Blend(getFlatIcon(the_turf.loc, no_anim = TRUE), blendMode2iconMode(the_turf.blend_mode),xoff,yoff)
	return res


/obj/item/camera/proc/get_mobs(turf/the_turf as turf)
	var/mob_detail
	// Outpost 21 edit begin - ghosts in photos, and statues
	for(var/atom/S in the_turf)
		if(isobserver(S))
			// hide observers that are not ghosts
			var/mob/observer/dead/G = S;
			if(!G.is_dead()) continue
			if(G.admin_ghosted) continue // Hide Aghosts
			// add ghost description
			if(!mob_detail)
				mob_detail = "You can see a faded [G] on the photo."
			else
				mob_detail += "You can also see a faded [G] on the photo."

		// add carbon descriptions
		if(iscarbon(S))
			var/mob/living/carbon/A = S
			var/holding = null
			if(A.l_hand || A.r_hand)
				if(A.l_hand) holding = "They are holding \a [A.l_hand]"
				if(A.r_hand)
					if(holding)
						holding += " and \a [A.r_hand]"
					else
						holding = "They are holding \a [A.r_hand]"

			if(!mob_detail)
				mob_detail = "You can see [A] on the photo[(A:health / A.getMaxHealth()) < 0.75 ? " - [A] looks hurt":""].[holding ? " [holding]":"."]. "
			else
				mob_detail += "You can also see [A] on the photo[(A:health / A.getMaxHealth()) < 0.75 ? " - [A] looks hurt":""].[holding ? " [holding]":"."]."

		// What a cursed photo
		if(istype(S,/mob/living/simple_mob/animal/statue))
			if(!mob_detail)
				mob_detail = "You can see a statue of an angel on the photo."
			else
				mob_detail += "You can also see a statue of an angel on the photo."
	// Outpost 21 edit end
	return mob_detail

/obj/item/camera/afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
	if(!on || !pictures_left || ismob(target.loc)) return
	captureimage(target, user, flag)

	playsound(src, pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)

	pictures_left--
	desc = "A polaroid camera. It has [pictures_left] photos left."
	to_chat(user, span_notice("[pictures_left] photos left."))
	icon_state = icon_off
	on = 0
	spawn(64)
		icon_state = icon_on
		on = 1

/obj/item/camera/proc/can_capture_turf(turf/T, mob/user)
	var/viewer = user
	if(user.client)		//To make shooting through security cameras possible
		viewer = user.client.eye
	var/can_see = (T in view(viewer))

	return can_see

/obj/item/camera/proc/captureimage(atom/target, mob/user, flag)
	var/x_c = target.x - (size-1)/2
	var/y_c = target.y + (size-1)/2
	var/z_c	= target.z
	var/list/turfs = list()
	var/mobs = ""
	var/statue = FALSE // Outpost 21 addition - The image of a...
	for(var/i = 1 to size)
		for(var/j = 1 to size)
			var/turf/T = locate(x_c, y_c, z_c)
			if(can_capture_turf(T, user))
				turfs.Add(T)
				mobs += get_mobs(T)
				// Outpost 21 addition begin - The image of a...
				if(locate(/mob/living/simple_mob/animal/statue) in T.contents)
					statue = TRUE
				// Outpost 21 addition end
			x_c++
		y_c--
		x_c = x_c - size

	var/obj/item/photo/p = createpicture(target, user, turfs, mobs, flag)
	// Outpost 21 addition begin - The image of a...
	if(statue)
		p.statue_curse(user)
	// Outpost 21 addition end

	printpicture(user, p)

/obj/item/camera/proc/createpicture(atom/target, mob/user, list/turfs, mobs, flag)
	var/icon/photoimage = get_icon(turfs, target)

	var/icon/small_img = icon(photoimage)
	var/icon/tiny_img = icon(photoimage)
	var/icon/ic = icon('icons/obj/items.dmi',"photo")
	var/icon/pc = icon('icons/obj/bureaucracy.dmi', "photo")
	small_img.Scale(8, 8)
	tiny_img.Scale(4, 4)
	ic.Blend(small_img,ICON_OVERLAY, 10, 13)
	pc.Blend(tiny_img,ICON_OVERLAY, 12, 19)

	var/obj/item/photo/p = new()
	p.name = "photo"
	p.icon = ic
	p.tiny = pc
	p.img = photoimage
	p.desc = mobs
	p.pixel_x = rand(-10, 10)
	p.pixel_y = rand(-10, 10)
	p.photo_size = size
	return p

/obj/item/camera/proc/printpicture(mob/user, obj/item/photo/p)
	p.loc = user.loc
	if(!user.get_inactive_hand())
		user.put_in_inactive_hand(p)

/obj/item/photo/proc/copy(var/copy_id = 0)
	var/obj/item/photo/p = new/obj/item/photo()

	p.name = name
	p.icon = icon(icon, icon_state)
	p.tiny = icon(tiny)
	p.img = icon(img)
	p.desc = desc
	p.pixel_x = pixel_x
	p.pixel_y = pixel_y
	p.photo_size = photo_size
	p.scribble = scribble

	if(copy_id)
		p.id = id

	return p
