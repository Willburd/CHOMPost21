GLOBAL_LIST_EMPTY(mapped_autostrips)
GLOBAL_LIST_EMPTY(mapped_autostrips_mob)

/*
This should actually be refactored if it ever needs to be used again into just being
an event controller with more graceful solutions.
Creating lockers was not graceful, in practice, and creates clutter, for example.
Repurpose this idea into a self contained machine in the future that stores and auto-equips someones gear.

But for now, for what it's been used for, it works.

*/

//Admin tool to automatically strip a human victim of all their equipment and genetics powers, and store them in a closet.
//Equips Vox/Zaddat survival gear, and a few basic pieces of clothing
/obj/effect/step_trigger/autostrip
	name = "Autostrip trigger. Set the targetid to match the effect/autostriptarget"
	var/targetid = "Default"
	var/obj/effect/autostriptarget/target
	var/obj/effect/autostriptarget/mob/Mtarget
	var/remove_implants = 0	//Havn't bothered to implement this yet
	var/remove_mutations = 0

/obj/effect/step_trigger/autostrip/Initialize(mapload)
	. = ..()
	initMappedLink()

/obj/effect/step_trigger/autostrip/Trigger(mob/living/carbon/human/H as mob)
	if(!istype(H))
		return
	if(!target)
		if(!initMappedLink())
			return
	if(Mtarget)
		H.forceMove(Mtarget.loc)
	var/obj/locker = new /obj/structure/closet/secure_closet/mind(target.loc, mind_target = H.mind)
	for(var/obj/item/W in H)
		if(istype(W, /obj/item/weapon/implant/backup)) // Outpost 21 edit - Nif removal: || istype(W, /obj/item/device/nif))
			continue	//VOREStation Edit
		if(H.drop_from_inventory(W))
			W.forceMove(locker)

	// Traitgenes edit begin - new remove genes code, didn't want to solve per-trait unique mutation shenanigans... So we just strip your entire genome. This is an admin anti-powergaming tool anyway.
	if(remove_mutations)
		for(var/datum/gene/gene in GLOB.dna_genes)
			if(gene.name in H.active_genes)
				// Setup injector
				var/obj/item/weapon/dnainjector/D = new /obj/item/weapon/dnainjector(locker)
				D.name = initial(D.name) + " - RESTORE: [gene.name]" //lazy, but we may as well support base genes... even if unused...
				D.block = gene.block
				D.buf.types = DNA2_BUF_SE
				D.SetValue( H.dna.GetSEValue(gene.block) ) // Get original block's value for the injector
				D.has_radiation = FALSE // safe to use these!
				// Turn off gene
				H.dna.SetSEState(gene.block,0)
			domutcheck(H,null,MUTCHK_FORCED)
			H.update_mutations()
	// Traitgenes edit end
	if(H.species.name == SPECIES_VOX || SPECIES_ZADDAT)	//Species that 'actually' require survival gear to live. The rest don't.
		H.species.equip_survival_gear(H)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/chameleon(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(H),slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H),slot_l_ear)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/permit(H), slot_l_hand)


/obj/effect/step_trigger/autostrip/proc/initMappedLink()
	. = FALSE
	target = GLOB.mapped_autostrips[targetid]
	Mtarget = GLOB.mapped_autostrips_mob[targetid]
	if(target)
		. = TRUE

/obj/effect/autostriptarget
	name = "Autostrip target. Link me via targetid to an autostrip trigger."
	icon = 'icons/mob/screen1.dmi'
	icon_state = "no_item1"
	var/targetid = "Default"
	unacidable = 1
	layer = 99
	anchored = 1
	invisibility = 99


/obj/effect/autostriptarget/Initialize(mapload)
	. = ..()
	if(targetid)
		GLOB.mapped_autostrips[targetid] = src

/obj/effect/autostriptarget/mob
	name = "Autostrip target to send mobs to."

/obj/effect/autostriptarget/mob/Initialize(mapload)
	if(targetid)
		GLOB.mapped_autostrips_mob[targetid] = src
