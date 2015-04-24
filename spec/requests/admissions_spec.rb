require 'rails_helper'

RSpec.describe "Admissions", type: :request do
  describe "GET /admissions" do
    it "works" do
      get admissions_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admission/#" do
    it "works" do
      admission1 = create(:admission)
      get admission_path admission1
      expect(response).to have_http_status(200)
    end
  end
end
