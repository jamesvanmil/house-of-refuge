require "rails_helper"

RSpec.describe AdmissionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admissions").to route_to("admissions#index")
    end

    it "routes to #new" do
      expect(:get => "/admissions/new").to route_to("admissions#new")
    end

    it "routes to #show" do
      expect(:get => "/admissions/1").to route_to("admissions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admissions/1/edit").to route_to("admissions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admissions").to route_to("admissions#create")
    end

    it "routes to #update" do
      expect(:put => "/admissions/1").to route_to("admissions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admissions/1").to route_to("admissions#destroy", :id => "1")
    end

  end
end
