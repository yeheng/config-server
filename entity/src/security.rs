use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct Privilege {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub name: Option<String>,
    pub namespace_id: Option<i32>,
    pub privilege_type: Option<String>,
}

///
/// AccessKey is a struct that represents the access key for an app.
/// openapi 接口secret
#[derive(Serialize, Deserialize, Debug)]
pub struct AccessKey {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub secret: Option<String>,
    pub is_enabled: Option<bool>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Audit {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub entity_name: Option<String>,
    pub entity_id: Option<String>,
    pub op_name: Option<String>,
    pub comment: Option<String>,
}
