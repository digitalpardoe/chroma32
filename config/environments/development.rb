config.cache_classes = false

config.whiny_nils = true

config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.raise_delivery_errors = false

config.gem 'sqlite3-ruby', :lib => 'sqlite3', :version => '>= 1.2.0'
