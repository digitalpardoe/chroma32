# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_Chroma32_session',
  :secret => 'd629959ed183342cf03d674d03126e5aff50ea0ca32f236dadbf7aa02cb334dd5f22fd65d7b5d946baf0ad808a37d1c28b5aae234cef515241d9bc95c447ddbf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
