# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_Chroma32_session',
  :secret => '1e7dfc69c2cd809431106c4429345b7c4fb1776e16a2e8442af5f5bd1e9e67cbd6116abd2a98f901bae6ec7a446eaba05000b5793484ceda320ff43c03554028'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
