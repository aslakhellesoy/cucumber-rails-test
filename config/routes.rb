ActionController::Routing::Routes.draw do |map|
  map.resources :lorries

  map.resources :sessions
  map.login '/login', :controller => 'sessions', :action => 'new', :conditions => {:method => :get}
  map.login '/logout', :controller => 'sessions', :action => 'destroy', :conditions => {:method => :get}
  map.root :controller => 'sessions', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
