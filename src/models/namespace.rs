use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct Namespace {
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
}

#[derive(Serialize, Deserialize, Debug)]
pub struct NamespaceLock {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub namespace_id: Option<String>,
}
