module Admin::UsersHelper
  def roles(user)
    separator = ", "
    
    string = ""
    user.roles.each do |role|
      string << "#{role.name}#{separator}"
    end
    
    string.chomp(separator).titleize
  end
end
