require "spec_helper"

describe "catalog/hits.html.erb" do
  let :document do
    SolrDocument.new :id => "xyz", :format => "a", :fine_field_s => "xyz"
  end

  let :blacklight_config do
    Blacklight::Configuration.new.configure do |config|
      config.show.fine_field = "fine_field_s"
    end
  end

  before do
    allow(view).to receive(:has_user_authentication_provider?).and_return(false)
    allow(view).to receive(:render_document_sidebar_partial).and_return("Sidebar")
    allow(view).to receive(:has_search_parameters?).and_return(false)
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    assign :document, document
  end

  it "renders the content and sidebar panes" do
    render
    expect(rendered).to match /id="content"/
    expect(rendered).to match /id="sidebar"/
  end
end
