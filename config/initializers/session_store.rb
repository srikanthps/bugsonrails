# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bugmanager_session',
  :secret      => '745e27adacea1e26284a31111cc5233067e4b6a20e6c052a9024662db07905707e27d6f1581e674bad54a27ad26a729f9c64f8a7fe4210ca7006c6d7e7d6ffbb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
