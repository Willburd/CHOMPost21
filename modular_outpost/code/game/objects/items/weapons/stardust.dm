/obj/item/book/manual/stardust_game
	name = "Stardust Gameplay Handbook"
	desc = "A guide for playing Stardust, a tabletop roleplaying system."
	icon_state = "commandGuide"
	icon = 'icons/obj/library_vr.dmi'
	author = "Willbird"
	title = "Stardust Gameplay Handbook"

/obj/item/book/manual/stardust_game/New()
	..()
	dat = {"<html>
	 <head>
		<style>
		h1 {font-size: 23px; margin: 15px 0px 5px; text-align: center;}
		h2 {font-size: 20px; margin: 15px 0px 5px; background-color: #888888;}
		h3 {font-size: 18px; margin: 15px 0px 5px; background-color: #cccccc;}
		h4 {font-size: 14px; margin: 15px 0px 5px; background-color: #eeeeee;}
		h5 {font-size: 10px; margin: 15px 0px 5px; text-align: center;}
		h6 {font-size: 8px; margin: 15px 0px 5px;}
		body {font-size: 13px; font-family: arial;}
		</style>
	</head>
	<body>
		<h1>Stardust Gameplay Handbook</h1>
		<h5>Written by Willbird, with permission from system's author Drake Frostpaw</h5>

		<h2>Chapter 1: An Introduction</h2>
		<p>This book is an introduction to the simplified tabletop role-playing game Stardust. Created by Drake Frostpaw. This book was created with permission from the system's author to allow station staff a simple and fun method of enjoying tabletop role-playing without the complexity and investment of other systems. While also having the system completely documented in one place, for ease of play.</p>
		<p>Stardust is played as a group of at least two people, however a group size of three to four is recommended. One player acts as the Game Master, and their task is to run the game's systems, control entities such as creatures and NPCs, and describe the story of the game as it happens. The other players create their own characters, using acting and skill checks to engage with the world the Game Master is controlling.</p>
		<p>Playing Stardust is a cooperative experience between players and the Game Master. While it is the Game Master's goal to provide interesting and challenging experiences, all players should enjoy the game together. Playing Stardust is not about beating other players or the Game Master, but instead as a way to enjoy a story created through the interactions between every player involved, and the roll of the dice.</p>
		<p>While the system is designed specifically to be lightweight, and avoid much of the math and complexity often involved in other tabletop role-playing systems. The Game Master and players may discuss any alterations to the game's rules, as they see fit, and agree to. Nor is game-play restricted to purely cooperative play. Discuss with your players what is right for everyone involved. This manual is only a foundation for playing the system as it was originally designed.</p>

		<h3>Rolling</h3>
		<p>Each token in Stardust is refereed to as an entity. An entity may be a player's character, a character not controlled by the player(called an NPC), a creature or an object such as a machine. Entities perform actions based on simple rules by rolling dice to determine if they succeed. These rolls are called skill checks.</p>
		<p>Stardust is played using several dice, all added together during skill checks. Most interactions during play are done through skill checks, and skill checks are done at the Game Master's discretion based on the situation a player is in and the action they are trying to perform.</p>
		<p>It is recommended to have at minimum, a D4, D6, D8, D10, D12, D20, and a D100. Having two or three set is recommended, as most rolls in Stardust are done with combinations of dice. In most cases a roll will use at least two dice, but rarely three.</p>
		<h3>Training Levels</h3>
		<p>Each die size can be described as the training level of a entity. The mythic, and special training levels are only used by entities under the Game Master's control, and serve as a way to create incredibly dangerous challenges. For players, only untrained to master are of any relevance.</p>
		<b>Untrained</b>: No die.<br>
		<b>Amateur</b>: D4<br>
		<b>Trained</b>: D6<br>
		<b>Professional</b>: D8<br>
		<b>Expert</b>: D10<br>
		<b>Master</b>: D12<br>
		<b>Mythic</b>: D20<br>
		<b>Special</b>: D100<br>
		<p>In most cases, two dice will be rolled. One for the base attribute of a skill, and then the training of that skill. This will be explained fully in the Game-Play chapter of this book. Many stats on a entity will also use the maximum size of a dice to decide the stat. For example, the maximum size of a D6 is 6, and that number would be used for that statistic.</p>

		<h3>Situational Modifiers</h3>
		<p>During game-play, the Game Master will request players make skill checks to successfully perform the actions they request to do. In most cases, simply actions such as moving to a location, or opening an unlocked door will not require any rolls. Performing most skill checks will require a player to roll both the attribute die, and the training die of the skill that is relevant to the action.Situational modifiers should be used sparingly to avoid both abuse, and overwhelming the choices players made while creating their character.</p>
		<p>However, a Game Master may deem that the situation that the action is being performed in, alters the roll. For example, a player trying to jump over a wide pit may be required to roll an acrobatics skill check. They would roll their body die, and their acrobatic skill's die. Unfortunately, there is also a strong wind, and the Game Master has decided to give them a slight disadvantage to successfully perform the action! Rolling an additional die, called the situation modifier, and subtracting the amount rolled from the player's own roll.</p>
		<p>The seven situational modifiers are:</p>
		<b>None</b>: No additional die is rolled.<br>
		<b>Good</b>: 1D4 is added to the roll.<br>
		<b>Great</b>: 1D6 is added to the roll.<br>
		<b>Amazing</b>: 1D8 is added to the roll.<br>
		<b>Bad</b>: 1D4 is removed from the roll.<br>
		<b>Worse</b>: 1D6 is removed from the roll.<br>
		<b>Terrible</b>: 1D8 is removed from the roll.<br>
		<p>A roll may have multiple things affecting the outcome. In the earlier example of the difficult windy jump, it may be rolled with a Bad(-1D4) situational modifier. However, if the floor is wet, the Game Master may decide to increase the severity of the situational modifier to Worse(-1D6)! Situational modifiers only grow or shrink in intensity, multiple situational modifier dice are not rolled. A situational modifier may not become worse then Terrible(-1D8) or better than Amazing(+1D8). </p>

		<h3>A Sense of Challenge</h3>
		<p>The Game Master's role is to discern what is challenging and fun to a group of players. Therefor it is important to understand how to set the difficulty of rolls. Due to the way dice are stacked together during rolls, especially with situational modifiers, it can often be difficult to feel how challenging a roll is. The following is a general outline, to get a sense of scale when deciding your own challenges.</p>
		<b>2</b>: Extremely easy, only the most disadvantaged and unlucky could possibly fail. Only entities rolling untrained skills, or rolling with a negative situational modifier are capable of failing.<br>
		<b>4</b>: Easy, something as simple as opening a jar that is stuck shut. Having any training at all should make this almost impossible to fail.<br>
		<b>6</b>: Average, a common middle ground difficulty. Untrained entities may have difficulty, but trained entities may find it easy.<br>
		<b>8</b>: Difficult, entities may require training, or a good situation modifier to pass this check.<br>
		<b>10</b>: Hard, without proper training or preparation an entity is likely to fail.<br>
		<b>12</b>: Extreme, an entity requires decent training, and maybe a lucky situation modifier to pass this check.<br>
		<b>14</b>: Unthinkable, an entity requires decent training, and maybe a lucky situation to pass this check.<br>
		<b>16</b>: Nearly Impossible, without extreme specialization and good luck. An entity is unlikely to succeed at this action.<br>
		<b>32</b>: Impossible, this is the absolute upper limit of a roll that can be made, and requires a entity to have both a D12 in the attribute, Master(D12) training, and an Amazing(+1D8) situational modifier. While also rolling the maximum number on each die. While it is recommended for a Game Master to state if something is clearly impossible to a player, this number may instead be used if a player insists on rolling.<br>
		<p>In many other tabletop role-playing games, rolling the highest number on a die is often treated in a special way. Due to Stardust's mechanics of rolling multiple dice. There are no special mechanics for rolling the maximum value on every dice rolled. Due to the mathematics of rolling multiple dice, this would make the odds impossibly low. Instead, Stardust has a special system known as "nailing it." For further details read the Nailing It section of the Game-play chapter.</p>

		<h2>Chapter 2: Character Creation</h2>
		<h3>Introduction</h3>
		<p>TODO</p>
		<h3>Species</h3>
		<p>A character's species decides the initial attributes, and skill training a character will have before the player assign any points to them. A species will outline any bonuses it applies to a character, along with any unique traits also given to a character.</p>
		<h3>Attributes</h3>
		<p>All entities have four attributes. Body, agility, mind, and will. These attributes decide the base rolls of every skill, as well as several other stats often using the maximum size of the attribute die. For example, the maximum wounds a character has is decided by their body attribute.</p>
		<p>During character creation, each character has <b>six points</b> to spend. Each point increases the size of the attribute die it is spent on. Every attribute starts at a D4, with your species almost always giving additional points to at least one attribute. These bonuses from species do not count toward the six points being spent to customize the character. Die upgrades go in order from <b>D4 -> D6 -> D8 -> D10 -> D12</b>, and no higher. Normal characters should not be allowed to use a D20, or D100 die for their attributes.</p>
		<p>The following is an explanation of each attribute:</p>
		<b>Body</b>: A character's physical strength and constitution.<br>
		<b>Agility</b>: The dexterity and speed of a character.<br>
		<b>Mind</b>: Ones wits, and often a result of their education.<br>
		<b>Will</b>: A character's mental fortitude, and ability to endure harsh situations.<br>
		<h3>Skills</h3>
		<p>Every action performed in Stardust is often done with a roll of a skill. Each character gets <b>ten points</b> to spend on upgrading their training in any skills of their choice. Training upgrades go in order from <b>Nothing(Untrained) -> D4(Amateur) -> D6(Trained) -> D8(Professional)</b>. During character creation, a skill may not be upgraded above professional, this includes any skill training bonuses given by a character's species. As such a character's species bonuses should be applied before a character's skills are customized.</p>
		<p>The following is an explanation of each skill, sorted by attribute:</p>
		<h4>BODY</h4>
		<b>Acrobatics</b> - The physical dexterity of a character. Their ability to perform maneuvers while in the air, or to quickly and carefully move past hazards.<br>
		<b>Athletics</b> - A character's ability to endure long duration intense activities, such as running a marathon, or leaping a long distance. Landing safely would be acrobatics however!<br>
		<b>CQC</b> - Ones ability to engage in close quarters combat. Swinging and stabbing weapons at a target. This is what is rolled to perform all melee attacks, armed and unarmed.<br>
		<b>Performance</b> - The ability to physically perform complex sequences of movements, this can be explained as someone's muscle memory. Dancing is an easy example.<br>
		<h4>AGILITY</h4>
		<b>Artillery</b> - Aiming complex high powered weaponry, such as ship mounted weapon systems. Not many of these weapons can be carrier by a character, and are often controlled by remote terminals rather then directly aimed.<br>
		<b>Firearms</b> - A characters ability to aim and fire most handheld weapons. If a weapon is a ranged weapon this skill is used to attack with it. Even if the weapon is not directly a firearm.<br>
		<b>Piloting</b> - The ability of a character to maneuverer large machinery or ships safely. During combat attacks against a vehicle are not rolled against a ship's defense, but instead the pilot rolls to avoid the attack. The roll becoming the defense that the attack is rolling against.<br>
		<b>sleight of hand</b> - The ability to perform delicate interactions with an object. Carefully removing a single component from a machine without touching anything else inside it, or picking a complex lock without activating a security system.<br>
		<b>Stealth</b> - A character's ability to avoid detection, through careful movement or concealing themselves in cover.<br>
		<h4>MIND</h4>
		<b>Computers</b> - Interacting with complex computer systems, often in unintended ways. Such as gaining access to remote systems, locked files, or disabling the function of a system without activating an alarm.<br>
		<b>Culture</b> - The knowledge of important events and locations. While a player may know important information about the world, their character may not! Rolling for cultural information can be used to teach players about the state of the world they're playing in, without overloading them all at once.<br>
		<b>Engineering</b> - The ability to repair complex machinery and systems, often without computer assistance. If a character is unfamiliar with a type of machine, rolling engineering is an acceptable way to see if they'll figure out how to operate it on their own.<br>
		<b>Investigation</b> - Searching a small limited area for something specific. The goal of the search must be known before they begin. Such as looking for a key that had fallen into a drain pipe, or to see if the dust on a shelf reveals that an object was taken from it.<br>
		<b>Medicine</b> - A character's medical training, healing another character may be performed once per round, and requires rolling an 8 or higher to do successfully. Successfully healing a target will remove one wound from them. This roll does not have any special interaction if the character "nails it."<br>
		<b>Science</b> - Character's ability to identify unknown substances and their use in universe. Can also be used instead of a culture check if a character is familiar with a scientific concept related to the topic.<br>
		<h4>WILL</h4>
		<b>insight</b> - A character's ability to judge the intent of another character. A character having an insight check done against them must roll persuasion. If the insight roll is less then the persuasion roll, the character will be unable to gauge the intention of what was said or done. The amount of information the character learns from the combination of these rolls is at the Game Master's discretion. Even if the roll is unsuccessful. A high, but unsuccessful roll may only gain partial insight for example.<br>
		<b>Intimidation</b> - The ability for a character to use either their physical presence or other capability to make a target afraid, or encourage them to perform an action. In most cases this stat is used for role-play interactions, and the actions taken as a result of a character's intimidation may not be the expected actions. For example, an attempt to intimidate someone to break an object may instead result in the object being thrown and the target running away from the intimidating character in fear instead.<br>
		<b>Perception</b> - The ability for a character to identify something at a distance, or to hear a noise nearby. It does not need to be something specific, and the Game Master may request a character makes a perception check at any time if they wish to give them a hint that something is happening nearby. Using sounds, the flicker of lights, or spotting things moving nearby.<br>
		<b>persuasion</b> - A Game Master may request a persuasion roll to gauge an NPCs reaction to something proposed by a player. Especially if the Game Master is unsure of how the character would react. Persuasion rolls done against other players are only considered role-play flavor, and cannot be used to force another player to make a specific action.<br>
		<b>Psionics</b> - PSI-abilities require a roll to determine if the character using them has the mental focus to safely do so. A psionic ability will always successfully be performed even if this roll is failed. See the psionics section of the Game-Play chapter for a full explanation. The current psionic-stress amount is always subtracted from the result a psionics roll.<br>
		<b>Survival</b> - A character's ability to navigate through space or wilderness. Identifying salvage, or food while on the move. In most cases, a survival roll's results depend on the location the character is in. You are unlikely to find a berry bush full of food while floating through the void of space for example.<br>

		<h3>Additional Stats</h3>
		<p>Many stats are derived from the attributes explained above. These stats often use the maximum size of the die in their related attribute, or a combination of dice rolled at the same time when that stat is required. The following stats are:</p>
		<b>Maximum Wounds</b>: Maximum size of body attribute die. Number of wounds a character may take before falling unconscious.<br>
		<b>Defense</b>: The value required to hit this creature successfully. By default this value is four, and is changed by equipping different armor.<br>
		<b>Speed</b>: Maximum size of agility attribute die. Number of units a character may move during their turn. Doubled if using their action to dash.<br>
		<b>Memory</b>: Maximum size of mind attribute die. Amount of memory space available for PSI-Ability implants. Each PSI-Ability has a memory cost, and a character must have enough memory remaining to fit that cost.<br>
		<b>Maximum Bulk</b>: Maximum size of body attribute die. Amount of bulk inventory space a character is capable of holding. Any bags a character is wearing will increase this value. Characters that have exceeded their maximum bulk carrying capacity will be unable to pick up any additional items, and suffer no additional penalties.<br>
		<b>Initiative</b>: Rolling both agility, and mind dice together. Decides turn order during combat, and rarely in situations where two characters attempt to perform the same, or conflicting actions. Such as pulling (or preventing the pulling of) a lever at the same time.<br>
		<b>Psionic-Stress</b>: Every time a PSI-Ability is used, even if the roll to avoid damage was successful, a point of psionic-stress is added to the character. See the Psionics section of the Game-Play chapter for more details.<br>
		<b>Contamination</b>: Contamination is an extremely detrimental status inflicted on a character, and gaining significant contamination can be lethal. See the Contamination section of the Game-Play chapter for more details.<br>
		<b>Mortal-Trauma</b>: Every time a character is knocked unconscious from reaching their maximum wounds they will gain 1 mortal-trauma. This represents a character's remaining ability to pull themselves back from the brink of death. This survival often manifests as scars, or traumatic memories of the incident, and role-playing of these scars is encouraged. Characters that have survived nearly dying should feel more grizzled or traumatized then one who has never been to the brink of death before. Death is inevitable in a tabletop role-playing game. While unfortunate, Stardust is designed in a way that characters are reusable. Due to having no leveling system, and all progression being handled through items and downtime training, characters can be easily reused in other campaigns of Stardust. While it is unlikely to be possible in a long-term game with a consistent story. Keeping a backlog of old characters for quick use can become a personal collection of stories to tell whenever the character is reused in other settings, or one-off games. See the Mortal-Trauma and Death section of the Game-Play chapter for more details.<br>


		<h3>Buying Gear</h3>
		<p>Once all players have finished assigning attribute and skill points. The maximum bulk of all characters is added together, and then a D4 is rolled. The result of the die is added to the total bulk. These are the points that the party may spend buying items. During character creation the purchase cost of each item is the bulk of the item instead of the price. The Game Master and players may decide to allocate these points however the group wishes to before players start choosing items. The Game Master may also give the party a fixed budged instead, or choose to not include the additional D4. Changes like these should be explained beforehand, so that players understand the Game Master's intentions.</p>

		<h3>Psionics</h3>
		<p>PSI-Abilities in Stardust are learned through implants, and are physically installed in a character's mind once used. Each PSI-Ability implant has 1 bulk, and may purchased during character creation. Each implant is one PSI-Ability that may be learned by the character.</p>
		<p>Each PSI-Ability has a memory cost, and every character has a maximum memory size that they can spend to learned PSI-Abilities. For example, a healing PSI-Ability may require 2 memory, and a fireball PSI-ability requires 4. As long as a character has at least 6 memory, they will be able to equip both. If the character has less than 6 memory, they will need to choose if they learn the healing, or fireball PSI-Ability instead. Leaving the remaining memory unused.</p>
		<p>The PSI-Ability implant that is used is considered destroyed, and cannot be exchanged with another character or shared, as it becomes part of the user's body. The Game Master may choose to alter the rules of their world to allow PSI-Abilities to be shared, or for implants to be reused. For example, they may be redesigned as spells in a more magical fantasy setting. Where implants do not much as much sense. Please discuss with your players what any changes to implant rules might be, as PSI-Abilities are often a long-term investment for a character, and are not easily exchanged. See the Psionics section of the Game-Play chapter for further details.</p>

		<h2>Chapter 3: Game-play</h2>
		<p>Game-play in Stardust is broken down into several sections. Often these sections are intermixed during a game of Stardust. Jumping from role-play, to combat, to exploration. Entities performing skill checks, and talking with other entities to engage with the world the Game Master is presenting.</p>

		<h3>Role-Play</h3>
		<p>Not every interaction requires a skill check. Players interacting with other players is also something to be encouraged. Building long lasting relationships can lead to interesting stories. There is no harm in letting your players unwind for a bit by interacting with each other. Especially if the Game Master needs time to prepare after the players did something unexpected! Often new players are shy to role-playing interactions. Framing this interaction as a way to plan in-character what the group will be doing next can help ease them into it. Especially if their suggestions end up important later!</p>

		<h3>Exploration</h3>
		<p>Large areas, and travelling require the use of survival and perception checks. The Game Master is also encouraged to come up with unique encounters that players can find while moving between major locations. For example, find the ruins of an old escape pod. Allowing different skill checks to gather information or salvage from it. Like a computers check to find out where it came from, or an engineering check it start disassembling it. This variety helps to make long travel filled sessions less repetitive.</p>

		<h3>Combat</h3>
		<p>Combat forms the most complex part of game-play, and is broken up into multiple parts. It should also be considered the riskiest situation a group of players can be in. Situations may be possible to resolve diplomatically before combat even begins! However, sometimes there is simply no choice, or players are itching for a fight.</p>

		<h4>Grids and Distance</h4>
		<p>Stardust is a system designed for a hexagonal grid based map. Where each entity takes up one or more units on that map. Distances are measured in units, and the distance in character is abstract. For instance a unit may be one meter or about three feet, but at vehicle and travel scale one unit may represent one hundred meters. This abstraction is done to simplify vehicle stats, and the measurement of distances. As Game Masters may design vehicles for player-scale maps, and still use the same vehicles for large-scale combat.</p>
		<p>An entity's speed determines the number of units they may move during their turn in combat. However a entity out of combat may move as much as is reasonable to the Game Master.</p>

		<h4>Initiative</h4>
		<p>Combat is broken up into rounds and turns. At the beginning of each round, every player and entity involved in the combat will roll initiative to decide the order of everyone's turn that round. (See "Additional Stats" in the Character Creation chapter for explanation of initiative.) Each one then takes their turn, starting from the highest roll to the lowest.</p>
		<h4>Movement and Actions</h4>
		<p>An entity's turn is broken down into two parts; Movement and action. The maximum distance an entity may move on their turn is dictated by their speed. An entity may choose to spend their action to move twice, this is called dashing. They may not use their action to do anything else that turn if they choose to dash.</p>
		<p>An entity may perform their action before or after they have moved. They may also move a distance less than their full movement speed, perform an action, and then use the remaining movement to move elsewhere. This last option is often refereed to as split-movement. An entity may not dash if they are split-moving, as dashing requires their action to perform.</p>
		<p>An entity may perform one action per turn. Actions may be interacting with an object, exchanging items, removing armor, climbing a structure, attacking another entity or structure, or preparing to dodge the next attack done against them. Some items may allow the use of an additional action at the cost of the entity's entire movement, and may not be used if the entity has moved before performing the additional actions.</p>
		<h4>Attacking</h4>
		<p>Attacking is the primary action taken during combat. An entity chooses a target to assault, and the weapon they will use to attack with; If they have choose to attack without a weapon, the damage of the attack will be 1 wound and be either blunt or slashing depending on if the entity has sharp claws or not. The entity then performs an attack, for melee weapons a CQC skill check is made, for ranged attacks a firearms or artillery skill check is made depending on the type of ranged weapon. A Psionic attack may also be made, but due to their complexity they will be explained in a later section in this chapter.</p>
		<p>Once an attack's skill check has been rolled, the result of the roll is compared with the target's defense. If the roll exceeds the defense of the target the attack will hit. If the attack meets the target's defense exactly, then the attack has "nailed it", and the attack will have some additional properties related to the type of damage done. See the nailing it section in this chapter for more details. If the attack's roll is less then the defense of the target the attack has missed, and may be described as either not hitting the target or that the target's armor absorbed the hit.</p>
		<p>If an attack is successful, the following steps happen in order:</p>
		<b>Shields</b>: If the target has at least one or more points of shielding, then one point of shielding will be subtracted, and the attack will be considered complete. If the target has zero points of shielding when the attack hits, proceed to the next step.<br>
		<b>Armor</b>: If the target is wearing armor, check the armor's defense type. This is the damage type that the armor will reduce by 1 wound. If the weapon being used has a damage type matching the armor's defense type. The damage will be reduced by one wound. If the attack has been reduced to zero wounds of damage, then the attack will be considered complete, and will not proceed to the next step.<br>
		<b>Wounds</b>: The remaining damage of the attack is applied to the target in the form of wounds. Wounds count upward from zero to the maximum wound stat of the target. If the target's wounds meets or exceeds their the maximum wounds they will be knocked unconscious, and gain one point of mortal-trauma. Unconscious entities may not perform actions or move on their own, and their turns will be skipped until they regain consciousness through some means. See the heal action in the Important Actions section of this chapter for details.<br>
		<b>Trauma</b>: If the target has reached three points of mortal trauma when they are knocked unconscious by an attack they will be considered dead, and can no longer be healed. Otherwise, the target is only unconscious, and may be healed with a medical check. See the heal action in the Important Actions section of this chapter for details.<br>

		<h3>Important Actions</h3>
		<p>Attacking is not the only action possibly during a turn. The following are some common actions entities may perform, if the action you are attempting is no in this list. Discuss with the Game Master if it is possible, and what the requirements are to perform it.</p>
		<b>Dodge</b>: An entity may use their action to prepare a dodge. If they are prepared to dodge, any attacks made against them will be done with a worse(1D6) situational modifier before any other situational modifiers are applied.<br>
		<b>Climb</b>: Ladders and some walls may be climbed. Each turn that an entity is climbing they must make an acrobatics check with a difficulty of four. If the check is unsuccessful, they will remain in place. Otherwise they will be able to climb a distance equal to their movement speed. This climbing movement does not count against their normal movement, and if they finish climbing they may continue their standard movement as normal. They may not begin climbing if they have performed another action, and may not perform another action after climbing in the same turn, as climbing is considered an action and not a movement. Entities may choose to perform an action while in the middle of a climb. They do not require an acrobatics check to do so, but the Game Master may apply a harsh situational modifier due to the difficulty of trying to fire a weapon while climbing a wall or rope.<br>
		<b>Jump</b>: A jump may be used to cross a gap up to three units wide. For a one unit wide gap an athletics check with a difficulty of four must be made to successfully do so. Failure to pass the check will still complete the jump, but knock the entity prone at the destination. A gap of two units has a difficulty of six, and failing to pass the check will result in the entity falling into the gap. The entity may make an acrobatics check with a difficulty of four to attempt to catch the ledge and avoid falling. If they successfully grab the ledge they will now be considered climbing. A three unit gap has a difficulty of 10 and if the check to complete the jump is failed the entity may not perform an acrobatics check to grab the ledge, as it is too far away to do so. Check the falling section of this chapter for fall damage rules.<br>
		<b>Stand Up</b>: An entity may choose to use either their action or movement to stand up from being knocked prone. Using their movement will reduce their speed to zero for that turn.<br>
		<b>Squeeze</b>: Larger entities may attempt to squeeze through a small space. They will move through the smaller space at half their movement speed. Similar to climbing, this movement is done at the cost of the entity's action, and once the creature has left the small space they may continue to move normally, and may not dash, climb, attack, or perform any other action that turn.<br>
		<b>Throw</b>: An entity may throw an item from their inventory, as long as it is not worn armor or surgically implanted. Thrown items may travel up to five units, and is considered an attack if the thrown item is intended to hit a target. Doing one wound of an appropriate damage type as decided by the Game Master. Fragile items may also be destroyed at either the Game Master's discretion or a coin flip. Though a fragile beaker of acid thrown as a weapon should likely always break on impact. Mechanical consistency is often reassuring to players.<br>
		<b>Pickup</b>: An action may be spent picking up an item from the ground. If the entity is not moving on its own, such as being carried or pulled, a situational modifier may be applied by the Game Master.<br>
		<b>Interact</b>: An entity may interact with an item in their inventory, or part of the world around them as an action. This may require a skill check to do. Such as operating a computer. Simple actions such as pulling a lever should not usually require a skill check. The condition of the world may change this. A lever being rusted requiring an athletics check to pull for example.<br>
		<b>Grab/Pull</b>: An entity may pull, or begin carrying another entity as an action. If the entity does not desire to be grabbed, the entity attempting to grab them must perform a CQC or athletics check against their defense to successfully grab them. While grabbed, they may be pulled in any direction by the entity that is holding them. The entity grabbing may only move at half their full speed, but may dash if they began their turn already holding another entity. Entities being grabbed may struggle to escape the grab using a athletics check with a difficulty of four. The entity holding them may use their action, if they have not already used it, to deny their escape attempt. Causing their escape attempt to be done with a worse(-1D6) situational modifier.<br>
		<b>Heal</b>: An entity may spend their action to perform medical treatment to heal an organic, or bio-mechanical entity. This medical skill check is separate from using a healing item on another entity, as using a healing item does not require a medical skill check. The difficulty of this medical skill check is ten while in combat and eight while out of combat, and will reduce the target's wounds by one. If done outside of combat it will take ten minutes to properly treat someone.<br>
		<b>Repair</b>: Similar to healing, an entity may perform an engineering check to repair a mechanical or bio-mechanical entity. If done during combat the difficulty of this check is ten, otherwise outside of combat the difficulty is eight. If done outside of combat it will take ten minutes to properly repair something.<br>
		<b>Sneak</b>: An entity may spend their action to begin sneaking. Carefully evaluating the situation and the path ahead of them. Entities must roll a stealth check, this becomes the difficulty for any perception check to spot them. Sneak attacks done against a target unaware of their attacker gain a great(+1D6) situational modifier bonus to their attack roll.<br>
		<b>Conceal</b>: An entity attempt to hide an object either on their person, or in another location or object. Doing so requires a stealth check if hidden on themselves, or a sleight of hand check if hiding them somewhere else, even if on another entity. See the small, and two-handed traits in the Item Traits section of this chapter for details.<br>
		<b>Steal</b>: An item may be stolen from another entity, as long as the item is not considered implanted. A sleight of hand roll with a difficulty of four is required to successfully steal an item. Attempting to steal an item from an entity aware of you is always done at a terrible(-1D8) situational modifier, regardless of other benefits. See the small, and two-handed traits in the Item Traits section of this chapter for details.<br>
		<b>Disarm</b>: Similar to stealing, attempt to remove an item actively being held by the target. a CQC check must by made against the defense of the entity. if the entity is restrained, an additional good(1d4) situational modifier is applied.<br>
		<b>Help</b>: An entity may assist another entity in performing an action. This will give a good(+1D8) situational modifier to their roll. The help action can also be used to stand a prone entity up. If the entity is resisting this, a CQC skill check with the target's defense as the difficulty must be rolled to successfully stand them up. This may also be used to lift someone hanging from a ledge onto safety. The help action may also be used to extinguish someone on fire.<br>
		<b>Look</b>: An entity may spend their action looking for threats, or to locate something nearby, based off visuals or sounds. A perception skill check is made. When locating items, normal items are a difficulty four check to locate, and small items a difficulty six check. Situational modifiers such as being hidden under debris, or darkness may be applied to increase the difficulty of the search. Having a light may make the search easier instead. When locating entities, an entity not actively attempting to sneak will have a difficulty check equal to its agility die size. Creatures that are sneaking must performing a sneak action beforehand to set the difficulty of their stealth attempt. Spotting entities in darkness is done at a bad(-1D4) situational modifier, and invisible entities gain a worse(-1d6) situational modifier. Due to the nature of invisible entities, players should be reward for creative thinking when combating them. Such as splashing them with paint, or using the ripples of water to locate their footsteps, to alter the situational modifiers in their favor.<br>
		<b>Search</b>: An entity may spend their action looking in a small area. Performing a investigation skill check. The difficulties of the check follow the same rules as when looking around.<br>

		<h3>Damage Types and Wounds</h3>
		<p>Weapons deal damage in a combination of wounds inflicted, and the damage type of the wound. For example a rifle, doing two wounds of damage, with piercing as the type. Armors can reduce the damage of the type they were made to protect against by one wound. If an attack is reduced to zero wounds before the damage is applied, the attack is considered to have been deflected by the armor as if the attack had missed. Each damage type is connected to a category. The category of a damage type is either physical or energy, and affects the way a weapon nailing it does damage. See the Nailing it section in this chapter for details. The possible damage types are as follows:</p>
		<h4>Physical</h4>
		<b>Blunt</b>: Bludgeoning impacts from weapons without a cutting edge or sharp spikes, and may be done by particularly large projectiles.<br>
		<b>Slash</b>: Knives, swords, and other bladed weapons. Projectiles do not normally cause this type of damage.<br>
		<b>Pierce</b>: Sharp spikes, and most physical projectiles use this type of damage.<br>
		<b>Acid</b>: Chemicals that cause burns or other similar disfigurement. Not many armors are made to protect against potent chemicals, such suits are often considered specialty armor.<br>
		<h4>Energy</h4>
		<b>Heat</b>: The transfer of energy into a target, causing extreme and sudden temperature rises. Laser and microwave weaponry for example.<br>
		<b>Cold</b>: Normally caused by extreme environments. Weapons that cause cold damage behave similar to heat weapons, but in reverse. Causing similar burns known as frostbite.<br>
		<b>Electricity</b>: An electrical charge is either shocked through a target in the form of a lightning bolt, or a charge potential is created in a target, electrocuting them from within. Like acid damage, most armor does not protect against it. However, this type of damage is usually caused by environmental hazards, similar to cold damage.<br>

		<h3>Item Traits</h3>
		<p>Items and weapons have unique behaviors based on the traits that they have. These are considered exceptions to the basic rules, and modify how the item performs compared to a item without the trait. All possible item traits are:</p>
		<b>Small</b>: The item is easily concealable and can be hidden with a great(+1D6) situational modifier in stealth and sleight of hand checks involving it. A small weapon may be used to perform an additional attack in a turn, but the entity attacking must spend its movement to do so, and may not perform the extra attack if they have already moved prior to attacking. See the two-handed trait for an important restriction.<br>
		<b>Consumable</b>: The item is destroyed after use, or otherwise turns into another item if not. Food or a health injector for example would behave this way. The item is intended to be useful for only a single use.<br>
		<b>Implant</b>: The item is incapable of being used, unless it has been medically implanted. Implant someone during combat is done with a medical check at a difficulty of eight. If this roll is failed, they entity being implanted will take 1 wound of damage, the implant will not be destroyed. Outside of combat, anyone with medical training(1D6) may safely implant someone. If someone without medical training attempts to implant someone, they must perform the same medical check as if the action was being done during combat.<br>
		<b>Two-Handed</b>: The item is large enough to require two hands to operate it properly. It is incapable of being easily hidden, a situational modifier of worse(-1D6) is applied to any stealth or slight of hand checks to hide the item from view. <br>
		<b>Firing Cone</b>: The item fires in a cone up to the range of the item, hitting all targets within it using the initial attack roll against each one's defense. The cone does not distinguish friend from foe. The cone is a 90 degree angle, spreading out from the edge of the entity's base.<br>
		<b>Penetrates</b>: The item fires in a line up to the range of the item, hitting all targets within it using the initial attack roll against each one's defense. The line does not distinguish friend from foe.<br>
		<b>Charge</b>: The weapon must be charged as an action prior to firing it. The next action performed must be either an attack action, or to continue holding the charge. Any other action or moving faster than half speed will reset the weapon's charge.<br>
		<b>Reload</b>: Once fired, this weapon requires an action to reload. The weapon cannot be fired again until it has been reloaded.<br>

		<h3>Armor Values</h3>
		<p>An entity may wear armor to change their defense. Different armors have varying armor values, and types of damage they reduce. The different armor values are:</p>
		<b>No Armor</b>: 4 defense.<br>
		<b>Light</b>: 6 defense.<br>
		<b>Medium</b>: 7 defense.<br>
		<b>Heavy</b>: 8 defense.<br>
		<b>Reinforced</b>: 9 defense.<br>
		<b>Advanced</b>: 10 defense.<br>
		<b>Exotic</b>: 14 defense.<br>
		<p>Every armor has a damage type that it will protect against. See the armor step of the Actions and Attacking section in this chapter for details. Advanced and exotic armor should almost always be used sparingly, or as implanted armor on monstrous creatures and machines, so it cannot be easily looted and used. It is advised that reinforced armor and above should not be available to players during character creation.</p>

		<h3>Conditions</h3>
		<p>During combat, entities may gain different status effects due to attacks, damage, environmental hazards, or PSI-Abilities. The following conditions are possible:</p>
		<b>Unconscious</b>: The entity has been knocked out. They are unable to move or perform actions, and their turn is often skipped. If combat ends with an entity knocked out, and it would be reasonable for them to not be killed. The entity may roll their body die and subtract the result from 20. This is the number of hours they will be unconscious for. A medical check may be made to heal an unconscious target, doing so will wake them. See the heal action in the Important Actions section of this chapter for details.<br>
		<b>Prone</b>: The entity has been knocked to the floor, and must use either their half their movement speed or their action to stand up. Another entity may help them stand up as an action. See the help action in the Important Actions section of this chapter for details.<br>
		<b>Restrained</b>: The entity has been restrained with an item through some means. The entity may only move at half speed, and performs all actions with a bad(1D4) situational modifier. They may also be incapable of certain tasks based on how they were restrained, and the Game Master's discretion. Such as being unable to operate a computer with their hands shoved in a bag and tied.<br>
		<b>Blind</b>: The entity is unable to see. All perception and investigation checks done by sight are always done with a terrible(-1D8) situational modifier, regardless of other bonuses. A medical check with a difficulty of six may be done to treat them. Unless the entity's eyes have been destroyed entirely, or they are intrinsically blind in some way, such as from their species or character back-story.<br>
		<b>Sleeping</b>: An entity is considered unconscious. Any action that harms the sleeping entity, or significantly disturbs them will awaken them. The entity may be carefully dragged one unit per turn in combat, and six seconds per unit out of combat without waking them. A sleeping entity always makes perception checks with a terrible(-1D8) situational modifier regardless of any other bonuses.<br>
		<b>On Fire</b>: The entity is currently smoldering. While it is not enough to do major damage, the pain is incredibly distracting. All actions are done with a bad(-1D4) situational modifier. The entity, or an ally must spend an action extinguish the fire. See the help action in the Important Actions section of this chapter for details.<br>
		<b>Freezing</b>: The entity is experiencing severe frostbite and shock. All mind and will based checks checks are made with a terrible(-1d8) situational modifier as hypothermia sets in, and their ability to think becomes dulled. Sleeping, or falling unconscious while freezing inflicts 1 mortal-trauma, and 1 point of contamination due to severe organ damage, the unconscious condition rules still apply and the entity may attempt a body check to wake up after several hours if they are not deceased. See the Contamination section in this chapter for more details. Finding any substantial source of warmth will remove the freezing condition.<br>
		<b>Suffocating</b>: The entity is drowning or asphyxiating in an unbreathable atmosphere. An entity can remain conscious for a number of turns equal to their body die size. Once this number of turns expires, they will fall unconscious, gaining one mortal-trauma. They will continue to gain contamination each turn after they fall unconscious. See the Contamination section in this chapter for more details.<br>
		<h3>Contamination</h3>
		<p>Rarely, something an entity encounters will be so toxic or traumatizing that its effects will linger far beyond the initial encounter. Disease, radioactivity, alien creatures invading their body, or having visions of other dimensions or sights beyond their comprehension. This lingering damage is treated as contamination. Every roll done by a entity will have their current contamination subtracted from it, and their maximum wounds will be subtracted by the amount of contamination they have.</p>
		<p>Contamination should not be something used often by a Game Master, and should be carefully telegraphed due to how difficult it is to remove. If an entity reaches 0 maximum wounds due to contamination, they will die as if they had reached three mortal trauma.</p>
		<p>Contamination can only be healed during downtime. See the Downtime section of this chapter for further explanation. Entities that fall unconscious due to contamination gain one mortal-trauma. Characters who are still alive, but unconscious from contamination may be healed back to consciousness. See the Healing explanation in the Other Actions section of this chapter for further details.</p>

		<h3>Psionics</h3>
		<p>Performing a PSI-Ability always comes at the cost of psionic-stress. One point of stress is gained with each use of a PSI-Ability. Additionally, PSI-Abilities have a risk of injuring their user if they are not prepared. PSI-Abilities are casted by rolling a psionics skill check. If this check is failed, the caster will take 1 wound of damage, but the PSI-Ability will still be successfully cast. Entity's knocked unconscious by a PSI-Ability cast still receive mortal-trauma.</p>
		<p>Most PSI-Abilities automatically hit a target, and must be resisted to reduce the damage or effect of the PSI-Ability. PSI-Abilities may be used freely, and do not have a limit to the number of casts an entity may make with them. However, the growing stress, and self inflicted wounds act as as soft limit to the number of casts an entity may perform without medical assistance.</p>
		<p>Constant abuse of a PSI-Ability without care may even result in contamination in the form of brain damage, at the Game Master's discretion. However this should only be done in extreme cases of PSI-Ability abuse, such as characters using healing items to constantly cast every turn past the point of double digit psionic-stress values.</p>
		<p>PSI-Ability implants purchased, or found after character creation will still require that a entity has enough memory to learn them. An entity may forget a PSI-Ability to make room for the new PSI-Ability. However, once a PSI-Ability is forgotten, it cannot be recovered, unless another implant with the same PSI-Ability is found and used.</p>

		<h3>Nailing It</h3>
		<p>When a skill check is rolled, if the result of the roll matches the difficulty of the check exactly, the roll has "nailed it." For most skill checks, this may mean that the actions was performed almost effortlessly, or with exceptional style.</p>
		<p>Nailing it's role-play results are at the Game Master's discretion, and the tone of the game being played. Some Game Masters may choose to allow ridiculous or impossible things to become possible if a player nails it. Other Game Masters may prefer a more grounded game, where an entity simply gets a bit lucky.</p>
		<p>During combat nailing it has special behaviors for attacks depending on if a unit has any points of shielding, and if the weapon's damage type category is energy or physical.</p>
		<h4>Shielded</h4>
		<b>Physical</b>: Physical damage overwhelms the shield of the target, causing the entire system to collapse. All points of shielding are removed from the target and the shield is dispersed, but no damage is taken from the attack.<br>
		<b>Energy</b>: The energy field of the attack resonates with the shield, and carves through it effortlessly. Bypassing the shield and continuing the attack into the attacks's armor reduction phase, possibly wounding the target. The shield is not dispersed, and no points of shielding are lost.<br>

		<h4>Unshielded</h4>
		<p>The attack's damage is increased by one wound, and additional effects may be applied to the target based on the damage type of the attack.</p>
		<b>Blunt, slash, or pierce</b>: The force of the attack overwhelms the target's balance. The target falls prone.<br>
		<b>Heat or electrical</b>: The target bursts into flame from the heat of the attack. The target is set on fire.<br>
		<b>Cold</b>: The target's body becomes frozen from within. The target begins freezing.<br>
		<b>Acid</b>: Will cause the target to pass out from excruciating pain. The target begins sleeping.<br>

		<h3>Ambushes</h3>
		<p>Sometimes, combat with be initiated by surprise. Either by the Game Master having an entity sneak up on the group, or the group sneaking up on an entity. Because of this, a "sneak attack" round will happen before the first actual round of combat. During this round of combat, all entities in the attacking group will have a situational modifier bonus of great(+1d6) to their rolls.</p>

		<h3>Falling</h3>
		<p>Entities that fall from a height must perform a progressively more difficult acrobatics check in order to avoid taking damage. As the falls grow in height the wounds taken from them grow in count. Entities are always knocked prone once they hit the ground. Wounds and acrobatics checks are as follows:</p>
		<b>1-2 units</b>: 0 wounds. Difficulty 4 Acrobatics check.<br>
		<b>3-6 units</b>: 1 wound. Difficulty 4 Acrobatics check.<br>
		<b>7-12 units</b>: 2 wounds. Difficulty 8 Acrobatics check.<br>
		<b>13-18 units</b>: 4 wounds. Difficulty 12 Acrobatics check.<br>
		<b>19-24 units</b>: 8 wounds. Difficulty 16 Acrobatics check.<br>
		<b>25-30 units</b>: 12 wounds. Difficulty 20 Acrobatics check.<br>
		<b>30+ units</b>: Assured Death. Difficulty 32 Acrobatics check.<br>
		<p>It is possible to safely drop up to 6 units if proper care is taken, the above table is used for situations where an entity is falling in an uncontrolled manner. Like being pushed off of a ledge, or a floor collapsing under them. To safely drop, the entity must pass a difficulty 4 acrobatics check to carefully drop themselves to a lower elevation, if successful they will not take any wounds and not be knocked prone. If they fail this check, they will instead take fall damage and be knocked prone as if they had been pushed into an uncontrolled fall.</p>

		<h3>Mortal-Trauma and Death</h3>
		<p>Mortal-Trauma is the shock and damage to an Entity's body that will eventually lead to their death. Entity's that reach three points of mortal trauma are dead without exception. Unable to keep themselves going due to extreme injury or shock. Mortal-trauma can only be healed during downtime. See the Downtime section of this chapter for an explanation.</p>
		<p>NPCs and creatures not controlled by players may ignore Mortal-Trauma, and instead die upon reaching their maximum wounds. This greatly simplifies handling enemy and NPC deaths.</p>

		<h3>Downtime</h3>
		<p></p>

		<h4>Travel</h4>
		<p></p>

		<h4>Recovery</h4>
		<p></p>

		<h3>Ships and Vehicles</h3>
		<p></p>

		<h2>Chapter 4: Entity, Creature and NPC Creation</h2>
		<p>The creation of custom entities forms the foundation of making both creatures and NPCs for players to interact with in your game. Creatures and their interactions allow the Game Master to design interesting encounters for players to overcome.</p>

		<h3>Classifications</h3>
		<p>Entities are split into several subtypes. This is to help differentiate several mechanics such as medical checks or engineering checks. All entities not controlled by a player are known as NPCs, or non-player-characters.</p>
		<b>Biological</b>: This entity is organic, and can be healed by medical checks.<br>
		<b>Mechanical</b>: This entity is some form of machine or mineral. If it is a machine it may be healed by engineering checks.<br>
		<b>Bio-Mechanical</b>: This entity is neither completely organic or mechanical. Both engineering and medical checks will work to heal them.<br>
		<b>Object</b>: This entity represents an unthinking construct or other structure. It does not matter if the structure is organic, mechanical or both. It is incapable of thinking or moving, and exists to be interacted with by other entities. Repairing these objects follows the same rules as for creatures, depending on if they are organic or machinery.<br>

		<h3>Features</h3>
		<p>Features form the backbone of an interesting entity encounter. Features allow a Game Master to apply unique rule combinations to an entity, and may also be used as a way of balancing particularly strong stats that an entity may need to perform other actions with. For example, giving a automated turret high agility for its firearms roll, but making it immobile so it cannot use the high speed it was given to rush around players.</p>
		<p>Custom features unique to an entity may also be created. Allowing for unique actions during combat, or for it to behave in specific ways when struck by certain types of damage or environmental conditions. The limits are as far as your imagination. Just be sure to run some combat tests to see if it is fun to fight! Some useful features include: </p>
		<b>Fragile</b>: This entity becomes unconscious after receiving a single wound. It is not fully destroyed until it reaches a wound count at or above its total wounds.<br>
		<b>Plodding</b>: This entity is unable to perform a dash action.<br>
		<b>Mindless</b>: This entity is unable to perform any action, but may move.<br>
		<b>Immobile</b>: This entity is unable to move on its own.<br>
		<b>Breathless</b>: This entity cannot suffocate.<br>
		<b>Gills</b>: This entity can only breathe in a fluid environment, and begins suffocating outside of it.<br>
		<b>Flying</b>: This entity may move in any direction in 3D space at its move speed. Creatures may become unable to fly if the GM deems that their method of flight has been damaged beyond use, or if the environment is unsuitable for flight. Such as using wings in a vacuum.<br>
		<b>Aquatic</b>: This entity moves at half speed if not in a liquid environment.<br>
		<b>Mimic</b>: This entity can disguise its appearance perfectly. Investigation rolls done to identify it are done with a "terrible"(-1D8) modifier.<br>
		<b>Rooted</b>: This entity must always be on or adjacent to the original tile it was originally placed on after moving. Unless uprooted through some means.<br>

		<h2>Chapter 5: Species Creation</h2>
		<p></p>

		<h2>Chapter 6: Item and Ability Creation</h2>
		<p></p>
		<h3>Weapons and Misc Items</h3>
		<p></p>
		<h3>Armor</h3>
		<p></p>
		<h3>PSI-Abilities</h3>
		<p></p>

		<h2>Chapter 7: Maps and Location Creation</h2>
		<p>Entities are often placed on a map in thought out locations called encounters. A Game Master's role is to design interesting encounters for players to overcome. Some encounters may be puzzles, or diplomacy instead of combat. Encounters may not have any entities at all, and can be entirely built around a map's design, and unique mechanics.</p>

		<h2>Chapter 8: World and Campaign Creation</h2>
		<p></p>
	</body>
</html>"}


/obj/item/paper/stardust_character_template
	name = "Stardust Character Sheet Template"
	info = {"<p>
		<b>Name</b> : ___ || <b>Player</b> : ___ <br>
		<b>Defense</b> : ___ || <b>Wounds</b> : ___ / ___ || <b>Mortal Trauma</b>: ___ / <b>3</b><br>
		<b>Shields</b> : ___ || <b>Psi-Stress</b> : ___ || <b>Contamination</b> : ___ <br>
		</p>

		<p>
		<h3>-Features-</h3>
		<b>Species</b> : ___<br>
		<b>Speed</b> : ___u<br>
		</p>

		<p>
		<h3>-Attributes and Skills-</h3>
		<h4>-BODY\[___\]-</h4>
		<b>Acrobatics</b> : ___<br>
		<b>Athletics</b> : ___<br>
		<b>Cqc</b> : ___<br>
		<b>Performance</b> : ___<br>
		<h4>-AGILITY\[___\]-</h4>
		<b>Artillery</b> : ___<br>
		<b>Firearms</b> : ___<br>
		<b>Piloting</b> : ___<br>
		<b>Sleight of Hand</b> : ___<br>
		<b>Stealth</b> : ___<br>
		<h4>-MIND\[___\]-</h4>
		<b>Computers</b> : ___<br>
		<b>Culture</b> : ___<br>
		<b>Engineering</b> : ___<br>
		<b>Investigation</b> : ___<br>
		<b>Medicine</b> : ___<br>
		<b>Science</b> : ___<br>
		<h4>-WILL\[___\]-</h4>
		<b>Insight</b> : ___<br>
		<b>Intimidation</b> : ___<br>
		<b>Perception</b> : ___<br>
		<b>Persuasion</b> : ___<br>
		<b>Psionics</b> : ___<br>
		<b>Survival</b> : ___<br>
		</p>

		<p>
		<h3>-Psionic Abilities-</h3>
		<b>Memory</b> : ___ / ___ <br>
		<br>
		</p>

		<p>
		<h3>-Inventory-</h3>
		<b>Bulk</b> : ___ / ___ <br>
		<b>Currency</b> : ___ <br>
		<br>
		</p>
		<br>
		Scan with PDA and modify as needed before reprinting."}


/obj/item/paper/stardust_item_template
	name = "Stardust Item Sheet Template"
	info = {"<p>
		<b>Name</b> : ___________<br>
		<b>Skill Check</b> : ___<br>
		<b>Target</b> : ___<br>
		<b>Range</b> : ___u<br>
		<b>Damage</b> : ___\[___\]<br>
		<b>Traits</b> : ___<br>
		<b>Price</b> : ___<br>
		<b>Storage Capacity</b> : ___<br>
		<b>Bulk</b> : ___<br>
		<br>
		Scan with PDA and modify as needed before reprinting.
		</p>"}


/obj/item/paper/stardust_armor_template
	name = "Stardust Armor Sheet Template"
	info = {"<p>
		<b>Name</b> : ___________<br>
		<b>Defense</b> : ___\[___\]<br>
		<b>Price</b> : ___<br>
		<b>Bulk</b> : ___<br>
		<br>
		Scan with PDA and modify as needed before reprinting.
		</p>"}


/obj/item/paper/stardust_psi_template
	name = "Stardust Psi-Ability Template"
	info = {"<p>
		<b>Name</b> : ___________<br>
		<b>Target</b> : ___<br>
		<b>Range</b> : ___u<br>
		<b>Damage</b> : ___\[___\]<br>
		<b>Duration</b> : ___<br>
		<b>Save Difficulty</b> : ___<br>
		<b>Saves With</b> : ___<br>
		<b>Memory Cost</b> : ___<br>
		<br>
		Scan with PDA and modify as needed before reprinting.
		</p>"}
