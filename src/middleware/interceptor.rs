use rbatis::Error;
use rbatis::executor::Executor;
use rbatis::intercept::{Intercept, ResultType};
use rbatis::rbdc::db::ExecResult;
use rbs::Value;
use serde_json::json;

#[derive(Debug)]
pub struct MyInterceptor {}

#[async_trait]
impl Intercept for MyInterceptor {
    async fn before(
        &self,
        _: i64,
        _rb: &dyn Executor,
        sql: &mut String,
        args: &mut Vec<Value>,
        _result: ResultType<&mut Result<ExecResult, Error>, &mut Result<Vec<Value>, Error>>,
    ) -> Result<bool, Error> {
        println!("select_page = {}", json!(sql));
        println!("select_page = {}", json!(args));

        Ok(true)
    }

    async fn after(
        &self,
        _: i64,
        _rb: &dyn Executor,
        _sql: &mut String,
        _args: &mut Vec<Value>,
        _: ResultType<&mut Result<ExecResult, Error>, &mut Result<Vec<Value>, Error>>,
    ) -> Result<bool, Error> {
        Ok(true)
    }
}
