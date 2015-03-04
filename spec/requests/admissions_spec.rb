require 'rails_helper'

RSpec.describe "Admissions", type: :request do
  describe "GET /admissions" do
    it "works! (now write some real specs)" do
      get admissions_path
      expect(response).to have_http_status(200)
    end
  end
end
