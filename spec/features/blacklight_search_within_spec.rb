require "spec_helper"

describe "Blacklight Search Within" do
  before do
    load_sample_documents
    CatalogController.blacklight_config = Blacklight::Configuration.new
  end

  it "should collapse results if coarse_field is specified" do
    CatalogController.configure_blacklight do |config|
      config.index.coarse_field = :coarse_field_s
    end
    search_for "coarse_test"
    expect(number_of_results_from_page(page)).to eq 2
  end

  it "should not collapse results if coarse_field is not specified" do
    search_for "coarse_test"
    expect(number_of_results_from_page(page)).to eq 7
  end
end

def load_sample_documents
  docs = YAML::load(File.open(File.join(File.expand_path("../../fixtures", __FILE__), "sample_solr_documents.yml")))
  Blacklight.solr.add docs
  Blacklight.solr.commit
end

def search_for text
  visit "/"
  fill_in "q", with: text
  click_on "search"
end

def number_of_results_from_page(page)
  tmp_value = Capybara.ignore_hidden_elements
  Capybara.ignore_hidden_elements = false
  val = page.find("meta[name=totalResults]")["content"].to_i rescue 0
  Capybara.ignore_hidden_elements = tmp_value
  val
end
