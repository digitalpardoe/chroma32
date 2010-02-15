require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  name  { Faker::Name.name }
  size { rand(5120) + 1 }
  content_type(:unique => false) { rand(2) == 0 ? 'image/jpeg' : 'text/plain' }
end

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