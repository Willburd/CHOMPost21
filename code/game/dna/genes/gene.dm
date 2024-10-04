/**
* Gene Datum
*
* domutcheck was getting pretty hairy.  This is the solution.
*
* All genes are stored in a global variable to cut down on memory
* usage.
*
* @author N3X15 <nexisentertainment@gmail.com>
*/

/datum/gene // Traitgenes edit - Removed /dna/ from path... WHY WAS THIS A SUBTYPE OF DNA!? It's taking a huge struct and making 50 of them at startup, growing with every new var and list stuffed in /datum/dna - Willbird
	// Display name
	var/name="BASE GENE"

	// Probably won't get used but why the fuck not
	var/desc="Oh god who knows what this does."

	// Set in initialize()!
	//  What gene activates this?
	var/block=0

	// Any of a number of GENE_ flags.
	var/flags=0


/**
* Is the gene active in this mob's DNA?
*/
/datum/gene/proc/is_active(var/mob/M) // Traitgenes edit - Removed /dna/ from path
	return (M.active_genes && (name in M.active_genes)) // Traitgenes edit - Use name instead, cannot use type with dynamically setup traitgenes. It is always unique due to the block number being appended to it.

// Return 1 if we can activate.
// HANDLE MUTCHK_FORCED HERE!
/datum/gene/proc/can_activate(var/mob/M, var/mut_flags) // Traitgenes edit - Removed /dna/ from path. mut_flags instead of flags for clarity
	return 0

// Called when the gene activates.  Do your magic here.
/datum/gene/proc/activate(var/mob/M, var/connected, var/mut_flags) // Traitgenes edit - Removed /dna/ from path. mut_flags instead of flags for clarity
	return

/**
* Called when the gene deactivates.  Undo your magic here.
* Only called when the block is deactivated.
*/
/datum/gene/proc/deactivate(var/mob/M, var/connected, var/mut_flags) // Traitgenes edit - Removed /dna/ from path. mut_flags instead of flags for clarity
	return

// This section inspired by goone's bioEffects.

/* Traitgenes edit - Disabled due to no maintenance or calls
/**
* Called in each life() tick.
*/
/datum/gene/proc/OnMobLife(var/mob/M) // Traitgenes edit - Removed /dna/ from path
	return

/**
* Called when the mob dies
*/
/datum/gene/proc/OnMobDeath(var/mob/M) // Traitgenes edit - Removed /dna/ from path
	return

/**
* Called when the mob says shit
*/
/datum/gene/proc/OnSay(var/mob/M, var/message) // Traitgenes edit - Removed /dna/ from path
	return message

/**
* Called after the mob runs update_icons.
*
* @params M The subject.
* @params g Gender (m or f)
* @params fat Fat? (0 or 1)
*/
/datum/gene/proc/OnDrawUnderlays(var/mob/M, var/g, var/fat) // Traitgenes edit - Removed /dna/ from path
	return 0
*/

/* Traitgenes edit - Not needed anymore, only traitgenes.
/////////////////////
// BASIC GENES
//
// These just chuck in a mutation and display a message.
//
// Gene is activated:
//  1. If mutation already exists in mob
//  2. If the probability roll succeeds
//  3. Activation is forced (done in domutcheck)
/////////////////////


/datum/gene/basic // Traitgenes edit - Removed /dna/ from path
	name="BASIC GENE"

	// Mutation to give
	var/mutation=0

	// Activation probability
	var/activation_prob=45

	// Possible activation messages
	var/list/activation_messages=list()

	// Possible deactivation messages
	var/list/deactivation_messages=list()

/datum/gene/basic/can_activate(var/mob/M,var/flags) // Traitgenes edit - Removed /dna/ from path
	if(flags & MUTCHK_FORCED)
		return 1
	// Probability check
	return probinj(activation_prob,(flags&MUTCHK_FORCED))

/datum/gene/basic/activate(var/mob/M) // Traitgenes edit - Removed /dna/ from path
	M.mutations.Add(mutation)
	if(activation_messages.len)
		var/msg = pick(activation_messages)
		to_chat(M, span_notice("[msg]"))

/datum/gene/basic/deactivate(var/mob/M) // Traitgenes edit - Removed /dna/ from path
	M.mutations.Remove(mutation)
	if(deactivation_messages.len)
		var/msg = pick(deactivation_messages)
		to_chat(M, span_warning("[msg]"))
*/


// Traitgenes edit - Genes are linked to traits now. Because no one bothered to maintain genes, and instead jumped through two different trait systems to avoid them. So here we are. - Willbird
/////////////////////
// TRAIT GENES
//
// Activate traits with a message when enabled
// IMPORTANT - in 99% of situations you should NOT need to edit gene code when adding a new traitgene. Genes only handle the on/off state of traits, traits control the changes and behaviors!
// Just keep pretending genecode doesn't exist and you should be fine. Traitgenes were made with that in mind, and are not intended to be something you need to edit every time you add a traitgene.
// Traitgenes only require that your trait has both an apply() and unapply() if it does anything like adding verbs. Otherwise, you don't even need to add trait exceptions. traitgenes handle it automatically.
// You probably shouldn't mark traits as traitgenes if they are custom species only, species locked, or species banned traits however... - Willbird
/////////////////////


/datum/gene/trait
	desc="Gene linked to a trait."
	var/datum/trait/linked_trait = null // Internal use, do not assign.
	var/list/conflict_traits = list() // Cache known traits that don't work with this one, instead of doing it all at once, or EVERY time we do a mutation check

/datum/gene/trait/Destroy()
	// unlink circular reference
	if(linked_trait)
		linked_trait.linked_gene = null
	linked_trait = null
	. = ..()

// Use these when displaying info to players
/datum/gene/trait/proc/get_name()
	if(linked_trait)
		return linked_trait.name
	return name

/datum/gene/trait/proc/get_desc()
	if(linked_trait)
		return linked_trait.desc
	return desc

/datum/gene/trait/can_activate(var/mob/M,var/mut_flags)
	return TRUE // We don't do probability checks for trait genes, due to the spiderweb of logic they are with conflicting genes. Check has_conflicts() for how conflicting traits are handled.

/**
 * Behold the CONFLICT-O-TRON. Checks for trait conflicts the same way code\modules\client\preference_setup\vore\07_traits.dm does,
 * and then caches the results. Cause traits can't change conflicts mid-round. Unless that changes someday, god help us all if so.
 * You do not need to add any unique exceptions here, check trait code instead if you want to handle conflicts and forced exceptions.
 * They already handle it. This just uses the same system. - Willbird
 *
 * quick_scan = FALSE, will do a deep conflict check. Checking every trait in the list, and not just failing out at the first one that conflicts.
 *
 * Recommended way to write has_conflict calls:
 * ```
 * has_conflict(traits_to_check = list(trait_path))
 * ```
 */
/datum/gene/trait/proc/has_conflict(var/list/traits_to_check, var/quick_scan = TRUE)
	var/has_conflict = FALSE
	var/path = linked_trait.type
	for(var/P in traits_to_check)
		// don't get triggered by self
		if(P == path)
			continue

		// check if cached first...
		if(!isnull(conflict_traits[P]))
			if(quick_scan && conflict_traits[P])
				return TRUE
			continue

		// check trait if not. CONFLICT-O-TRON ENGAGE
		conflict_traits[P] = FALSE

		var/datum/trait/instance_test = all_traits[P]
		if(path in instance_test.excludes)
			conflict_traits[P] = TRUE
			has_conflict = TRUE
			// depending on scan mode we want to scan all, or only the first failure
			if(quick_scan)
				return TRUE
			continue
		for(var/V in linked_trait.var_changes)
			if(V == "flags")
				continue
			if(V in instance_test.var_changes)
				conflict_traits[P] = TRUE
				has_conflict = TRUE
				// depending on scan mode we want to scan all, or only the first failure
				if(quick_scan)
					return TRUE
				continue
		for(var/V in linked_trait.var_changes_pref)
			if(V in instance_test.var_changes_pref)
				conflict_traits[P] = TRUE
				has_conflict = TRUE
				// depending on scan mode we want to scan all, or only the first failure
				if(quick_scan)
					return TRUE
				continue
	return has_conflict

/datum/gene/trait/activate(var/mob/M, var/connected, var/mut_flags)
	if(linked_trait && ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species) // Lets avoid runtime assertions
			// Add trait
			if(linked_trait.type in H.species.traits)
				return
			linked_trait.apply( H.species, H, H.species.traits[linked_trait.type])
			H.species.traits.Add(linked_trait.type)
			if(!(linked_trait.type in H.dna.species_traits)) // Set species traits too
				H.dna.species_traits.Add(linked_trait.type)
			// message player with change
			if(!(mut_flags & MUTCHK_HIDEMSG))
				linked_trait.send_message( H, TRUE)

/datum/gene/trait/deactivate(var/mob/M, var/connected, var/mut_flags)
	if(linked_trait && ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species) // Lets avoid runtime assertions
			// Remove trait
			if(!(linked_trait.type in H.species.traits))
				return
			linked_trait.unapply( H.species, H, H.species.traits[linked_trait.type])
			linked_trait.remove(H.species) // Does nothing, but may as well call it because it exists and has a place now
			H.species.traits.Remove(linked_trait.type)
			if(linked_trait.type in H.dna.species_traits) // Clear species traits too
				H.dna.species_traits.Remove(linked_trait.type)
			// message player with change
			if(!(mut_flags & MUTCHK_HIDEMSG))
				linked_trait.send_message( H, FALSE)
