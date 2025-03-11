use std::env;
use std::path::Path;
use std::process::exit;
use std::{collections::HashMap, fs};

use crate::config::model::ApplicationConfig;
use config::{builder::DefaultState, Config, ConfigBuilder, ConfigError, Environment, File};
use log::{debug, error, info, warn};

impl ApplicationConfig {
    // 创建新的ApplicationConfig实例
    pub fn new() -> Result<Self, ConfigError> {
        // 从环境变量获取运行模式,默认为"dev"
        let run_mode = env::var("RUN_MODE").unwrap_or_else(|_| {
            debug!("RUN_MODE 环境变量未设置，使用默认值 'dev'");
            "dev".into()
        });
        info!("应用运行模式: {}", run_mode);

        // 构建配置并记录加载状态
        let mut builder = Config::builder();

        // 添加默认配置文件
        builder = Self::add_source_file(builder, "/etc/config_server/default.toml", false);
        builder = Self::add_source_file(builder, "./etc/default.toml", false);

        // 添加环境特定配置
        let env_config_path = format!("./etc/config/{}.toml", run_mode);
        builder = Self::add_source_file(builder, &env_config_path, false);

        let env_config_path_abs = format!("/etc/config_server/{}.toml", run_mode);
        //.map_err(|e| ConfigError::Message(format!("Failed to build configuration: {}", e)))?;
        builder = Self::add_source_file(builder, &env_config_path_abs, false);

        info!("从环境变量(前缀:cs)加载配置");
        builder = builder.add_source(Environment::with_prefix("cs").try_parsing(true));

        // 构建并反序列化配置o_string(),
        match builder.build() {
            Ok(s) => {
                debug!("配置已成功加载");
                match s.try_deserialize() {
                    Ok(config) => {
                        debug!("配置反序列化成功");
                        Ok(config)
                    }
                    Err(e) => {
                        error!("配置反序列化失败: {}", e);
                        Err(e)
                    }
                }
            }
            Err(e) => {
                error!("配置构建失败: {}", e);
                Err(e)
            }
        }
    }

    // 辅助方法：添加配置源并记录日志
    fn add_source_file(
        builder: ConfigBuilder<DefaultState>,
        path: &str,
        required: bool,
    ) -> ConfigBuilder<DefaultState> {
        // 检查路径是否有效
        if !Path::new(path).is_valid_path() {
            error!("无效的配置文件路径: {}", path);
            return builder;
        }

        // 尝试将路径转换为绝对路径
        let canonical_path = match fs::canonicalize(path) {
            Ok(p) => p,
            Err(_) => {
                error!("无法解析配置文件路径: {}", path);
                return builder;
            }
        };

        let path_exists = canonical_path.exists();
        if path_exists {
            info!("加载配置文件: {}", canonical_path.display());
            return builder.add_source(File::with_name(path).required(required));
        } else if required {
            error!("必需的配置文件不存在: {}", canonical_path.display());
            exit(1)
        } else {
            warn!("非必需的配置文件不存在: {}", canonical_path.display());
        }

        builder
    }
    // 根据错误代码获取错误信息
    pub fn get_error_info(&self, code: &str) -> String {
        match self.errors.get(code) {
            None => match self.errors.get("-1") {
                None => "unknown error".to_string(),
                Some(v) => v.to_string(),
            },
            Some(v) => v.as_str().to_string(),
        }
    }

    // 初始化错误信息
    pub fn init_infos(&mut self) {
        self.error_infos = Some(HashMap::new());
        for (k, error) in &self.errors {
            let mut error = error.to_string();
            // 如果错误信息包含逗号,只取逗号前的部分
            if error.contains(",") {
                error = error[0..error.find(",").unwrap()].to_string();
            }
            self.error_infos
                .as_mut()
                .unwrap()
                .insert(error, k.to_string());
        }
    }
}

// 假设有一个 is_valid_path 方法来检查路径的有效性
trait PathExt {
    fn is_valid_path(&self) -> bool;
}

impl PathExt for Path {
    fn is_valid_path(&self) -> bool {
        // 简单示例，实际应用中可以根据需求实现更复杂的路径验证逻辑
        self.file_name().is_some()
    }
}

// 定义一个宏来获取错误信息
#[macro_export]
macro_rules! error_info {
    ($code: expr) => {
        $crate::config::CONFIG.get_error_info($code)
    };
}
