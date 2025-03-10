use crate::config::model::{ApplicationConfig, JwtKey};
use jsonwebtoken::{DecodingKey, EncodingKey};
pub use log as app_log;
use ::log::error;
use once_cell::sync::Lazy;

pub mod config;
pub mod log;
pub mod model;

pub static CONFIG: Lazy<ApplicationConfig> = Lazy::new(|| {
    ApplicationConfig::new()
        .map_err(|e| {
            error!("Failed to create ApplicationConfig: {}", e);
            std::process::exit(1);
        })
        .unwrap()
});
pub static JWT_KEY: Lazy<JwtKey> = Lazy::new(|| JwtKey {
    encoding_key: EncodingKey::from_ed_pem(CONFIG.jwt.encode_key.as_bytes()).unwrap(),
    decoding_key: DecodingKey::from_ed_pem(CONFIG.jwt.decode_key.as_bytes()).unwrap(),
});
