#define ADD_NOTICE(n,i,s)\
	P = new();\
	P.name = n;\
	P.info = i;\
	if(s && islist(s))\
	{\
		P.stamped = s;\
		for(var/path in P.stamped)\
		{\
			var/obj/item/stamp/SP = new path(src);\
			SP.add_overlay("paper_[SP.icon_state]");\
			qdel(SP);\
		}\
	}\
	src.contents += P;\

/obj/structure/noticeboard/anomaly
	name = "xenoarchaeology notice board"

/obj/structure/noticeboard/anomaly/Initialize()
	. = ..()


/obj/structure/noticeboard/medical
	name = "medical notice board"
	icon_state = "nboard02"

/obj/structure/noticeboard/medical/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Patient rooms","<br>No matter how many times I've said this, it doesn't seem to stick, so I'm leaving this reminder: Screwing patients in the patient rooms is a serious breach of professionality and your code of ethics. Take it to the dorms.",list(/obj/item/stamp/cmo))
	ADD_NOTICE("Staff Notice: Breakroom \& Storage","<br>Enjoy the view from the new breakroom. You've also got a storage room full of leftover supplies from the shift before yours.",null)
	. = ..()


/obj/structure/noticeboard/toxins
	name = "toxins lab notice board"
	icon_state = "nboard01"

/obj/structure/noticeboard/toxins/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Toxins Mixing","<br>Toxins Mixing is currently shut down for the time being, due to damage requiring parts from off station to fix. Please do not use at this time, or risk setting the entire outpost on fire.",list(/obj/item/stamp/rd))
	. = ..()


/obj/structure/noticeboard/library
	icon_state = "nboard02"

/obj/structure/noticeboard/library/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Library Warning: coffee stains","<br>I seem to tell you guys this daily, but please, stop bringing coffee to carpeted areas. It's hard enough to get the stains off wood,let alone carpet.",null)
	ADD_NOTICE("Library Warning: loud noises","Ssshh!<br>People are trying to read in the library, stop bringing the jukebox over there!",null)
	. = ..()


/obj/structure/noticeboard/exploration
	icon_state = "nboard03"

/obj/structure/noticeboard/exploration/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Memo: Prototype ship","<br> With the lost of our last Research installation and the damage sustained to the old exploration shuttle,We've decided to finally approve the construction of the Prototype Star-Runner class Exploration Vessel. Keep in mind it's a prototype, so try not to scratch it's paint. We don't have a second.",list(/obj/item/stamp/centcomm))
	ADD_NOTICE("Memo RE: Expedition Requirements","Jones,<br>For the last time, Expeditions regulations require atleast three crew members, including the Pathfinder and/or Research Director. The next time you activate your bluespace drive with less then that, and you're fired from the department.I won't have this conversation again. <br>- R.F",list(/obj/item/stamp/rd))
	ADD_NOTICE("Memo RE: Pilot duties","Pilots, As you're fully aware, we're on the edge of civilized space out here. <br> Leaving the shuttle area is dangerious. This is why the Prototype is equipped with a proper camera system to keep an eye on the explorers. If you get yourselves killed, and an explorer has to crash land the ship back here, the company is NOT going to be happy.<br>- R.F",list(/obj/item/stamp/rd))
	. = ..()

#undef ADD_NOTICE
