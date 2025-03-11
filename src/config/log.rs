use crate::config::CONFIG;
use std::io;
use tracing_error::ErrorLayer;
use tracing_subscriber::fmt::Layer;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt, EnvFilter, Registry};

pub fn init_log() -> Result<(), io::Error> {
    // 设置默认日志级别
    let env_filter =
        EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new(&CONFIG.log_level));

    let fmt_layer = Layer::default()
        .with_target(true)
        .with_thread_ids(true)
        .with_thread_names(true)
        .with_ansi(true);

    let err_layer = ErrorLayer::default();

    // 构建并初始化订阅者
    match Registry::default()
        .with(env_filter)
        .with(fmt_layer)
        .with(err_layer)
        .try_init()
    {
        Ok(_) => {
            log::info!("日志系统初始化成功");
            Ok(())
        }
        Err(e) => {
            eprintln!("日志初始化失败: {}", e);
            Err(io::Error::new(
                io::ErrorKind::Other,
                format!("日志初始化失败: {}", e),
            ))
        }
    }
}
