require 'fileutils'

# Set the location of the development database
DEVELOPMENT_DATABASE = File.join("db", "development.sqlite3")

# This needs to complete successfully
unless system("bundle install")
  puts "Problem caused by Bundler, please correct and run the script again."
  exit
end

# Create the required directories
system("rake tmp:create")

# Database configuration for SQLite3
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

# Write the database configuration
File.open(File.join("config", "database.yml"), 'w') { |f| f.write(db_config) }

# Delete the database if it already exists, to prevent problems
File.delete(DEVELOPMENT_DATABASE) if File.exist?(DEVELOPMENT_DATABASE)

# Run the necessary rake tasks
system("rake db:migrate")
system("rake db:seed")
