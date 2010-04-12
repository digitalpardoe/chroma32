require 'fileutils'

DEVELOPMENT_DATABASE = File.join("db", "development.sqlite3")

unless system("bundle install") then exit end

FileUtils.mkdir_p(File.join("tmp" ,"pids"))

db_config = ""
db_config << "development:\n"
db_config << "  adapter: sqlite3\n"
db_config << "  database: #{DEVELOPMENT_DATABASE}\n"
db_config << "  pool: 5\n"
db_config << "  timeout: 5000\n"
db_config << "\n"
db_config << "test:\n"
db_config << "  adapter: sqlite3\n"
db_config << "  database: db/test.sqlite3\n"
db_config << "  pool: 5\n"
db_config << "  timeout: 5000\n"
db_config << "\n"
db_config << "production:\n"
db_config << "  adapter: sqlite3\n"
db_config << "  database: db/production.sqlite3\n"
db_config << "  pool: 5\n"
db_config << "  timeout: 5000\n"

File.open(File.join("config", "database.yml"), 'w') { |f| f.write(db_config) }

File.delete(DEVELOPMENT_DATABASE) if File.exist?(DEVELOPMENT_DATABASE)

system("rake db:migrate")
system("rake db:seed")
