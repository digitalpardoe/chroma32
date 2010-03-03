Rails::Application.routes.draw do |map|
  resources :articles, :only => [:index, :show]
end
