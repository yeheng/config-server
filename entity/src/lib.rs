#[macro_use]
extern crate rbatis;

pub mod config;
pub mod app;
pub mod release;
pub mod namespace;
pub mod security;

pub const OP_INSERT: &str = "INSERT";
pub const OP_UPDATE: &str = "UPDATE";
pub const OP_DELETE: &str = "DELETE";
