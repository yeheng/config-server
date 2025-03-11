use actix_cors::Cors;
use actix_web::http::header;
// 配置CORS策略
pub fn configure_cors() -> Cors {
    // 生产环境应该根据实际需求配置，而非使用permissive
    Cors::default()
        .allowed_methods(vec!["GET", "POST", "PUT", "DELETE"])
        .allowed_headers(vec![
            header::AUTHORIZATION,
            header::ACCEPT,
            header::CONTENT_TYPE,
        ])
        .max_age(3600)
}
