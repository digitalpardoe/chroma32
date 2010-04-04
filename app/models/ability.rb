class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    if user.role? :admin
      
      can :manage, :all
      
    else
      
      can :manage, UserSession
      
      can :read, User do |user_record|
        user_record == user
      end
      
      can :read, Event do |event_record|
        if event_record
          (event_record.roles & user.roles).size > 0
        end
      end
      
      can :read, Document do |document_record|
        can_access = false
        
        document_record.catalog.events.each do |event_record|
          can_access = ((event_record.roles & user.roles).size > 0) unless can_access
        end
        
        can_access
      end
      
    end
    
    Dir.glob("#{PLUGINS_DIR}/*").each do |dir|
      ability_config = File.join(dir, 'config', 'ability.rb')
      eval (File.open(ability_config, "r").read) if File.exists?(ability_config)
    end
  end
end