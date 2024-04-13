use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

pub const OP_INSERT: &'static str = "INSERT";
pub const OP_UPDATE: &'static str = "UPDATE";
pub const OP_DELETE: &'static str = "DELETE";

///
/// App is a struct that represents the app
#[derive(Serialize, Deserialize, Debug)]
pub struct App {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub name: Option<String>,
    pub app_id: Option<String>,
    pub org_id: Option<String>,
    pub org_name: Option<String>,
    pub owner_name: Option<String>,
    pub owner_email: Option<String>,

}

rbatis::crud!(App {});
impl_select_page!(App{select_page() =>"
     if !sql.contains('count(1)'):
       `order by created_time desc`"});

///
/// AppNamespace is a struct that represents the namespace for an app.
#[derive(Serialize, Deserialize, Debug)]
pub struct AppNamespace {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub name: Option<String>,
    pub app_id: Option<String>,
    pub format: Option<String>,
    pub is_public: Option<i32>,
    pub comment: Option<String>,
}

///
/// ServiceRegistry is a struct that represents the service registry.
#[derive(Serialize, Deserialize, Debug)]
pub struct ServiceRegistry {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub secret: Option<String>,
    pub is_enable: Option<i32>,
    pub url: Option<String>,
    pub cluster: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ServerConfig {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub key: Option<String>,
    pub cluster: Option<String>,
    pub url: Option<String>,
    pub comment: Option<String>,
}

rbatis::crud!(ServerConfig {});
impl_select_page!(ServerConfig{select_page() =>"
     if !sql.contains('count(1)'):
       `order by created_time desc`"});

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

#[derive(Serialize, Deserialize, Debug)]
pub struct Item {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub namespace_id: Option<i32>,
    pub key: Option<String>,
    pub types: Option<i16>,
    pub value: Option<String>,
    pub comment: Option<String>,
    pub line_num: Option<i16>,

}

#[derive(Serialize, Deserialize, Debug)]
pub struct InstanceConfig {
    pub id: u32,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub instance_id: Option<i32>,
    pub config_app_id: Option<String>,
    pub config_cluster_name: Option<String>,
    pub config_namespace_name: Option<String>,
    pub release_key: Option<String>,
    pub release_delivery_time: Option<DateTime>,

}

#[derive(Serialize, Deserialize, Debug)]
pub struct Instance {
    pub id: u32,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub cluster_name: Option<String>,
    pub data_center: Option<String>,
    pub ip: Option<String>,

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

#[derive(Serialize, Deserialize, Debug)]
pub struct Commit {
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
    pub change_sets: Option<String>,
    pub comment: Option<String>,

}

#[derive(Serialize, Deserialize, Debug)]
pub struct Cluster {
    pub id: u32,
    pub is_deleted: Option<u8>,
    pub deleted_at: Option<DateTime>,
    pub created_by: Option<String>,
    pub created_time: Option<DateTime>,
    pub last_modified_by: Option<String>,
    pub last_modified_time: Option<DateTime>,

    pub app_id: Option<String>,
    pub name: Option<String>,
    pub parent_cluster_id: Option<i32>,
    pub comment: Option<String>,

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
