use actix_cors::Cors;
use actix_web::{
    http::header,
    middleware::{DefaultHeaders, Logger},
    web, App, HttpServer,
};
use actix_web_httpauth::middleware::HttpAuthentication;
use actix_web_lab::middleware::NormalizePath;
use config_server::{
    config::{app_log, CONFIG},
    module,
    util::error::CustomError,
    AppState,
};
use tokio::try_join;
use tracing_actix_web::TracingLogger;

#[actix_web::main]
async fn main() {
    // 初始化日志
    app_log::init_log();

    // 格式化服务器地址
    let address = format!("{}:{}", &CONFIG.host, &CONFIG.port);
    log::info!("Server running at http://{}", address);

    // 创建并配置 HTTP 服务器
    let http_server = HttpServer::new(move || {
        App::new()
            // 添加应用状态
            .app_data(web::Data::new(AppState::new()))
            // 设置 JSON 配置,限制请求体大小
            .app_data(
                web::JsonConfig::default()
                    .limit(4096)
                    .error_handler(|err, _| {
                        CustomError::ValidationError {
                            message: format!("JSON validation error: {}", err),
                        }
                        .into()
                    }),
            )
            // 中间件链
            .wrap(TracingLogger::default())
            .wrap(Logger::default())
            .wrap(Cors::permissive())
            .wrap(DefaultHeaders::new().add(header::ContentType::json()))
            .wrap(NormalizePath::trim())
            // 模块路由
            .configure(module::route::router)
    })
    .bind(&address)
    .map_err(|e| {
        log::error!("Failed to bind to {}: {}", address, e);
        std::process::exit(1);
    })
    .expect("REASON")
    .run();
}
