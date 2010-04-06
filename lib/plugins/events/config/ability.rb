if !user.role? :admin
  
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