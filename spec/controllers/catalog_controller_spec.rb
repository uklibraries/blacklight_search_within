require "spec_helper"

describe CatalogController, :type => :controller do
  describe "hits action" do
    # borrowed from blacklight
    if ::Rails.version < "4.0"
      def assigns_response
        controller.instance_variable_get("@response")
      end
    else
      def assigns_response
        assigns(:response)
      end
    end

    describe "with format :html" do
      let(:id) { "sample_book_cats" }
      let(:user_query) { "coarse_test" }

      it "exists" do
        expect{get :hits, id: :id, q: :user_query}.to_not raise_error
      end
    end
  end
end
