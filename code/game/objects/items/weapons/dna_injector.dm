/obj/item/dnainjector
	name = "\improper DNA injector"
	desc = "This injects the person with DNA."
	icon = 'icons/obj/items.dmi'
	icon_state = "dnainjector"
	var/block=0
	var/datum/dna2/record/buf=null
	var/s_time = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	var/uses = 1
	var/nofail
	var/is_bullet = 0
	var/inuse = 0

	// USE ONLY IN PREMADE SYRINGES.  WILL NOT WORK OTHERWISE.
	var/datatype=0
	var/value=0

	// Traitgenes edit begin - Removed subtype, replaced with flag. Allows for safe injectors. Mostly for admin usage.
	var/has_radiation = TRUE
	// Traitgenes edit end

/obj/item/dnainjector/Initialize() // Traitgenes edit - Moved to init
	if(datatype && block)
		buf=new
		buf.dna=new
		buf.types = datatype
		buf.dna.ResetSE()
		//testing("[name]: DNA2 SE blocks prior to SetValue: [english_list(buf.dna.SE)]")
		SetValue(src.value)
		//testing("[name]: DNA2 SE blocks after SetValue: [english_list(buf.dna.SE)]")
	. = ..() // Traitgenes edit - Moved to init

/obj/item/dnainjector/proc/GetRealBlock(var/selblock)
	if(selblock==0)
		return block
	else
		return selblock

/obj/item/dnainjector/proc/GetState(var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.GetSEState(real_block)
	else
		return buf.dna.GetUIState(real_block)

/obj/item/dnainjector/proc/SetState(var/on, var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.SetSEState(real_block,on)
	else
		return buf.dna.SetUIState(real_block,on)

/obj/item/dnainjector/proc/GetValue(var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.GetSEValue(real_block)
	else
		return buf.dna.GetUIValue(real_block)

/obj/item/dnainjector/proc/SetValue(var/val,var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.SetSEValue(real_block,val)
	else
		return buf.dna.SetUIValue(real_block,val)

/obj/item/dnainjector/proc/inject(mob/M as mob, mob/user as mob)
	if(isliving(M) && has_radiation)
		var/mob/living/L = M
		L.apply_effect(rand(5,20), IRRADIATE, check_protection = 0)
		L.apply_damage(max(2,L.getCloneLoss()), CLONE)

	// Traitgenes edit begin - NO_SCAN and Synthetics cannot be mutated
	var/allow = TRUE
	if(M.isSynthetic())
		allow = FALSE
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.species || H.species.flags & NO_SCAN)
			allow = FALSE
	// Traitgenes edit end
	if (!(NOCLONE in M.mutations) && allow) // prevents drained people from having their DNA changed, Traitgenes edit - NO_SCAN and Synthetics cannot be mutated
		if (buf.types & DNA2_BUF_UI)
			if (!block) //isolated block?
				M.UpdateAppearance(buf.dna.UI.Copy())
				if (buf.types & DNA2_BUF_UE) //unique enzymes? yes
					M.real_name = buf.dna.real_name
					M.name = buf.dna.real_name
				uses--
			else
				M.dna.SetUIValue(block,src.GetValue())
				M.UpdateAppearance()
				uses--
		if (buf.types & DNA2_BUF_SE)
			if (!block) //isolated block?
				M.dna.SE = buf.dna.SE.Copy()
				M.dna.UpdateSE()
			else
				M.dna.SetSEValue(block,src.GetValue())
			uses--
			// Traitgenes edit - Moved gene checks to after side effects
			if(prob(5))
				trigger_side_effect(M)
		// Traitgenes edit begin - Do gene updates here, and more comprehensively
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.sync_dna_traits(FALSE,FALSE)
			H.sync_organ_dna()
		M.regenerate_icons()
		// Traitgenes edit end

	spawn(0)//this prevents the collapse of space-time continuum
		if (user)
			user.drop_from_inventory(src)
		qdel(src)
	return uses

/obj/item/dnainjector/attack(mob/M as mob, mob/user as mob)
	if (!istype(M, /mob))
		return
	if (!user.IsAdvancedToolUser())
		return
	if(inuse)
		return 0

	user.visible_message(span_danger("\The [user] is trying to inject \the [M] with \the [src]!"))
	inuse = 1
	s_time = world.time
	spawn(50)
		inuse = 0

	if(!do_after(user,50))
		return

	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.do_attack_animation(M)

	M.visible_message(span_danger("\The [M] has been injected with \the [src] by \the [user]."))

	var/mob/living/carbon/human/H = M
	if(!istype(H))
		to_chat(user, span_warning("Apparently it didn't work..."))
		return


	// Used by admin log.
	var/injected_with_monkey = ""
	/* Traitgenes edit - No monkey gene, doesn't work with the marking overlays anyway
	if((buf.types & DNA2_BUF_SE) && (block ? (GetState() && block == MONKEYBLOCK) : GetState(MONKEYBLOCK)))
		injected_with_monkey = span_danger("(MONKEY)")
	*/

	add_attack_logs(user,M,"[injected_with_monkey] used the [name] on")

	// Apply the DNA shit.
	inject(M, user)
	return


// Traitgenes edit begin - Injectors are randomized now due to no hardcoded genes. Split into good or bad, and then versions that specify what they do on the label.
// Otherwise scroll down further for how to make unique injectors
/obj/item/dnainjector/proc/pick_block(var/datum/gene/trait/G, var/labeled, var/allow_disable)
	if(G)
		block = G.block
		datatype = DNA2_BUF_SE
		value = 0xFFF
		if(allow_disable)
			value = pick(0x000,0xFFF)
		if(labeled)
			name = initial(name) + " - [value == 0x000 ? "Removes" : ""] [G.get_name()]"

/obj/item/dnainjector/random
	name = "\improper DNA injector"
	desc = "This injects the person with DNA."

// Purely rando
/obj/item/dnainjector/random/Initialize()
	pick_block( pick(GLOB.dna_genes_good + GLOB.dna_genes_neutral + GLOB.dna_genes_bad), FALSE, TRUE)
	. = ..()

/obj/item/dnainjector/random_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_good + GLOB.dna_genes_neutral + GLOB.dna_genes_bad), TRUE, TRUE)
	. = ..()

// Good/bad but also neutral genes mixed in, less OP selection of genes
/obj/item/dnainjector/random_good/Initialize()
	pick_block( pick(GLOB.dna_genes_good + GLOB.dna_genes_neutral ), FALSE, TRUE)
	. = ..()

/obj/item/dnainjector/random_good_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_good + GLOB.dna_genes_neutral ), TRUE, TRUE)
	. = ..()

/obj/item/dnainjector/random_bad/Initialize()
	pick_block( pick(GLOB.dna_genes_bad + GLOB.dna_genes_neutral ), FALSE, TRUE)
	. = ..()

/obj/item/dnainjector/random_bad_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_bad + GLOB.dna_genes_neutral ), TRUE, TRUE)
	. = ..()

// Purely good/bad genes, intended to be usually good rewards or punishments
/obj/item/dnainjector/random_verygood/Initialize()
	pick_block( pick(GLOB.dna_genes_good), FALSE, FALSE)
	. = ..()

/obj/item/dnainjector/random_verygood_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_good), TRUE, FALSE)
	. = ..()

/obj/item/dnainjector/random_verybad/Initialize()
	pick_block( pick(GLOB.dna_genes_bad), FALSE, FALSE)
	. = ..()

/obj/item/dnainjector/random_verybad_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_bad), TRUE, FALSE)
	. = ..()

// Random neutral traits
/obj/item/dnainjector/random_neutral/Initialize()
	pick_block( pick(GLOB.dna_genes_neutral ), FALSE, TRUE)
	. = ..()

/obj/item/dnainjector/random_neutral_labeled/Initialize()
	pick_block( pick(GLOB.dna_genes_neutral ), TRUE, TRUE)
	. = ..()

// If you want a unique injector, use a subtype of these
/obj/item/dnainjector/set_trait
	var/trait_path

/obj/item/dnainjector/set_trait/Initialize()
	if(trait_path && GLOB.trait_to_dna_genes[trait_path])
		pick_block( GLOB.trait_to_dna_genes[trait_path], TRUE, FALSE)
	else
		qdel(src)
		return
	. = ..()

// Only has the superpowers for loot tables and other rewards
/obj/item/dnainjector/set_trait/hulk
	trait_path = /datum/trait/positive/superpower_hulk

/obj/item/dnainjector/set_trait/xray
	trait_path = /datum/trait/positive/superpower_xray

/obj/item/dnainjector/set_trait/tk
	trait_path = /datum/trait/positive/superpower_tk

/obj/item/dnainjector/set_trait/remotetalk
	trait_path = /datum/trait/positive/superpower_remotetalk

/obj/item/dnainjector/set_trait/remoteview
	trait_path = /datum/trait/positive/superpower_remoteview

/obj/item/dnainjector/set_trait/coldadapt
	trait_path = /datum/trait/neutral/coldadapt

/obj/item/dnainjector/set_trait/hotadapt
	trait_path = /datum/trait/neutral/hotadapt

/obj/item/dnainjector/set_trait/nobreathe
	trait_path = /datum/trait/positive/superpower_nobreathe

/obj/item/dnainjector/set_trait/regenerate
	trait_path = /datum/trait/positive/superpower_regenerate

/obj/item/dnainjector/set_trait/haste
	trait_path = /datum/trait/positive/speed_fast

/obj/item/dnainjector/set_trait/flashproof
	trait_path = /datum/trait/positive/superpower_flashproof

/* Too out of date to port, only handles old UI values, can't do markings or other cosmetics... replace with promie verbs?
/obj/item/dnainjector/set_trait/morph
	trait_path = /datum/trait/positive/superpower_morph
*/

/obj/item/dnainjector/set_trait/nonconduct
	trait_path = /datum/trait/positive/nonconductive_plus

/obj/item/dnainjector/set_trait/table_passer
	trait_path = /datum/trait/positive/table_passer
// Traitgenes edit end


/* Traitgenes edit - Disable old injectors
/obj/item/dnainjector/hulkmut
	name = "\improper DNA injector (Hulk)"
	desc = "This will make you big and strong, but give you a bad skin condition."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/hulkmut/New()
	block = HULKBLOCK
	..()

/obj/item/dnainjector/antihulk
	name = "\improper DNA injector (Anti-Hulk)"
	desc = "Cures green skin."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antihulk/New()
	block = HULKBLOCK
	..()

/obj/item/dnainjector/xraymut
	name = "\improper DNA injector (Xray)"
	desc = "Finally you can see what the " + JOB_SITE_MANAGER + " does."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/xraymut/New()
	block = XRAYBLOCK
	..()

/obj/item/dnainjector/antixray
	name = "\improper DNA injector (Anti-Xray)"
	desc = "It will make you see harder."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antixray/New()
	block = XRAYBLOCK
	..()

/obj/item/dnainjector/firemut
	name = "\improper DNA injector (Fire)"
	desc = "Gives you fire."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/firemut/New()
	block = FIREBLOCK
	..()

/obj/item/dnainjector/antifire
	name = "\improper DNA injector (Anti-Fire)"
	desc = "Cures fire."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antifire/New()
	block = FIREBLOCK
	..()

/obj/item/dnainjector/telemut
	name = "\improper DNA injector (Tele.)"
	desc = "Super brain man!"
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/telemut/New()
	block = TELEBLOCK
	..()

/obj/item/dnainjector/antitele
	name = "\improper DNA injector (Anti-Tele.)"
	desc = "Will make you not able to control your mind."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antitele/New()
	block = TELEBLOCK
	..()

/obj/item/dnainjector/nobreath
	name = "\improper DNA injector (No Breath)"
	desc = "Hold your breath and count to infinity."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/nobreath/New()
	block = NOBREATHBLOCK
	..()

/obj/item/dnainjector/antinobreath
	name = "\improper DNA injector (Anti-No Breath)"
	desc = "Hold your breath and count to 100."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antinobreath/New()
	block = NOBREATHBLOCK
	..()

/obj/item/dnainjector/remoteview
	name = "\improper DNA injector (Remote View)"
	desc = "Stare into the distance for a reason."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/remoteview/New()
	block = REMOTEVIEWBLOCK
	..()

/obj/item/dnainjector/antiremoteview
	name = "\improper DNA injector (Anti-Remote View)"
	desc = "Cures green skin."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiremoteview/New()
	block = REMOTEVIEWBLOCK
	..()

/obj/item/dnainjector/regenerate
	name = "\improper DNA injector (Regeneration)"
	desc = "Healthy but hungry."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/regenerate/New()
	block = REGENERATEBLOCK
	..()

/obj/item/dnainjector/antiregenerate
	name = "\improper DNA injector (Anti-Regeneration)"
	desc = "Sickly but sated."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiregenerate/New()
	block = REGENERATEBLOCK
	..()

/obj/item/dnainjector/runfast
	name = "\improper DNA injector (Increase Run)"
	desc = "Running Man."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/runfast/New()
	block = INCREASERUNBLOCK
	..()

/obj/item/dnainjector/antirunfast
	name = "\improper DNA injector (Anti-Increase Run)"
	desc = "Walking Man."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antirunfast/New()
	block = INCREASERUNBLOCK
	..()

/obj/item/dnainjector/morph
	name = "\improper DNA injector (Morph)"
	desc = "A total makeover."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/morph/New()
	block = MORPHBLOCK
	..()

/obj/item/dnainjector/antimorph
	name = "\improper DNA injector (Anti-Morph)"
	desc = "Cures identity crisis."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antimorph/New()
	block = MORPHBLOCK
	..()

/obj/item/dnainjector/noprints
	name = "\improper DNA injector (No Prints)"
	desc = "Better than a pair of budget insulated gloves."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/noprints/New()
	block = NOPRINTSBLOCK
	..()

/obj/item/dnainjector/antinoprints
	name = "\improper DNA injector (Anti-No Prints)"
	desc = "Not quite as good as a pair of budget insulated gloves."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antinoprints/New()
	block = NOPRINTSBLOCK
	..()

/obj/item/dnainjector/insulation
	name = "\improper DNA injector (Shock Immunity)"
	desc = "Better than a pair of real insulated gloves."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/insulation/New()
	block = SHOCKIMMUNITYBLOCK
	..()

/obj/item/dnainjector/antiinsulation
	name = "\improper DNA injector (Anti-Shock Immunity)"
	desc = "Not quite as good as a pair of real insulated gloves."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiinsulation/New()
	block = SHOCKIMMUNITYBLOCK
	..()

/obj/item/dnainjector/midgit
	name = "\improper DNA injector (Small Size)"
	desc = "Makes you shrink."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/midgit/New()
	block = SMALLSIZEBLOCK
	..()

/obj/item/dnainjector/antimidgit
	name = "\improper DNA injector (Anti-Small Size)"
	desc = "Makes you grow. But not too much."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antimidgit/New()
	block = SMALLSIZEBLOCK
	..()

/////////////////////////////////////
/obj/item/dnainjector/antiglasses
	name = "\improper DNA injector (Anti-Glasses)"
	desc = "Toss away those glasses!"
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiglasses/New()
	block = GLASSESBLOCK
	..()

/obj/item/dnainjector/glassesmut
	name = "\improper DNA injector (Glasses)"
	desc = "Will make you need dorkish glasses."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/glassesmut/New()
	block = GLASSESBLOCK
	..()

/obj/item/dnainjector/epimut
	name = "\improper DNA injector (Epi.)"
	desc = "Shake shake shake the room!"
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/epimut/New()
	block = HEADACHEBLOCK
	..()

/obj/item/dnainjector/antiepi
	name = "\improper DNA injector (Anti-Epi.)"
	desc = "Will fix you up from shaking the room."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiepi/New()
	block = HEADACHEBLOCK
	..()

/obj/item/dnainjector/anticough
	name = "\improper DNA injector (Anti-Cough)"
	desc = "Will stop that awful noise."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/anticough/New()
	block = COUGHBLOCK
	..()

/obj/item/dnainjector/coughmut
	name = "\improper DNA injector (Cough)"
	desc = "Will bring forth a sound of horror from your throat."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/coughmut/New()
	block = COUGHBLOCK
	..()

/obj/item/dnainjector/clumsymut
	name = "\improper DNA injector (Clumsy)"
	desc = "Makes clumsy minions."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/clumsymut/New()
	block = CLUMSYBLOCK
	..()

/obj/item/dnainjector/anticlumsy
	name = "\improper DNA injector (Anti-Clumy)"
	desc = "Cleans up confusion."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/anticlumsy/New()
	block = CLUMSYBLOCK
	..()

/obj/item/dnainjector/antitour
	name = "\improper DNA injector (Anti-Tour.)"
	desc = "Will cure tourrets."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antitour/New()
	block = TWITCHBLOCK
	..()

/obj/item/dnainjector/tourmut
	name = "\improper DNA injector (Tour.)"
	desc = "Gives you a nasty case off tourrets."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/tourmut/New()
	block = TWITCHBLOCK
	..()

/obj/item/dnainjector/stuttmut
	name = "\improper DNA injector (Stutt.)"
	desc = "Makes you s-s-stuttterrr"
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/stuttmut/New()
	block = NERVOUSBLOCK
	..()

/obj/item/dnainjector/antistutt
	name = "\improper DNA injector (Anti-Stutt.)"
	desc = "Fixes that speaking impairment."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antistutt/New()
	block = NERVOUSBLOCK
	..()

/obj/item/dnainjector/blindmut
	name = "\improper DNA injector (Blind)"
	desc = "Makes you not see anything."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/blindmut/New()
	block = BLINDBLOCK
	..()

/obj/item/dnainjector/antiblind
	name = "\improper DNA injector (Anti-Blind)"
	desc = "ITS A MIRACLE!!!"
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antiblind/New()
	block = BLINDBLOCK
	..()

/obj/item/dnainjector/deafmut
	name = "\improper DNA injector (Deaf)"
	desc = "Sorry, what did you say?"
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/deafmut/New()
	block = DEAFBLOCK
	..()

/obj/item/dnainjector/antideaf
	name = "\improper DNA injector (Anti-Deaf)"
	desc = "Will make you hear once more."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antideaf/New()
	block = DEAFBLOCK
	..()

/obj/item/dnainjector/hallucination
	name = "\improper DNA injector (Halluctination)"
	desc = "What you see isn't always what you get."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/hallucination/New()
	block = HALLUCINATIONBLOCK
	..()

/obj/item/dnainjector/antihallucination
	name = "\improper DNA injector (Anti-Hallucination)"
	desc = "What you see is what you get."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/antihallucination/New()
	block = HALLUCINATIONBLOCK
	..()

/obj/item/dnainjector/h2m
	name = "\improper DNA injector (Human > Monkey)"
	desc = "Will make you a flea bag."
	datatype = DNA2_BUF_SE
	value = 0xFFF

/obj/item/dnainjector/h2m/New()
	block = MONKEYBLOCK
	..()

/obj/item/dnainjector/m2h
	name = "\improper DNA injector (Monkey > Human)"
	desc = "Will make you...less hairy."
	datatype = DNA2_BUF_SE
	value = 0x001

/obj/item/dnainjector/m2h/New()
	block = MONKEYBLOCK
	..()
*/
