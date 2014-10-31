# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. Will inject range limiting behaviors
# to solr parameters creation. 
module BlacklightSearchWithin
  module ControllerOverride
    extend ActiveSupport::Concern
  
    included do
      solr_search_params_logic << :add_search_within_params
      
      unless BlacklightSearchWithin.omit_inject[:view_helpers]
        helper BlacklightSearchWithin::ViewHelperOverride
        helper SearchWithinHelper
      end
    end
  
    def add_search_within_params(solr_params, req_params)
      coarse_field = blacklight_config.index.coarse_field
      if coarse_field
        solr_params[:fq] ||= []
        solr_params[:fq] << "#{blacklight_config.index.coarse_field}:true"
      end
    end
  end
end
