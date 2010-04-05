# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

catalog = Catalog.new( { :name => 'root' } )
catalog.save(:validate => false)

[ { :key => 'theme', :value => 'chroma32' }, { :key => 'name', :value => 'Chroma32' }, { :key => 'url', :value => 'http://chroma32.com/' } ].each do |setting_pair|
  setting = Setting.new( { :resource => RESOURCE_ID, :key => setting_pair[:key], :value => setting_pair[:value] } )
  setting.save
end

%w( admin client ).each do |role_name|
  role = Role.new( { :name => role_name } )
  role.hidden = true
  role.save
end
