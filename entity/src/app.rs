use rbatis::rbdc::DateTime;
use serde::{Deserialize, Serialize};

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

rbatis::crud!(AppNamespace {});
impl_select_page!(AppNamespace{select_page() =>"
     if !sql.contains('count(1)'):
       `order by created_time desc`"});
