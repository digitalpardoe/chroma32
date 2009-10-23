# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Chroma32_session',
  :secret      => 'e396869768b116ef5ffaf4b41ea7b4e1fbd91ebde8a19febdaa1a8ae0a8ecbf941b0b9ba346d2880c71f5c92a1fa824b112623b1cf5bb4934859c1c5a0ece91e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
