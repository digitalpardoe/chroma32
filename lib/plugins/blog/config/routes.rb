Rails::Application.routes.draw do |map|
  resources :articles, :only => [:index, :show]
  
  namespace :admin do
    resources :articles
  end
end
