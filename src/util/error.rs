use actix_web::{HttpResponse, ResponseError};
use config::ConfigError;
use derive_more::{Display, Error};
use sea_orm::DbErr;
use serde::{Deserialize, Serialize};
use std::fmt::Debug;

#[derive(Serialize, Deserialize)]
pub struct ErrorResponse {
    code: String,
    message: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    details: Option<String>,
}

#[derive(Debug, Display, Error, Serialize)]
pub enum CustomError {
    #[display("内部服务器错误: {}", message)]
    InternalError { message: String },

    #[display("验证错误: {}", message)]
    ValidationError { message: String },

    #[display("授权错误: {}", message)]
    AuthenticationError { message: String },

    #[display("权限错误: {}", message)]
    AuthorizationError { message: String },

    #[display("未找到资源: {}", message)]
    NotFoundError { message: String },

    #[display("配置错误: {}", message)]
    ConfigError { message: String },

    #[display("数据库错误: {}", message)]
    DatabaseError { message: String },

    #[display("业务逻辑错误: {}", message)]
    BusinessError { message: String, code: String },
}

impl ResponseError for CustomError {
    fn error_response(&self) -> HttpResponse {
        let (status_code, error_code, message) = match self {
            CustomError::InternalError { message } => {
                log::error!("内部错误: {}", message);
                (
                    actix_web::http::StatusCode::INTERNAL_SERVER_ERROR,
                    "500".to_string(),
                    message.clone(),
                )
            }
            CustomError::ValidationError { message } => {
                log::warn!("验证错误: {}", message);
                (
                    actix_web::http::StatusCode::BAD_REQUEST,
                    "400".to_string(),
                    message.clone(),
                )
            }
            CustomError::AuthenticationError { message } => {
                log::warn!("认证错误: {}", message);
                (
                    actix_web::http::StatusCode::UNAUTHORIZED,
                    "401".to_string(),
                    message.clone(),
                )
            }
            CustomError::AuthorizationError { message } => {
                log::warn!("授权错误: {}", message);
                (
                    actix_web::http::StatusCode::FORBIDDEN,
                    "403".to_string(),
                    message.clone(),
                )
            }
            CustomError::NotFoundError { message } => {
                log::info!("资源未找到: {}", message);
                (
                    actix_web::http::StatusCode::NOT_FOUND,
                    "404".to_string(),
                    message.clone(),
                )
            }
            CustomError::ConfigError { message } => {
                log::error!("配置错误: {}", message);
                (
                    actix_web::http::StatusCode::INTERNAL_SERVER_ERROR,
                    "500".to_string(),
                    message.clone(),
                )
            }
            CustomError::DatabaseError { message } => {
                log::error!("数据库错误: {}", message);
                (
                    actix_web::http::StatusCode::INTERNAL_SERVER_ERROR,
                    "500".to_string(),
                    message.clone(),
                )
            }
            CustomError::BusinessError { message, code } => {
                log::warn!("业务错误 {}: {}", code, message);
                (
                    actix_web::http::StatusCode::BAD_REQUEST,
                    code.clone(),
                    message.clone(),
                )
            }
        };

        HttpResponse::build(status_code).json(ErrorResponse {
            code: error_code,
            message,
            details: None,
        })
    }

    fn status_code(&self) -> actix_http::StatusCode {
        actix_http::StatusCode::INTERNAL_SERVER_ERROR
    }
}

// 从其他类型错误转换为CustomError的实现
impl From<DbErr> for CustomError {
    fn from(error: DbErr) -> Self {
        CustomError::DatabaseError {
            message: error.to_string(),
        }
    }
}

impl From<ConfigError> for CustomError {
    fn from(error: ConfigError) -> Self {
        CustomError::ConfigError {
            message: error.to_string(),
        }
    }
}

impl From<std::io::Error> for CustomError {
    fn from(error: std::io::Error) -> Self {
        CustomError::InternalError {
            message: format!("IO错误: {}", error),
        }
    }
}

impl From<serde_json::Error> for CustomError {
    fn from(error: serde_json::Error) -> Self {
        CustomError::ValidationError {
            message: format!("JSON解析错误: {}", error),
        }
    }
}

impl From<jsonwebtoken::errors::Error> for CustomError {
    fn from(error: jsonwebtoken::errors::Error) -> Self {
        CustomError::AuthenticationError {
            message: format!("JWT错误: {}", error),
        }
    }
}
