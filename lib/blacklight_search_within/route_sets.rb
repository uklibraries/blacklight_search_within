module BlacklightSearchWithin
  # This module is monkey-patch included into Blacklight::Routes, so that
  # map_resource will route to catalog#search_within, for our action
  # that fetches and returns range segments -- that action is
  # also monkey patched into (eg) CatalogController.
  module RouteSets
    extend ActiveSupport::Concern


    included do |klass|
      # Have to add ours BEFORE existing,
      # so catalog/search_within can take priority over
      # being considered a document ID.
      klass.default_route_sets = [:search_within] + klass.default_route_sets
    end


    protected


    # Add route for (eg) catalog/search_within, pointing to the search_within
    # method we monkey patch into (eg) CatalogController.
    def search_within(primary_resource)
      add_routes do |options|
        get "#{primary_resource}/search_within" => "#{primary_resource}#search_within"
      end
    end
  end
end
