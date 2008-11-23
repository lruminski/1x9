ActionController::Routing::Routes.draw do |map|
  map.connect '', :controller => 'public', :action => 'index'
  map.connect 'datasource', :controller => 'public', :action => 'datasource'
  map.connect ':req', :controller => 'public', :action => 'index', :req => /.*/
end
