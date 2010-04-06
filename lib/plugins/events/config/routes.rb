Rails::Application.routes.draw do |map|
  resources :events, :only => [:index, :show]
  
  namespace :admin do
    resources :events
  end
end
