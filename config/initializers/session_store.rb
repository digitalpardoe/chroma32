# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_Chroma32_session',
  :secret => 'a4c638530086d03caf636462b466cff1af284653d344eb8860751ab2f3fd69e2eb7b90e0438d1eb4fc479237f8c6bd78e3241b65769f423e01a32d5049e25af4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
