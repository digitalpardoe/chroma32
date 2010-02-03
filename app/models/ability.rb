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
  end
end