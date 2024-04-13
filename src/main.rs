#[macro_use]
extern crate rbatis;

use actix_web::App;
use actix_web::HttpServer;
use actix_web::web;
use rbatis::{PageRequest, RBatis};
use rbdc_mysql::MysqlDriver;
use serde_json::json;

use domain::config;

pub mod domain;
pub mod middleware;
pub mod service;

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    log::info!("starting HTTP server at http://localhost:8080");

    // initialize rbatis. also you can call rb.clone(). this is  an Arc point
    let rb = RBatis::new();
    // connect to database
    rb.link(MysqlDriver {}, "mysql://root:123456@localhost:3306/config_server")
        .await.unwrap();

    let data = config::ServerConfig::select_page(&rb, &PageRequest::new(1, 10)).await;
    log::info!("data: {}",  json!(data));

    let factory = || {
        App::new()
            // enable logger
            .wrap(actix_web::middleware::Logger::default())
            .app_data(web::JsonConfig::default().limit(4096)) // <- limit size of the payload (global configuration)
    };
    HttpServer::new(factory)
        .bind(("127.0.0.1", 8080))?
        .run()
        .await
}
