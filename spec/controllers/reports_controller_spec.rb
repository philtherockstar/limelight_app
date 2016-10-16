require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #stages_this_year" do
    it "returns http success" do
      get :stages_this_year
      expect(response).to have_http_status(:success)
    end
  end

end
