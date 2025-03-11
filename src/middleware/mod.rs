use serde::Serialize;

pub mod datasource;
pub mod response;
pub mod cors;
pub mod error_handler;

// 统一响应结构体
#[derive(Debug, Serialize)]
pub struct ResponseData {
    pub data: String,
    pub code: u16,
}
