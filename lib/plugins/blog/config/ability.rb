if !user.role? :admin
  cannot :manage, Article
  can :read, Article
end
