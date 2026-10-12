//! Metadata functions
use const_format::formatcp as const_format;

#[byond_fn]
pub fn aleslumin_version() -> &'static str {
    const_format!(
        "{name} v{version} ({git_hash})",
        name = env!("CARGO_PKG_NAME"),
        version = env!("CARGO_PKG_VERSION"),
        git_hash = env!("BOSION_GIT_COMMIT_SHORTHASH")
    )
}

#[byond_fn]
pub fn aleslumin_features() -> &'static str {
    env!("BOSION_CRATE_FEATURES")
}

#[byond_fn]
pub fn aleslumin_cleanup() {}
