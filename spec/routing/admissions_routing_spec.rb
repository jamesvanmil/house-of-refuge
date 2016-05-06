require "rails_helper"

RSpec.describe AdmissionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/search-records").to route_to("admissions#index")
    end

    it "routes to #show" do
      expect(:get => "/search-records/1").to route_to("admissions#show", :id => "1")
    end

  end
end
