require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  name  { Faker::Name.name }
  size { rand(5120) + 1 }
  content_type(:unique => false) { rand(2) == 0 ? 'image/jpeg' : 'text/plain' }
  email { Faker::Internet.email }
  random_hash { MD5.new(rand(10000).to_s) }
end

## Catalog blueprints.

# Catalog creation is a bit more complex than it should be thanks
# to the possible self-association 'bug'.

Catalog.blueprint do
  name  { Sham.name }
  catalog_id { 1 }
end

## Document blueprints.

Document.blueprint(:root) do
  document { nil }
  name { Sham.name }
  size { Sham.size }
  content_type { Sham.content_type }
  signature { MD5.new(name) }
  catalog_id { Catalog.root.id }
end

Document.blueprint(:empty) do
  document { nil }
  name { nil }
  size { nil }
  content_type { nil }
  signature { nil }
  catalog_id { Catalog.root.id }
end

Document.blueprint do
  document { nil }
  name { Sham.name }
  size { Sham.size }
  content_type { Sham.content_type }
  signature { MD5.new(name) }
  catalog_id { Catalog.make.id }
end

## Role blueprints

Role.blueprint do
  name { Sham.name }
  hidden { false }
end

## User blueprints.

# Will be used mostly for controller testing of a user logging into
# the system, Authlogic handles most of everything else for the
# user model.

User.blueprint(:admin) do
  email { 'admin@test.com' }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.where(:name => 'admin').first, Role.where(:name => 'client').first ] }
end

User.blueprint(:client) do
  email { 'user@test.com' }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.where(:name => 'client').first ] }
end

User.blueprint(:sans_role) do
  email { 'admin@test.com' }
  password { 'testing' }
  password_confirmation { 'testing' }
end

User.blueprint do
  email { Sham.email }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.where(:name => 'client').first, Role.make ] }
end
