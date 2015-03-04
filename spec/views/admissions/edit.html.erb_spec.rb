require 'rails_helper'

RSpec.describe "admissions/edit", type: :view do
  before(:each) do
    @admission = assign(:admission, Admission.create!())
  end

  it "renders the edit admission form" do
    render

    assert_select "form[action=?][method=?]", admission_path(@admission), "post" do
    end
  end
end
