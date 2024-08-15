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

/datum/dna/gene
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
/datum/dna/gene/proc/is_active(var/mob/M)
	return (M.active_genes && (name in M.active_genes)) // Traitgenes edit - Use name instead, cannot use type with dynamically setup traitgenes. It is always unique due to the block number being appended to it.

// Return 1 if we can activate.
// HANDLE MUTCHK_FORCED HERE!
/datum/dna/gene/proc/can_activate(var/mob/M, var/flags)
	return 0

// Called when the gene activates.  Do your magic here.
/datum/dna/gene/proc/activate(var/mob/M, var/connected, var/flags)
	return

/**
* Called when the gene deactivates.  Undo your magic here.
* Only called when the block is deactivated.
*/
/datum/dna/gene/proc/deactivate(var/mob/M, var/connected, var/flags)
	return

// This section inspired by goone's bioEffects.

/* Traitgenes edit - Disabled due to no maintenance or calls
/**
* Called in each life() tick.
*/
/datum/dna/gene/proc/OnMobLife(var/mob/M)
	return

/**
* Called when the mob dies
*/
/datum/dna/gene/proc/OnMobDeath(var/mob/M)
	return

/**
* Called when the mob says shit
*/
/datum/dna/gene/proc/OnSay(var/mob/M, var/message)
	return message

/**
* Called after the mob runs update_icons.
*
* @params M The subject.
* @params g Gender (m or f)
* @params fat Fat? (0 or 1)
*/
/datum/dna/gene/proc/OnDrawUnderlays(var/mob/M, var/g, var/fat)
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


/datum/dna/gene/basic
	name="BASIC GENE"

	// Mutation to give
	var/mutation=0

	// Activation probability
	var/activation_prob=45

	// Possible activation messages
	var/list/activation_messages=list()

	// Possible deactivation messages
	var/list/deactivation_messages=list()

/datum/dna/gene/basic/can_activate(var/mob/M,var/flags)
	if(flags & MUTCHK_FORCED)
		return 1
	// Probability check
	return probinj(activation_prob,(flags&MUTCHK_FORCED))

/datum/dna/gene/basic/activate(var/mob/M)
	M.mutations.Add(mutation)
	if(activation_messages.len)
		var/msg = pick(activation_messages)
		to_chat(M, "<span class='notice'>[msg]</span>")

/datum/dna/gene/basic/deactivate(var/mob/M)
	M.mutations.Remove(mutation)
	if(deactivation_messages.len)
		var/msg = pick(deactivation_messages)
		to_chat(M, "<span class='warning'>[msg]</span>")
*/



// Traitgenes edit - Genes are linked to traits now. Because no one bothered to maintain genes, and instead jumped through two different trait systems to avoid them. So here we are. - Willbird
/////////////////////
// TRAIT GENES
//
// Activate traits with a message when enabled
//
/////////////////////


/datum/dna/gene/trait
	desc="Gene linked to a trait."
	var/activation_prob=100 // For sanity sakes, at least right now...
	var/datum/trait/linked_trait = null // Internal use, do not assign.
	var/list/conflict_traits = list() // Cache known traits that don't work with this one, instead of doing it all at once, or EVERY time we do a mutation check

/datum/dna/gene/trait/Destroy()
	// unlink circular reference
	if(linked_trait)
		linked_trait.linked_gene = null
	linked_trait = null
	. = ..()

// Use these when displaying info to players
/datum/dna/gene/trait/proc/get_name()
	if(linked_trait)
		return linked_trait.name
	return name

/datum/dna/gene/trait/proc/get_desc()
	if(linked_trait)
		return linked_trait.desc
	return desc

/datum/dna/gene/trait/can_activate(var/mob/M,var/flags)
	// Probability checks only
	if(flags & MUTCHK_FORCED || activation_prob >= 100)
		return TRUE
	return probinj(activation_prob,(flags&MUTCHK_FORCED))

/datum/dna/gene/trait/proc/has_conflict(var/list/traits_to_check, var/quick_scan = TRUE)
	// Behold the CONFLICT-O-TRON. Checks for trait conflicts the same way code\modules\client\preference_setup\vore\07_traits.dm does,
	// and then caches the results. Cause traits can't change conflicts mid-round. Unless that changes someday, god help us all if so.

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
		var/first = TRUE // makes setup log less spammy
		conflict_traits[P] = FALSE

		var/datum/trait/instance_test = all_traits[P]
		if(path in instance_test.excludes)
			conflict_traits[P] = TRUE
			has_conflict = TRUE
			// depending on scan mode we want to scan all, or only the first failure
			if(quick_scan)
				return TRUE
			else
				if(first)
					first = FALSE
					log_world("DNA2: Trait gene for [get_name()], conflicts with [ instance_test.name ]. Adding to known conflicts list.")
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
				else
					if(first)
						first = FALSE
						log_world("DNA2: Trait gene for [get_name()], conflicts with [ instance_test.name ]. Adding to known conflicts list.")
				continue
		for(var/V in linked_trait.var_changes_pref)
			if(V in instance_test.var_changes_pref)
				conflict_traits[P] = TRUE
				has_conflict = TRUE
				// depending on scan mode we want to scan all, or only the first failure
				if(quick_scan)
					return TRUE
				else
					if(first)
						first = FALSE
						log_world("DNA2: Trait gene for [get_name()], conflicts with [ instance_test.name ]. Adding to known conflicts list.")
				continue
	return has_conflict


/datum/dna/gene/trait/activate(var/mob/M)
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
			if(flags & MUTCHK_HIDEMSG <= 0)
				linked_trait.send_message( H, TRUE)

/datum/dna/gene/trait/deactivate(var/mob/M)
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
			if(flags & MUTCHK_HIDEMSG <= 0)
				linked_trait.send_message( H, FALSE)
