use actix_web::HttpResponse;
use actix_web::{http::header, middleware::DefaultHeaders, web, App, HttpServer};
use actix_web_lab::middleware::NormalizePath;
use config_server::{config::app_log, module, util::error::CustomError, AppState};
use config_server::{
    config::CONFIG, middleware::cors::configure_cors,
    middleware::error_handler::setup_error_handlers,
};
use std::net::SocketAddr;
use std::{io, sync::Arc};
use tracing_actix_web::TracingLogger;

#[actix_web::main]
async fn main() -> io::Result<()> {
    // 初始化日志
    if let Err(e) = app_log::init_log() {
        eprintln!("日志初始化失败: {}", e);
        return Err(io::Error::new(io::ErrorKind::Other, "日志初始化失败"));
    }

    // 使用 SocketAddr 表示服务器地址
    let address: SocketAddr = format!("{}:{}", CONFIG.server.host, CONFIG.server.port)
        .parse()
        .map_err(|e| {
            log::error!("服务器地址解析失败: {}", e);
            io::Error::new(
                io::ErrorKind::InvalidInput,
                format!("无效的服务器地址: {}", e),
            )
        })?;
    log::info!("Server running at http://{}", address);

    // 获取workers数量，默认为CPU核心数
    let workers = CONFIG.server.workers.unwrap_or(num_cpus::get());
    log::info!("Workers: {}", workers);

    // 创建共享应用状态
    let app_state = Arc::new(AppState::new());

    // 创建并配置 HTTP 服务器
    HttpServer::new(move || {
        App::new()
            // 添加应用状态
            .app_data(web::Data::from(app_state.clone()))
            // 配置错误处理
            .configure(setup_error_handlers)
            .wrap(NormalizePath::trim()) // 首先规范化路径
            .wrap(TracingLogger::default())
            .wrap(configure_cors())
            .wrap(DefaultHeaders::new().add(header::ContentType::json()))
            // 模块路由
            .configure(module::route::router)
            // 添加默认错误处理器
            .default_service(web::to(|| async {
                log::warn!("请求了不存在的路由");
                HttpResponse::NotFound().json(CustomError::NotFoundError {
                    message: "请求的资源不存在".to_string(),
                })
            }))
    })
    .workers(workers) // 根据CPU核心数自动设置工作线程
    .keep_alive(std::time::Duration::from_secs(CONFIG.server.keep_alive)) // 配置keep-alive
    .bind(&address)?
    .run()
    .await
}
