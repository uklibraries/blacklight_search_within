require "spec_helper"

describe "Blacklight Search Within Helper" do
  let :document do
    SolrDocument.new :id => "xyz", :format => "a", :fine_field_s => "xyz"
  end

  it "inflects search_action_url for hits action" do
    expect(helper.search_within_action_url(:document => document)).to eq("/catalog/xyz/hits")
  end
end
