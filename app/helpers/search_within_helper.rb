# Additional helper methods used by view templates inside this plugin. 
module SearchWithinHelper
  def search_within_action_url(options = {})
    if options[:document]
      document = options.delete(:document)
      url_for(options.merge(:controller => "catalog", :action => "hits", :id => document[:id]))
    end
  end

  def render_document_sidebar_partial(document = @document)
    render :partial => "show_within_sidebar"
  end
end
