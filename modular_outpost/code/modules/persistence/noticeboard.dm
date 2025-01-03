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
	contents += P;\
	icon_state = "nboard0[contents.len > 5 ? 5 : contents.len]";


/obj/structure/noticeboard/bridge
	name = "Command notice board"

/obj/structure/noticeboard/bridge/Initialize()
	. = ..()


/obj/structure/noticeboard/cargo
	name = "Cargo notice board"
	icon_state = "nboard04"

/obj/structure/noticeboard/cargo/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: STOP GETTING CAUGHT","<br>B shift, this one's for you: you're not supposed to be stealing from other departments, drop the cargonia shit. Or at least stop getting CAUGHT.",list(/obj/item/stamp/qm))
	ADD_NOTICE("Staff Notice: Sell your stuff","<br>You have a vending machine in the front. Cargo points aren't free anymore, sell the stuff you 'find', use the thalers from it to get cargo points directly.",list(/obj/item/stamp/qm))
	ADD_NOTICE("Staff Notice: Points","<br>Cargo points don't fill automatically, Central wants us to ship off useful things.<br>Tug tanks full of medicines, organs, materials, slime cores, vaccines, straight thalers, salvage, that kind of stuff. Make sure they're packaged right in crates and ship 'em off. <br>Oh and get those manifests back from stuff people order! Those sell too, after you stamp them.",list(/obj/item/stamp/qm))
	ADD_NOTICE("Containers","<br>There's a bunch of connexes in the storage yard outside, all three shifts leave stuff there from time to time, and extra shipment stuff. Go rummaging through those.",null)
	. = ..()


/obj/structure/noticeboard/engineering
	name = "engineering notice board"
	icon_state = "nboard02"

/obj/structure/noticeboard/engineering/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Wires","<br>I don't know who needs to hear this, but you can recolor wire sets with a multitool, and fix frayed wires with ducttape. <br>Oh also, you can pick up your cut wires quicker by just shuffling around the bundle first, then scooping up the whole thing.",null)
	ADD_NOTICE("Staff Notice: Fireaxe","<br>I don't know who, but don't let me find out. Stop stealing the damn fireaxe out of atmospherics. It is there EXCLUSIVELY for emergencies, such as needing to smash windows to vent a fire. If I find it missing or blood-soaked again, I will find out who you are, and we're gunna have words.",list(/obj/item/stamp/ce))
	. = ..()


/obj/structure/noticeboard/exploration
	icon_state = "nboard01"

/obj/structure/noticeboard/exploration/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Mining Trawler","<br>The mining trawler is a big beast of a ship meant for taking up to the orbital rec-yard, or other derelicts. <br>Don't hog the damn thing. Take Science with you so they can gather artifacts, take Sec because some of those wrecks are active, that kind of thing. <br>There's a role for everyone up there. Don't be selfish.",list(/obj/item/stamp/qm))
	. = ..()


/obj/structure/noticeboard/janitor
	name = "Janitorial notice board"
	icon_state = "nboard01"

/obj/structure/noticeboard/janitor/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Cleaning","<br>Yo, departments have to keep themselves clean. Help if you wanna, but you don't gotta. Just keep the civilian areas nice and slick. <br>Also, if you're from another station, we answer to the QM here, not the HoP. So, make friends, bring them trash to recycle, that kinda thing. <br>Cargo IS your department to clean, though.",null)
	. = ..()


/obj/structure/noticeboard/library
	icon_state = "nboard01"

/obj/structure/noticeboard/library/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Bingle","<br>Our libary has received a computer with authorized Bingle usage! Use it to research anything and everything, it's a very handy wiki, and always up to date.<br> If the computer crashes just give it a wack, it's old tech.",null)
	. = ..()


/obj/structure/noticeboard/medical
	name = "medical notice board"
	icon_state = "nboard04"

/obj/structure/noticeboard/medical/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Engineered Organs","<br>We got our bioprinter updated with the new model, this'll let you grow organ lattices. <br>Keep them in a fed patient until they're a proto-organ, take them out, inject them with meds; it should respond well, put them back in and irradiate them.<br> Central loves these, so hit up cargo for extras you grow!",list(/obj/item/stamp/cmo))
	ADD_NOTICE("Staff Notice: In-depth checks","<br>Remember to check the body scan THOROUGHLY! Check for additional organs, and check breathing types if the cause of ailments isn't obvious. Not everything is in big flashing red text, do your jobs!",null)
	ADD_NOTICE("Staff Notice: Genetic resets", "<br>Hey, our resleeving equipment got updated. If someone comes in and their genetics are all messed up from radiation, landmines, or your own screwing around in the genetics lab. You can use it to print a reset injector.",list(/obj/item/stamp/cmo))
	ADD_NOTICE("Memo: Taaa", "<br>C shift: you might encounter a Teshari known as Taaa. Familiarize yourself with his medical records (you should be doing this with ALL your patients), use extreme care IF you treat him, do not approach him with a needle, let HIM come to YOU. PS: He has restraining orders against certain medical staff, please respect those.",list(/obj/item/stamp/cmo))
	. = ..()


/obj/structure/noticeboard/phoronics
	name = "Phoronics lab notice board"
	icon_state = "nboard01"

/obj/structure/noticeboard/phoronics/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Phoronics","<br>Use caution in phoronics. We're looking at getting explosion-reactive crystals ordered in, and getting central to accept explosives for cargo payment. Be safe when experimenting. <br> For now, mining loves bomb-mining, just make sure they only off them OFF-WORLD.",list(/obj/item/stamp/rd))
	. = ..()


/obj/structure/noticeboard/research
	name = "Research notice board"
	icon_state = "nboard01"

/obj/structure/noticeboard/research/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Long Term Storage","<br>The material storage in the RnD is emptied every shift, if you want to save your materials for the next shift, go downstairs into long-term storage. Put them in there!",list(/obj/item/stamp/rd))
	. = ..()


/obj/structure/noticeboard/security
	name = "Security notice board"
	icon_state = "nboard03"

/obj/structure/noticeboard/security/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Staff Notice: Armored Asset Vehicles","<br>Security forces, in the red armory you'll find a ladder. That ladder takes you to the garage. Use that to store impounded vehicles <br>There's two armored vehicles down there, the tank and APC. Keys are in HoS office and Warden's office respectively, use them however you see fit on code red. Ask a senior if you need driving lessons.",list(/obj/item/stamp/hos))
	ADD_NOTICE("Memo: SoP","<br>Review your SoP, found in your PDA. E-Shui is starting to crack down on this, understand we're different than NT. Make sure crew are aware; IGNORANCE IS NOT AN EXCUSE!",list(/obj/item/stamp/hos))
	ADD_NOTICE("Staff Notice: Document Your Arrests!","<br>Document your arrests, stop letting crew run around with empty records and no evidence you had to slap their wrist, especially for severe things! <br>This is on you, if they don't get permanent records, so do your jobs.",list(/obj/item/stamp/ward))
	. = ..()


/obj/structure/noticeboard/stowaway
	name = "Forgotten notice board"
	icon_state = "nboard05"

/obj/structure/noticeboard/stowaway/Initialize()
	var/obj/item/paper/P
	ADD_NOTICE("Drawing: Traps","<br>On the paper is a crudely drawn image of a raptor-like creature. They appear to be kneeling down and inspecting in front of them. <br>In front of them is a small box with a laser coming from it, a bear trap, and a frayed wire sparking angrily. The raptor appears to be drawing an 'X' on the floor",null)
	ADD_NOTICE("Drawing: Walls","<br>On the paper is a crudely drawn image of a raptor-like creature. The creature appears to be drawing an arrow on the ground, pointing towards a section of wall they're pushing back into place. The wall section appears to be dislodged somehow.",null)
	ADD_NOTICE("Drawing: Borgs","<br>On the paper is a crudely drawn image of a raptor-like creature, and a dogborg. The dogborg looms in the distance with a menacing aura, the raptor is running and hiding from the dogborg. Images of 'X' and skulls surround the borg.",null)
	ADD_NOTICE("Drawing: Menace","<br>On the paper is a horrifying visage of a ghoulish face. The surrounding paper is scribbled with attempts of drawing... something. The drawing seems to radiate menace, but you're not even sure what it's trying to warn you of.",null)
	ADD_NOTICE("Drawing: Rest","<br>On the paper is a crudely drawn image of a raptor-like creature, they appear to be laying in a bed with closed eyes. A detailed smile can be seen drawn on the floor of the image. The image appears to display peace and safety.",null)
	. = ..()


#undef ADD_NOTICE
