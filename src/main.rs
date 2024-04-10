use actix_web::App;
use actix_web::HttpServer;
use actix_web::middleware;
use actix_web::web;

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    log::info!("starting HTTP server at http://localhost:8080");

    let factory = || {
        App::new()
            // enable logger
            .wrap(middleware::Logger::default())
            .app_data(web::JsonConfig::default().limit(4096)) // <- limit size of the payload (global configuration)
    };
    HttpServer::new(factory)
        .bind(("127.0.0.1", 8080))?
        .run()
        .await
}