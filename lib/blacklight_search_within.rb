# BlacklightSearchWithin

module BlacklightSearchWithin
  autoload :ControllerOverride, 'blacklight_search_within/controller_override'
  autoload :ViewHelperOverride, 'blacklight_search_within/view_helper_override'
  autoload :RouteSets, 'blacklight_search_within/route_sets'

  require 'blacklight_search_within/version'
  require 'blacklight_search_within/engine'

  mattr_accessor :labels
  self.labels = {
    :missing => "Unknown"
  }

  
  @omit_inject = {}
  def self.omit_inject=(value)
    value = Hash.new(true) if value == true
    @omit_inject = value      
  end
  def self.omit_inject ; @omit_inject ; end
  
  def self.inject!
    unless omit_inject[:controller_mixin]
        CatalogController.send(:include, BlacklightSearchWithin::ControllerOverride) unless Blacklight::Catalog.include?(BlacklightSearchWithin::ControllerOverride)
      end

      unless omit_inject[:view_helpers]
        SearchHistoryController.send(:helper, 
          BlacklightSearchWithin::ViewHelperOverride
        ) unless
          SearchHistoryController.helpers.is_a?( 
            BlacklightSearchWithin::ViewHelperOverride
          )
         
        SearchHistoryController.send(:helper, 
          SearchWithinHelper
        ) unless
          SearchHistoryController.helpers.is_a?( 
            SearchWithinHelper
          )
      end
      
      unless BlacklightSearchWithin.omit_inject[:routes]
        Blacklight::Routes.send(:include, BlacklightSearchWithin::RouteSets)
      end
  end

  # Add element to array only if it's not already there
  def self.safe_arr_add(array, element)
    array << element unless array.include?(element)
  end
  
end
