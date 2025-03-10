use sea_orm::DatabaseConnection;

pub mod auth;
pub mod config;
pub mod entities;
pub mod middleware;
pub mod module;
pub mod util;

#[derive(Clone)]
pub struct AppState {
    conn: DatabaseConnection,
}

impl AppState {
    pub fn new() -> Self {
        let conn = middleware::datasource::connect();

        Self { conn }
    }

    pub fn get_conn(&self) -> &DatabaseConnection {
        &self.conn
    }
}
