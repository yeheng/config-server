use actix_web::web::{self, ServiceConfig};

use crate::util::error::CustomError;

// 提取JSON错误处理为独立函数
fn handle_json_error(
    err: actix_web::error::JsonPayloadError,
    _req: &actix_web::HttpRequest,
) -> actix_web::Error {
    match &err {
        actix_web::error::JsonPayloadError::ContentType => {
            log::warn!("JSON内容类型错误: {}", err);
            CustomError::ValidationError {
                message: "请求内容类型必须为application/json".to_string(),
            }
            .into()
        }
        actix_web::error::JsonPayloadError::Deserialize(json_err) => {
            log::warn!("JSON反序列化错误: {} - {}", err, json_err);
            CustomError::ValidationError {
                message: format!("JSON格式无效: {}", json_err),
            }
            .into()
        }
        actix_web::error::JsonPayloadError::Payload(payload_err) => {
            log::warn!("JSON负载错误: {} - {}", err, payload_err);
            CustomError::ValidationError {
                message: format!("JSON数据读取失败: {}", payload_err),
            }
            .into()
        }
        actix_web::error::JsonPayloadError::Overflow { limit: _ } => {
            log::warn!("JSON数据超出大小限制: {}", err);
            CustomError::ValidationError {
                message: "请求数据超出大小限制".to_string(),
            }
            .into()
        }
        _ => {
            log::error!("未知的JSON错误: {}", err);
            CustomError::InternalError {
                message: format!("处理JSON请求时发生错误: {}", err),
            }
            .into()
        }
    }
}

// 应用全局错误处理器
pub fn setup_error_handlers(config: &mut ServiceConfig) {
    config.app_data(
        web::JsonConfig::default()
            .limit(4096)
            .error_handler(handle_json_error),
    );

    config.app_data(web::QueryConfig::default().error_handler(|err, _| {
        log::warn!("查询参数解析错误: {}", err);
        CustomError::ValidationError {
            message: format!("查询参数无效: {}", err),
        }
        .into()
    }));

    config.app_data(web::PathConfig::default().error_handler(|err, _| {
        log::warn!("路径参数解析错误: {}", err);
        CustomError::ValidationError {
            message: format!("URL路径参数无效: {}", err),
        }
        .into()
    }));
}
