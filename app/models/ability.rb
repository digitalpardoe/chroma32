class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    if user.role? :admin
      
      can :manage, :all
      
    elsif user.role? :client
      
      can :manage, UserSession
      
      can :read, User do |user_record|
        user_record == user
      end
      
    else
      
      can :manage, UserSession
      
    end
    
    PLUGIN_CONFIG.each_key do |plugin|
      ability_config = File.join(PLUGINS_DIR, plugin.to_s, 'config', 'ability.rb')
      eval (File.open(ability_config, "r").read) if File.exists?(ability_config)
    end
  end
end