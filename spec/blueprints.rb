require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  catalog_name  { Faker::Name.name }
end

# Catalog creation is a bit more complex than it should be thanks
# to the possible self-association 'bug'.

Catalog.blueprint(:root) do
  id { 1 }
  name { 'root' }
end

Catalog.blueprint do
  name  { Sham.catalog_name }
  catalog_id { 1 }
end