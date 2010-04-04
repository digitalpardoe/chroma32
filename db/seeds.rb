# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

catalog = Catalog.new( { :name => 'root' } )
catalog.save(:validate => false)

Setting.create(:resource => RESOURCE_ID, :key => 'theme', :value => 'chroma32')
Role.create( [ { :name => 'admin', :protected => true }, { :name => 'client', :protected => true } ] )
