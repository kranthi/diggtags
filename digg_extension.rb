# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DiggExtension < Radiant::Extension
#  version "1.0"
#  description "Describe your extension here"
#  url "http://yourwebsite.com/digg"
  
  # define_routes do |map|
  #   map.connect 'admin/digg/:action', :controller => 'admin/digg'
  # end
  
#  def activate
    # admin.tabs.add "Digg", "/admin/digg", :after => "Layouts", :visibility => [:all]
#  end
  
#  def deactivate
    # admin.tabs.remove "Digg"
#  end


  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/link_roll"
  
   define_routes do |map|
  #   map.connect 'admin/link_roll/:action', :controller => 'admin/link_roll'
    map.namespace :admin, :member=> { :remove => :get } do |admin|
      admin.resources :digg
    end
   end
  
  def activate
    # admin.tabs.add "Link Roll", "/admin/link_roll", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "DIGG", "/admin/diggs", :after => "Pages" 
    Page.send :include, DiggTags
  end
  
  def deactivate
    # admin.tabs.remove "Link Roll"
  end
    
end
