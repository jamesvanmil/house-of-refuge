require 'rails_helper'

RSpec.describe "admissions/new", type: :view do
  before(:each) do
    assign(:admission, Admission.new())
  end

  it "renders new admission form" do
    render

    assert_select "form[action=?][method=?]", admissions_path, "post" do
    end
  end
end
