class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    if user.role? :admin
      can :manage, :all
    else
      can :manage, UserSession
      can :create, User
      can :read, User do |user_record|
        user_record == user
      end
    end
    
    Dir.glob("#{PLUGINS_DIR}/*").each do |dir|
      ability_config = File.join(dir, 'config', 'ability.rb')
      eval (File.open(ability_config, "r").read) if File.exists?(ability_config)
    end
  end
end