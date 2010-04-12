class Ability
  include CanCan::Ability
  
  def initialize(user)
    # Create a blank user to prevent error if one doesn't
    # already exists (e.g. if no user is logged in)
    user ||= User.new
    
    if user.role? :admin
      
      # Administrators can to anything
      can :manage, :all
      
    elsif user.role? :client
      
      # Standard users can manage a user session
      can :manage, UserSession
      
      # Look at their own user record
      can :read, User do |user_record|
        user_record == user
      end
      
    else
      
      # Non logged in users can manage a user session
      can :manage, UserSession
      
    end
    
    # Load the abilities from application plugins
    PLUGIN_CONFIG.each_key do |plugin|
      ability_config = File.join(PLUGINS_DIR, plugin.to_s, 'config', 'ability.rb')
      eval (File.open(ability_config, "r").read) if File.exists?(ability_config)
    end
  end
end