module Admin::UsersHelper
  # Creates a comma separated list of all a user's
  # currently assigned roles
  def roles(user)
    separator = ", "
    
    string = ""
    user.roles.each do |role|
      string << "#{role.name}#{separator}"
    end
    
    string.chomp(separator).titleize
  end
end
