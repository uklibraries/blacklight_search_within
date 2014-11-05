module BlacklightSearchWithin
  module RouteSets
    extend ActiveSupport::Concern

    included do |klass|
      # Have to add ours BEFORE existing,
      # so catalog/search_within can take priority over
      # being considered a document ID.
      klass.default_route_sets = [:hits] + klass.default_route_sets
    end

    protected

    # Add route for (eg) catalog/hits, pointing to the hits
    # method we monkey patch into (eg) CatalogController.
    def hits(primary_resource)
      add_routes do |options|
        get "#{primary_resource}/:id/hits" => "#{primary_resource}#hits"
      end
    end
  end
end
