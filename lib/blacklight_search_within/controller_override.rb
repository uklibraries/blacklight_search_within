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

    def hits
      (response, @document) = get_solr_response_for_doc_id
      (@response, @document_list) = get_search_results

      respond_to do |format|
        format.html {setup_next_and_previous_documents}
        format.rss  {render :layout => false}
        format.atom {render :layout => false}
        format.json do
          render json: render_search_results_as_json
        end

        additional_response_formats(format)
        document_export_formats(format)
      end
    end

    def add_search_within_params(solr_params, req_params)
      if req_params[:fine]
        fine_field = blacklight_config.show.fine_field
        solr_params[:fq] ||= []
        solr_params[:fq] << "#{fine_field}:#{req_params[:fine]}"
        coarse_field = blacklight_config.index.coarse_field
        if coarse_field
          solr_params[:fq] << "#{coarse_field}:false"
        end
        req_params.delete(:fine)
      else
        coarse_field = blacklight_config.index.coarse_field
        if coarse_field
          solr_params[:fq] ||= []
          solr_params[:fq] << "#{coarse_field}:true"
        end
      end
    end
  end
end
