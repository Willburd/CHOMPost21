// Randomized spawner for map loot, and because adding every paper one by one to the loot table would pack it to hell and back. Have fun adding to maint/bridge
/obj/random/scavmark_paper
	name = "random underdark treasure"
	desc = "Random treasure loot for Underdark."
	icon = 'icons/obj/storage.dmi'
	icon_state = "cashbag"

/obj/random/scavmark_paper/item_to_spawn()
	return pick(subtypesof(/obj/item/paper/scavmark))


/obj/item/paper/scavmark
	name = "Scav paper"
	info = "white stuff here<BR>\na newline"

/obj/item/paper/scavmark/rest
	name = "Rest"
	info = "On the paper is a crudely drawn image of a raptor-like creature, they appear to be laying in a bed with closed eyes. A small box with an open bottom is clearly drawn on the floor nearby. The image appears to display peace and safety."

/obj/item/paper/scavmark/danger
	name = "Danger"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear to be kneeling down and inspecting in front of them. <br>In front of them is a small box with a laser coming from it, a bear trap, and a frayed wire sparking angrily. The raptor appears to be drawing an 'X' on the floor. The image seems to convey a sense of variable risk."

/obj/item/paper/scavmark/agony
	name = "Agony"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They are laying on their side and appear to be grabbing their foot, with their muzzle open in a scream. Highlighted in the front of the picture is a small object that seems to radiate menace. Drawn to the side with an arrow pointing is a rectangle with eight dots. The image seems to convey a sense of unparalleled pain."

/obj/item/paper/scavmark/arrow
	name = "Pointer"
	info = "On the paper is a crudely drawn image of a raptor-like creature. The creature appears to be drawing an arrow on the ground, pointing towards a section of wall they're pushing back into place. The wall section appears to be dislodged somehow. A cross line shows the arrow being drawn in combination with other symbols, as if to imply a change of meaning."

/obj/item/paper/scavmark/market
	name = "Trade"
	info = "On the paper is a crudely drawn image of a raptor-like creature, and a teshari wearing a traffic cone on their head. The pair appear to be exchanging belongings. Other individuals can be seen in the background trading. On the ground between them is a symbol resembling a harsh, backwards S. A cut image then draws the same symbol, but with an inverted triangle above it, and a letter to the side. A large taur-like figure looms and seems to be in control of the room, with a line drawn from the taur, to the letter."

/obj/item/paper/scavmark/skull
	name = "Return"
	info = "On the paper is a crudely drawn image of a large smiling taurs, and an odd structure. On one image, the taur is laying on the ground with X's over their eyes, and severe wounds on their body. A second image shows the machine seeming to glow and shudder. A third image shows the taur stepping out of the machine, seeming confused, but alive."

/obj/item/paper/scavmark/wander
	name = "Wander"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear to be resting off the side on a couch, on the floor is a drawn image of a circle with an open side to the right, and a T marking on top. The image seems to try to convey a sense of short term safety."

/obj/item/paper/scavmark/violence
	name = "Violence"
	info = "On the paper is a crudely drawn image of a ragged sergal and a small teshari. They both appear to be shouting at each other, the sergal is holding a knife, the teshari is holding a wrench. A mark above the two appears to be an inverted 2. The image appears to convey a sense of resolution."

/obj/item/paper/scavmark/food
	name = "Food"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear be sitting on the floor, eating some food. On the floor in front of them is a symbol of four horizontal lines, connected in the middle."

/obj/item/paper/scavmark/companion
	name = "Pack"
	info = "On the paper is a crudely drawn picture of a dog-like creature with a fanned, spikey tail. Their eyes are glowing. They have a vacant expression. Above them is a symbol of an arch with three lines coming off each side. A line is drawn from the symbol to the creature as if identifying it."

/obj/item/paper/scavmark/expietrade
	name = "Dogtrade"
	info = "On the paper is a crudely drawn image of multiple dog-like creatures with fanned, spikey tails. They appear to be communing with each other, and exchanging goods. On the floor between them all is a symbol of an arch with three lines coming off each side, and a circle encompassing it."

/obj/item/paper/scavmark/desire
	name = "Desire"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear to be kneeling in front of a half-disassembled wall, with a small pile of tools next to them. The raptor is holding a wrench. On the ground nearby is a symbol with a line on top of a right-side crescent, with a dash on the bottom right side pointing away. The image seems to convey deep secrets."

/obj/item/paper/scavmark/survival
	name = "Survival"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear to be leaning against a spear with one hand, and holding a wound on their side with their other, looking badly injured. They appear to be moving toward a symbol of a crested line, with three lines below it at different angles. The picture seems to convey a sense of survival."

/obj/item/paper/scavmark/life
	name = "Life"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They are sitting on some kind of bed. Around the raptor are various boxes with crosses on them. The raptor is patching their wounds. On the ground is the symbol of a crested line, with three lines coming off below, all encased in a circle. The image seems to convey healing."

/obj/item/paper/scavmark/wrath
	name = "Wrath"
	info = "On the paper is a crudely drawn image of a room full of corpses and blood, holes scatter the wall and a small flame burns in the corner. On the floor is a blood-soaked symbol of an encircled, inverted 2. The image seems to convey a sense of lingering anger and dread."

/obj/item/paper/scavmark/lust
	name = "Lust"
	info = "On the paper is a crudely drawn image of a sergal and a raptor-like creature. Both creatures are naked, with the raptor on top of the sergal, their erection visible, and an expression of pleasure on both creature's face. Above the two is a symbol with a line on top of a right-side crescent, with a dash on the bottom right side pointing away, drawn in a circle."

/obj/item/paper/scavmark/predator
	name = "Predator"
	info = "On the paper is a crudely drawn image of a slugcat, and a large lizard. The lizard is swallowing the slugcat. The slugcat is struggling, but unable to escape. On the ground drawn in front is a symbol of four horizontal lines, connected in the middle, all contained in a circle."

/obj/item/paper/scavmark/tranquility
	name = "Tranquility"
	info = "On the paper is a crudely drawn image of several creatures in a room. They all appear to be comfortable, with some resting, some eating, and some drinking a fluid. On the floor in the room is the symbol of two circles, one inside the other. The image appears to depict peace."

/obj/item/paper/scavmark/removal
	name = "Removal"
	info = "On the paper is a crudely drawn image of a large, intimidating dragon. Fire is streaming from its maw, and several bodies lay strewn below it. Above it is a symbol of a circle, with an upside-down Y in the middle."

/obj/item/paper/scavmark/death
	name = "Death"
	info = "On the paper is a crudely drawn image depicting a large X in a circle. Surrounding the symbol is depictions of gruesome, horrific fates of various creatures. Some turned to stone, some ashing, one pinned by a rat-like creature with a lantern tail, one being absorbed into a fleshy mass, one screaming and watching their arm twist into some horror. The symbol fills you with a fear of losing yourself in it."

/obj/item/paper/scavmark/light
	name = "Light"
	info = "On the paper is a crudely drawn image of a raptor-like creature. Streaks originate from a small cylinder device on the ground. The raptor appears to recoil and cover their eyes. A symbol of a horizontal line with a left sided tail, and a down-facing crescent above is mixed in with the offending lines."

/obj/item/paper/scavmark/dark
	name = "Dark"
	info = "On the paper is a crudely drawn image of a four-eared, canine-like creature. They appear to be suspended in the air, while resting soundly. Lines around the side seem to indicate the area is darker than usual. A symbol of a horizontal line with a left sided tail, and an upward facing crescent below is depicted nearby."

/obj/item/paper/scavmark/air
	name = "Air"
	info = "On the paper is a crudely drawn image of two lockers, and a raptor-like creature. The raptor-like creature appears to be stepping through one locker and out of the other, with a symbol in between the lockers of a horizontal line with a large upward crescent on the right, four lines on the left, and a curled, dotted mark in the bottom-right."

/obj/item/paper/scavmark/electric
	name = "Shock"
	info = "On the paper is a crudely drawn image of a raptor-like creature. In front of him is two symbols; depicting air and light. A door opposite of the marking from the raptor is sparking violently."

/obj/item/paper/scavmark/water
	name = "Water"
	info = "On the paper is a crudely drawn image of a raptor-like creature. They appear to be dipping their hands into some water, with more dripping from their muzzle. On the ground nearby is a symbol depicting a horizontal line, with three dashes above it. The line trails below itself to the right, then curls left. On the right side is a single dot."

/obj/item/paper/scavmark/fire
	name = "Fire"
	info = "On the paper is a crudely drawn image of a jil. The jil is on fire. Next to the jil is a symbol of a broken crest, with a dot in the top right. A straight line down, a frantic line to the left, and a loop in the bottom right."

/obj/item/paper/scavmark/earth
	name = "Earth"
	info = "On the paper is a crudely drawn image of a massive armored taur. The taur is weilding a pickaxe, and appears to be digging through stone. On the stone is a symbol of a square arch with a tail on the left, and a fang in the middle, with a dot above."

/obj/item/paper/scavmark/chaos
	name = "Chaos"
	info = "On the paper is a crudely drawn image of a black bird. Surrounding them are various symbols and effects with an unclear and confusing meaning.. above the bird is a complex symbol, of a down-facing crescent, encased by a sharp arch with a large tail to the left, and feathers to one side. The image gives you an intense feeling of chaos."

/obj/item/paper/scavmark/acidwater
	name = "Acid Water"
	info = "On the paper is a crudely drawn image of a fox-like creature, they are waist deep in water. The water appears to be burning their body and they're screaming in pain. The symbols of Water and Earth can be seen above them."

/obj/item/paper/scavmark/night
	name = "Night"
	info = "On the paper is a crudely drawn image of some kind of machine. A four-eared canine is inside looking fast asleep, marks around the machine seem to indicate cold. On the machine is a symbol of a right-facing triangle, with a crescent moon and star in the bottom right. The image seems to convey an idea of long sleep."

/obj/item/paper/scavmark/suspicious
	name = "Watching"
	info = "On the paper is a crudely drawn image of a raptor-like creature. The raptor is gazing through some kind of obstruction at two indistinct individuals. They do not appear to be aware of the raptor. On the ground is a simplified drawing of a man in a space suit."

/obj/item/paper/scavmark/stomach
	name = "Stomach"
	info = "On the paper is a crudely drawn symbol of a stomach. Beyond the picture is a large fleshy tunnel, easily enough to fit a person."

/obj/item/paper/scavmark/Uboa
	name = "Menace"
	info = "On the paper is a horrifying visage of a ghoulish face. The surrounding paper is scribbled with attempts of drawing... something. The drawing seems to radiate an unnatural menace, but you're not even sure what it's trying to warn you of."
