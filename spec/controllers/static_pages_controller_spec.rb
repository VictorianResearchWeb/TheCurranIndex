require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #history" do
    it "returns http success" do
      get :history
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #sites" do
    it "returns http success" do
      get :sites
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #scholarship" do
    it "returns http success" do
      get :scholarship
      expect(response).to have_http_status(:success)
    end
  end

end
