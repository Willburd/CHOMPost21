use meowtonin::{ByondError, ByondResult, value::ByondValue};
use rand_distr::{Bernoulli, Distribution};
use rayon::iter::{IndexedParallelIterator, IntoParallelRefIterator, ParallelIterator};

#[byond_fn]
pub fn generate_automata(
    input: Vec<ByondValue>,
) -> ByondResult<Vec<ByondValue>> {

    let byond_list: Vec<ByondValue>;
    Ok(byond_list)
}
