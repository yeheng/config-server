use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct ReleaseMessage {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub message: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ReleaseHistory {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub cluster_name: Option<String>,
    pub namespace_name: Option<String>,
    pub branch_name: Option<String>,
    pub release_id: Option<i32>,
    pub operation: Option<i32>,
    pub operation_context: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Release {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub cluster_name: Option<String>,
    pub namespace_name: Option<String>,
    pub name: Option<String>,
    pub configurations: Option<String>,
    pub release_key: Option<String>,
    pub comment: Option<String>,
    pub is_abandoned: Option<bool>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct GrayReleaseRule {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub cluster_name: Option<String>,
    pub namespace_name: Option<String>,
    pub branch_name: Option<String>,
    pub rules: Option<String>,
    pub release_id: Option<i32>,
    pub branch_status: Option<i16>,
}