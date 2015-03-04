require 'rails_helper'

RSpec.describe "admissions/index", type: :view do
  before(:each) do
    assign(:admissions, [
      Admission.create!(),
      Admission.create!()
    ])
  end

  it "renders a list of admissions" do
    render
  end
end
