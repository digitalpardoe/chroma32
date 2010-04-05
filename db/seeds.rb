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

admin_role = Role.new
admin_role.name = 'admin'
admin_role.hidden = true
admin_role.save

client_role = Role.new
client_role.name = 'client'
client_role.hidden = true
client_role.save
