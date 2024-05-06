/obj/machinery/hologram/holo_tutorial
	name = "\improper Tutorial holopad"
	desc = "It's a floor-mounted device for projecting holographic images. It activates when you get close to it."
	icon_state = "holopad0"
	show_messages = 1
	circuit = /obj/item/weapon/circuitboard/holopad
	plane = TURF_PLANE
	layer = ABOVE_TURF_LAYER
	idle_power_usage = 0
	use_power = USE_POWER_IDLE

	var/obj/effect/overlay/aiholo/holo
	var/loop_requests = 0
	var/holo_range = 5

	var/speechwait = 0
	var/speechphase = 0
	var/list/dialog = list("TEST1","TEST2")
	var/list/seen_names = list()
	var/speech_delay_seconds = 5

	var/holo_name = "Tutorial"
	var/holo_icon = 'icons/mob/AI.dmi'
	var/holo_state = "holo1"

/obj/machinery/hologram/holo_tutorial/attackby(obj/item/I as obj, user as mob)
	attack_hand(user)
	return

/obj/machinery/hologram/holo_tutorial/attack_hand(var/mob/living/carbon/human/user) //Carn: Hologram requests.
	if(!istype(user))
		return
	loop_requests = 1
	speechphase = 1
	speechwait = world.time + 1 SECOND
	if(!holo)
		create_holo()

/obj/machinery/hologram/holo_tutorial/attack_ai(mob/living/silicon/ai/user)
	return

/obj/machinery/hologram/holo_tutorial/process()
	if(world.time < speechwait)
		return

	if(speechphase > 0)
		if(!holo)
			create_holo()
			speechwait = world.time + 1 SECOND // startup
			return

		if(speechphase <= dialog.len)
			holo.visible_message("<b>\The [holo]</b> says, [dialog[speechphase]]")
			speechphase += 1
		else
			speechphase = 0
			clear_holo()

		speechwait = world.time + (speech_delay_seconds SECONDS)
		return

	// next iteration
	if(loop_requests > 0)
		speechphase = 1
		loop_requests -= 1
	else if(holo_range > 0)
		// trigger on nearby humans
		var/list/humans = human_mobs(holo_range)
		if(!humans.len)
			return

		// repeat if anyone in proximity has not heard it
		for(var/mob/living/carbon/human/H in humans)
			var/seenName = FALSE
			for(var/name in seen_names)
				if(H.name == name)
					seenName = TRUE
					break
			if(!seenName)
				seen_names.Add(H.name)
				loop_requests += 1
				speechwait = 0
				break

/obj/machinery/hologram/holo_tutorial/proc/create_holo(turf/T = loc)
	holo = new(T)//Spawn a blank effect at the location. //VOREStation Edit to specific type for adding vars
	holo.icon = getHologramIcon(icon(holo_icon,"[holo_state]"))
	holo.layer = FLY_LAYER//Above all the other objects/mobs. Or the vast majority of them.
	holo.anchored = TRUE//So space wind cannot drag it.
	holo.name = "[holo_name] (Hologram)"//If someone decides to right click.
	holo.set_light(2)	//hologram lighting
	set_light(2)			//pad lighting
	icon_state = "holopad1"
	flick("holopadload", src) //VOREStation Add
	holo.visible_message("A holographic image of [holo] flicks to life right before your eyes!")
	return 1

/obj/machinery/hologram/holo_tutorial/proc/clear_holo()
	set_light(0)			//pad lighting (hologram lighting will be handled automatically since its owner was deleted)
	icon_state = "holopad0"
	holo.Destroy()
	holo = null
	return 1



// Because I don't want to do these mapside, and they're generic enough anyway.
/obj/machinery/hologram/holo_tutorial/intro_1
	dialog = list(	"Hello, and welcome to the standardized employee orientation course. This virtual training course will ensure that you understand the basics of how to operate most, if not all, company equipment!",
					"Proceed through the door on your right, when you are ready to begin. All messages can be repeated, if you click on the holopad beneath me."
					)

/obj/machinery/hologram/holo_tutorial/intro_2
	dialog = list(	"Basic interaction, and you.",
					"In most cases, Left clicking on an object will perform its basic interaction. Such as opening a UI, or turning a switch on or off.",
					"Shift clicking will automatically examine an object or location! Examining will display important information about the object or location.",
					"Right clicking any object or location visible on your screen, will list all currently possible interactions with that object."
					)

/obj/machinery/hologram/holo_tutorial/intro_3
	dialog = list(	"Sometimes, objects will be hidden, or obscured by multiple other objects.",
					"Alt clicking, will show all objects currently in the location clicked, this list will appear at the top right of your window.",
					"Some objects also have interactions caused by alt clicking them. However, you will always be shown the list of objects in a location, as explained before.",
					"Please, pull the lever beneath the plastic flaps to continue."
					)

/obj/machinery/hologram/holo_tutorial/intro_4
	dialog = list(	"Some objects will have unique interactions, if you drag yourself, or another object onto it.",
					"For example, while standing next to railings like these, you can click and drag yourself onto them. This will allow you to climb over the railing."
					)

/obj/machinery/hologram/holo_tutorial/intro_5
	dialog = list(	"Object interaction, and your hands!",
					"At the bottom center of your screen is your hands, and what they are holding.",
					"When you click something, the object in your currently active hand will interact with what you click.",
					"If there is nothing in your hand, you will instead perform a basic interaction, as explained to you earlier!",
					"You can drop objects in your current active hand, by clicking the drop icon at the bottom right of your screen. You can also press Q.",
					"To swap your current active hand, click the background of the hand slot. You can also press X.",
					"Many objects will only respond to empty hands, or have unique interactions with specific objects.",
					"For example; The locker will only open and close if you use empty hands, and can be bolted and unbolted from the floor with a wrench."
					)

/obj/machinery/hologram/holo_tutorial/intro_6
	dialog = list(	"Clicking the throw icon, in the bottom right of your screen will make your next click throw the object in your active hand. You can also press R.",
					"If you are prepared to throw, and do not have anything in your hand. You will catch anything being thrown at you!"
					)

/obj/machinery/hologram/holo_tutorial/intro_7
	dialog = list(	"Small containers are a common sight on station. They are able to store multiple smaller objects, including other containers!",
					"You can open a container by picking it up, and clicking on it while it is in your active hand. A menu will appear above your hands, showing what is inside the container.",
					"Containers will also show this menu, if you alt-click them. Just like how you can see all the objects in a location by alt-clicking, as you were taught earlier.",
					"If you click a container with an object in your active hand, you will place it inside of the container.",
					"Try experimenting with the backpacks, boxes, and medical kits in this room, move on when you are comfortable with container interactions.",
					"Remember, if a container is already inside of another container or your are not beside that container, you will not be able to take items out from it or put items into it."
					)

/obj/machinery/hologram/holo_tutorial/intro_8
	dialog = list(	"Intents, and how to stop beating yourself to death with a candybar!",
					"In the bottom right of your screen, there are four colored boxes. This is your intent menu.",
					"The four intents are: GREEN, help; BLUE, disarm; YELLOW, grab; RED, harm.",
					"You can click each intent at the bottom of your screen to change to it. You can also press F or G to cycle between intents, or 1, 2, 3, 4 to change to each intent directly.",
					"Help intent will perform friendly actions, such as feeding yourself or someone else food. Applying bandages, or giving hugs if you are unarmed.",
					"Disarm intent will try to knock over, or remove items from any person you click, even yourself.",
					"Grab intent will restrain a target, dragging them with you if successful. You can click the grab icon that appears in your hands UI to strengthen the grab. You can release a grab by dropping it, as if it was an item.",
					"Finally, Harm intent. This is used for combat, and will use any item in your hand as a weapon. Be careful, because this includes you as well if you click yourself!",
					"If you have accidentally harmed yourself, try using the contents of the medical kits in the previous room to bandage yourself.",
					"The creatures in this room are virtual and are not real. Experiment with your intents, pet, grab or harm them. Until you feel comfortable with the intent system."
					)

/obj/machinery/hologram/holo_tutorial/intro_9
	dialog = list(	"Many areas of the station are dangerous, and you may be on your own for extended periods of time during emergencies.",
					"Employees are expected to recognize dangers, and to return to safe areas of the station when possible.",
					"Seek the safety of your crewmates, or contact medical and security personal if you become lost, or hurt.",
					"Pressing T will allow you to speak, and anyone nearby will hear you.",
					"Typing ; at the start of your message will say it over the common radio channel, if you are wearing a headset radio. All departments start wearing one.",
					"You can also press Y to whisper a message to anyone directly next to you."
					)

/obj/machinery/hologram/holo_tutorial/intro_10
	dialog = list(	"Using T to speak, you can also type * before an action to perform an emote.",
					"Type *help to get a list of emotes you can perform, some examples of emotes are *spin, *belch, *flip, and *dance.",
					"You can also press 5 to begin typing a custom emote. This will display to others as a physical action you have performed.",
					"Pressing 6 will allow you to do a subtle emote. It behaves the same as a custom emote, but only others directly beside you will see it."
					)

/obj/machinery/hologram/holo_tutorial/intro_11
	dialog = list(	"Some actions are performed by dragging yourself onto an object. Such as buckling yourself to a seat.",
					"Once you are buckled to something, you can unbuckle yourself by clicking the icon in the top right of the screen, or by pressing b to resist.",
					"If you are ever trapped inside of an object, or restrained, using resist is a reliable way to break free."
					)

/obj/machinery/hologram/holo_tutorial/intro_12
	dialog = list(	"Your verb tabs, and how to use them.",
					"The tabs in the top right of your window contain all possible interactions you can do. These are called Verbs.",
					"Many interactions are only possible from these tabs, many also have hotkeys to do them quickly.",
					"Your most important tabs are: IC, in character actions; Objects, interactions with simple objects; Equipment, interactions with worn or ridden objects and Powers, special abilities that are innate to your body.",
					"IC, or in character actions allow you to rest, sleep, resist, climbing up or down, and even saying things!",
					"Objects, this tab will show any interactions that you can perform with nearby objects. In most cases, all of these interactions will be accessible by right clicking the object itself. Like you learned to do so before.",
					"Equipment, similar to the objects tab, it contains interactions with objects. However these objects are usually worn, or ridden. Equipment such as hardsuits, mechs, or vehicles will have their interactions in this tab.",
					"Finally your Powers tab is where you can use, or toggle, various abilities your species or genetics allows you to perform. For example: Teshari can use this tab to toggle their agility, and promethean may enter their blob form."
					)

/obj/machinery/hologram/holo_tutorial/intro_13
	dialog = list(	"This vehicle is called a cargo tug. To operate it, you will need to perform several interactions.",
					"First, you must be buckled to it.",
					"Second, you must turn on the engine, using the equipment tab.",
					"If you cannot start the engine, the keys may be missing. Click the vehicle while holding the keys to put them in.",
					"You may then move the tug.",
					"Finally, to properly shutdown the tug. Turn off the engine, and optionally remove the keys.",
					"Please, leave the keys in this room, or in the tug. Once you are comfortable interacting with a vehicle, move onto the next room."
					)

/obj/machinery/hologram/holo_tutorial/intro_14
	dialog = list(	"To pass through these plastic flaps, you must be laying on the ground.",
					"Step onto the conveyor, while it is moving, and use the rest verb in your IC tab."
					)

/obj/machinery/hologram/holo_tutorial/intro_15
	dialog = list(	"Objects may be pulled behind you. This is helpful for many large containers that you cannot pick up.",
					"Right click the object, and click pull, or control click the object to begin pulling it.",
					"To stop pulling, press the release pull button that appears in the bottom right of your screen, the drop item button near it, or press Q.",
					"You can also push the object, this will stop pulling it.",
					"If you trap yourself in a corner. Right click, and use the climb structure interaction to escape. You can also use this to climb over tables. Dragging yourself onto a table will also work.",
					"Once you are comfortable pulling these carts, please leave the room, and climb over the tables in your way to move on.",
					"Please note: Pulling unconcious crew members will injure them. Please ask medical, for the proper training needed to transport injured and unconcious crew members safely."
					)

/obj/machinery/hologram/holo_tutorial/intro_16
	dialog = list(	"Finally, you are now ready to perform a mundane, yet surprisingly complex task, expected of an entry level job.",
					"Please, mop the floor. To do so, you will first need to fill a bucket with water, and then transfer that water into the mopping cart.",
					"Then, pick up the mop, and use it on the mopping cart to wet your mop. Then clean the floor.",
					"You will also need to pull the mopping cart behind you, regularly wet your mop, and refill your cart when it runs out of water.",
					"This basic training course has taught you how to perform all of these actions. Return to earlier rooms if you need to listen to an earlier lesson."
					)

/obj/machinery/hologram/holo_tutorial/intro_17
	dialog = list(	"Some items, such as clothing can be equiped. Your equipment slots can be found at the bottom left of your screen, by clicking the bag icon to expand them.",
					"Each equipment slot may have a single item in it. Such as an oxygen mask over your face, your department jumpsuit, a hardsuit, or even your headset radio.",
					"Several equipable items and clothing are presented in this room. Please equip them, and move on when your are comfortable.",
					"Your equipment slots are as follows: Head, eyes, each ear, mask, clothing, suit, hands, and shoes.",
					"The other slots along the bottom of your hud are: Suit storage, ID, toolbelt, backpack, both hands, and the pockets of your clothing.",
					"Some clothing also has its own storage space, seperate from your pockets. These behave in a similar way to other types of storage.",
					"Some items can also be equiped to clothing as accessories. To remove an accessory, right click the clothing, and click remove accessory from the menu."
					)

/obj/machinery/hologram/holo_tutorial/intro_18
	dialog = list(	"Weapons, and equipment.",
					"These lasertag guns will only fire under specific conditions.",
					"Firstly, you must click with the gun in your active hand.",
					"Secondly, you must not be on help intent, or you will refrain from firing the weapon.",
					"Finally, the lasertag gun requires you to wear a lasertag vest to power the gun. Similar to how most guns require ammunition, or a battery.",
					"The lasertag vest can be equiped to the suit slot. The same way you equiped the jumpsuit to your clothing slot.",
					"While the lasertag guns do not require reloading. Some guns will require that you remove the spent round manually, and then load a new one. The next room will provide an example of such weapons."
					)

/obj/machinery/hologram/holo_tutorial/intro_19
	dialog = list(	"Weapons, items, and unarmed interactions may all be aimed at specific body parts.",
					"This is done by clicking each body part of the small figure in the bottom right of your screen, or by pressing 8,4,5,6,1,2 and 3 on your numpad for each limb.",
					"You can aim at a target's head, chest, groin, legs, arms, hands, feet, or at their eyes and mouth. If you are using the numpad, press a key multiple times to cycle through each possible target on a limb.",
					"While this is often used for aiming weapons, many items have unique interactions with specific limbs. Such as using the items in firstaid kits. You can only bandage a wound, if you aim at the location where that wound is.",
					"This knowledge is critical if you plan to learn advanced skills, such as surgeries performed in medical, or if you want to improve your combat effectiveness as security."
					)

/obj/machinery/hologram/holo_tutorial/intro_20
	dialog = list(	"This is a medical kiosk. You may use this to backup your memories and body record.",
					"When you die you will eventually be resleeved by medical staff, or the automatic resleeving system.",
					"You will only have the memories you had, from the last time you performed a mind scan.",
					"Dying is often disorienting for crew, and will impact station safety and productivity. Please avoid dying.",
					"In the event that you die, it is important for medical staff to know where you are, and how you died.",
					"To do this, you can enable your suit sensors. Right click your jumpsuit, and click toggle suit sensors from the menu.",
					"Sensors can be set to: Off, to show no information; Binary sensors, show if you are alive or dead; Vitals tracker, show the types of damage you have sustained; And finally tracking beacon, which shows medical staff all the prior information and your location.",
					"It is advisable to set your suit sensors to the tracking beacon configuration, to allow medical staff to react quickly, and find your body if you cannot be rescued."
					)

/obj/machinery/hologram/holo_tutorial/intro_end
	dialog = list(	"The next door will take you into the hazard course.",
					"If you have only completed basic training, it is highly encouraged to continue, and put your newly learned skills to the test.",
					"However, if you wish to leave virtual reality. Open your IC tab, and press exit virtual reality, to return to your body in the real world.",
					"Remember to have a safe day, make regular backups, and that the rain and surface water on station will digest your flesh on contact!",
					"If you were unaware that the water did this, please enter the next room and begin the hazard course.",
					"Any hotkeys mentioned during these tutorials can be found in the help menu at the top of the window."
					)

/obj/machinery/hologram/holo_tutorial/hazard_1
	dialog = list(	"Welcome, to the hazard training course.",
					"This training course expects you to already have basic training, and will only provide assistance when absolutely required to.",
					"The first section of this course will present you with a virtual station to explore. Experiment with what you have learned, and progress further into the course at your own pace.",
					"The course ahead will present you with simulated dangers, and death. The experience of pain is only virtual. If you die, simply begin the hazard course again. You may loot your previous body, please do not loot the bodies of other virtual crew members.",
					"Continue down the stairs, grab the items from a table of your choice. This course will remain mostly unassisted. Use your own skills to survive, and help other crew members you encounter."
					)

/obj/machinery/hologram/holo_tutorial/hazard_2
	dialog = list(	"This region of the hazard course is experiencing an electrical failure.",
					"While a door is unpowered, you can use a crowbar, prybar, or maintenance jack to force the door open.",
					"All crew are provided with a prybar in their standard issue survival kit. To aid them in the event of power failure.",
					"A flashlight is advisable, the next areas will be significantly more dangerous."
					)

/obj/machinery/hologram/holo_tutorial/hazard_3
	dialog = list(	"Remember basic training. If you become wounded, the bandages and salves in a medical kit must be applied to the location of the wound you are trying to tend to.",
					"For example, if your right arm hurts, you must be targeting the right arm, as you click yourself with the bandage. Otherwise the item will not bandage the wound.",
					"Pills, and autoinjectors do not require you to target any location for them to function. You simply click yourself or your target with the item to use it."
					)

/obj/machinery/hologram/holo_tutorial/hazard_4
	dialog = list(	"Many hazards on station are marked by signs. Right click and examine, or shift click, a sign to read it",
					"For example, these signs are a warning that this is a secure area. Protected by lethal turrets.",
					"Of course, this is not the way forward. You should not be entering secure areas without authorization."
					)

/obj/machinery/hologram/holo_tutorial/hazard_5
	dialog = list(	"You are very stuborn, congratulations!",
					"Please, do not try to enter secure areas without authorization. Your only reward will be termination."
					)

/obj/machinery/hologram/holo_tutorial/hazard_end
	dialog = list(	"Congratulations! You have completed the hazard course!",
					"You have demonstrated a basic grasp of station survival.",
					"Beyond this hallway is the EVA basics course.",
					"To leave virtual reality, open your IC tab, and click exit virtual reality."
					)

/obj/machinery/hologram/holo_tutorial/eva_1
	dialog = list(	"Welcome, to the EVA basics course.",
					"This short course will ensure you understand how to properly use your emergency oxygen supply and softsuit.",
					"You will also learn basic airlock interaction. Proceed to the next room when you are ready."
					)

/obj/machinery/hologram/holo_tutorial/eva_2
	dialog = list(	"First, you must equip an oxygen mask to your mask slot. This is required to use an oxygen tank.",
					"Second, equip the softsuit to your suit slot, and then the softsuit helmet to your head slot.",
					"Once you are wearing all parts of the suit. Pick up an emergency oxygen tank, and put it onto the suit storage slot, back slot, or into the suit's pockets.",
					"Finally, you will activate your suit's internal oxygen supply. To the right side of your screen is a blue oxygen tank icon. Click this icon to enable internals.",
					"Once internals are enabled, you will breath through your oxygen mask, from the oxygen tank connected to it.",
					"It is critical that you do not drop the oxygen tank, or place it into a container. This will disconnect it, and require you to turn back on internals."
					)

/obj/machinery/hologram/holo_tutorial/eva_3
	dialog = list(	"Basic airlock interaction.",
					"Airlocks are equiped with two automatic cycling buttons. One on the outside of each door.",
					"Pressing a button outside a door will cycle the airlock to that door.",
					"Finally, the chamber controller may be used to cycle to either door, or force doors to open in an emergency.",
					"Please, prepare you suit for space, turn on your internal air supply, and cycle the airlock."
					)

/obj/machinery/hologram/holo_tutorial/eva_end
	dialog = list(	"In zero gravity you will float. You can only control your movement while near a floor or wall.",
					"Once you have left a solid surface, you will begin floating uncontrollably in the direction you moved.",
					"Throwing objects will allow you to change direction, however it is recomended to find zero-G equipment, such as a jetpack before entering zero-G areas.",
					"This concludes the EVA basics training course. When you have finished experiencing virtual space. Please, return your suit.",
					"To leave virtual reality, open your IC tab, and click exit virtual reality."
					)
