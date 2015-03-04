require 'rails_helper'

RSpec.describe "admissions/show", type: :view do
  before(:each) do
    @admission = assign(:admission, Admission.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
