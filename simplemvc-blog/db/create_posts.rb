require 'sqlite3'

db = SQLite3::Database.new File.join("db", "app.db")

db.execute <<SQL
create table posts (
id integer primary key,
header varchar(250),
content text,
created_at datetime default null
)
SQL
