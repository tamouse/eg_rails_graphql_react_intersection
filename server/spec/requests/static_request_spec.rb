require 'rails_helper'

RSpec.describe "Statics", type: :request do

  describe "GET /welcome" do
    it "returns http success" do
      get "/static/welcome"
      expect(response).to have_http_status(:success)
    end
  end

end
