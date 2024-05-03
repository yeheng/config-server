use fast_log::Config;
use fast_log::consts::LogSize;
use fast_log::plugin::file_split::RollingType;
use fast_log::plugin::packer::LogPacker;
use log::LevelFilter;
use rbatis::{PageRequest, RBatis};
use rbdc_mysql::MysqlDriver;
use serde_json::json;

#[tokio::main]
async fn main() {
    fast_log::init(
        Config::new()
            .level(LevelFilter::Info)
            .chan_len(Some(100000))
            .console()
            .file_split("target/logs/",
                        LogSize::MB(1),
                        RollingType::All,
                        LogPacker {})).unwrap();

    log::info!("starting HTTP server at http://localhost:8080");

    // initialize rbatis. also you can call rb.clone(). this is  an Arc point
    let rb = RBatis::new();
    // connect to database
    rb.link(
        MysqlDriver {},
        "mysql://root:123456@localhost:3306/config_server",
    ).await.unwrap();

    let data = entity::config::ServerConfig
    ::select_page(&rb, &PageRequest::new(1, 10)).await;
    log::info!("data: {}", json!(data));

    // let json_cfg = web::JsonConfig::default()
    //     limit request payload size
    // .limit(4096)
    // only accept text/ plain content type
    // .content_type(|mime| mime == mime::APPLICATION_JAVASCRIPT_UTF_8)
    // use custom error handler
    // .error_handler(|err, _req| {
    //     error::InternalError::from_response(err, HttpResponse::Conflict().into()).into()
    // });
    // 
    // HttpServer::new(move || {
    //     App::new()
    //         .wrap(actix_web::middleware::Logger::default())
    //         .app_data(Data::new(json_cfg.clone()))
    //         .app_data(Data::new(rb.clone()))
    // }).bind(("127.0.0.1", 8080))?
    //     .run()
    //     .await
}
