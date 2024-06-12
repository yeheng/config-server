#[macro_use]
extern crate rbatis;

pub mod app;
pub mod config;
pub mod namespace;
pub mod release;
pub mod security;

pub const OP_INSERT: &str = "INSERT";
pub const OP_UPDATE: &str = "UPDATE";
pub const OP_DELETE: &str = "DELETE";
