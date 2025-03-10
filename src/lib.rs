use once_cell::sync::Lazy;
use sea_orm::DatabaseConnection;

pub mod config;
pub mod entities;
pub mod middleware;
pub mod util;
pub mod module;

#[derive(Clone)]
pub struct AppState {
    conn: DatabaseConnection,
}

pub static APP_STATE: Lazy<AppState> = Lazy::new(|| AppState::new());

impl AppState {
    pub fn new() -> Self {
        let conn = middleware::datasource::connect();

        Self {
            conn,
        }
    }

    pub fn get_conn(&self) -> &DatabaseConnection {
        &self.conn
    }
}
