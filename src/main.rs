use sea_orm::{Database, DbErr};

const DATABASE_URL: &str = "mysql://root:password@localhost:3306";
const DB_NAME: &str = "bakeries_db";

async fn run() -> Result<(), DbErr> {
    let _db = Database::connect(DATABASE_URL).await?;

    Ok(())
}

fn main() {
}
