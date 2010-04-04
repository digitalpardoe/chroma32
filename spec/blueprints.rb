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

Catalog.blueprint(:root) do
  id { 1 }
  name { 'root' }
  catalog_id { nil }
end

Catalog.blueprint do
  name  { Sham.name }
  catalog_id { 1 }
end

## Document blueprints.

Document.blueprint(:root) do
  name { Sham.name }
  size { Sham.size }
  content_type { Sham.content_type }
  signature { MD5.new(name) }
  catalog { Catalog.make(:root) }
end

Document.blueprint do
  name { Sham.name }
  size { Sham.size }
  content_type { Sham.content_type }
  signature { MD5.new(name) }
  catalog { Catalog.make }
end

## Role blueprints

Role.blueprint(:admin) do
  name { 'admin' }
  protected { true }
end

Role.blueprint(:client) do
  name { 'client' }
  protected { true }
end

Role.blueprint do
  name { Sham.name }
  protected { false }
end

## User blueprints.

# Will be used mostly for controller testing of a user logging into
# the system, Authlogic handles most of everything else for the
# user model.

User.blueprint(:admin) do
  email { 'admin@test.com' }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.make(:admin), Role.make(:client) ] }
end

User.blueprint(:client) do
  email { 'user@test.com' }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.make(:client) ] }
end

User.blueprint do
  email { Sham.email }
  password { 'testing' }
  password_confirmation { 'testing' }
  roles { [ Role.make(:client), Role.make ] }
end
