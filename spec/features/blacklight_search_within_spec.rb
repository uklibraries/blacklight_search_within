require "spec_helper"

describe "Blacklight Search Within", :type => :feature do
  before do
    load_sample_documents
    CatalogController.blacklight_config = Blacklight::Configuration.new
  end

  context "with coarse field configured" do
    it "collapses index results" do
      CatalogController.configure_blacklight do |config|
        config.index.coarse_field = :coarse_field_b
      end
      search_for "coarse_test"
      expect(number_of_results_from_page(page)).to eq 2
    end
  end

  context "with fine field configured" do
    context "search box on individual item view" do
      it "searches only items related to the current item" do
        CatalogController.configure_blacklight do |config|
          config.show.fine_field = :fine_field_s
        end

        # cat example
        visit "/catalog/sample_book_cats_2"
        fill_in "q", with: "coarse_test"
        click_on "search"
        expect(number_of_results_from_page(page)).to eq 4

        # dog example
        visit "/catalog/sample_book_dogs_1"
        fill_in "q", with: "coarse_test"
        click_on "search"
        expect(number_of_results_from_page(page)).to eq 3
      end
    end
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
