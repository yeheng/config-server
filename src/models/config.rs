use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

///
/// App is a struct that represents the app
#[derive(Serialize, Deserialize, Debug)]
pub struct App {
    pub name: Option<String>,
    pub app_id: Option<String>,
    pub org_id: Option<String>,
    pub org_name: Option<String>,
    pub owner_name: Option<String>,
    pub owner_email: Option<String>,
}

///
/// AppNamespace is a struct that represents the namespace for an app.
#[derive(Serialize, Deserialize, Debug)]
pub struct AppNamespace {
    pub name: Option<String>,
    pub app_id: Option<String>,
    pub format: Option<String>,
    pub is_public: Option<i32>,
    pub comment: Option<String>,
}

///
/// AccessKey is a struct that represents the access key for an app.
/// openapi 接口key
#[derive(Serialize, Deserialize, Debug)]
pub struct AccessKey {
    pub app_id: Option<String>,
    pub secret: Option<String>,
    pub is_enable: Option<i32>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ServiceRegistry {
    pub id: i32,
    pub secret: Option<String>,
    pub is_enable: Option<i32>,
    pub url: Option<String>,
    pub cluster: Option<String>,
    pub data_change_created_time: Option<DateTime>,
}
