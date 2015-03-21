require 'rails_helper'

RSpec.describe "admissions/index", type: :view do
  before(:each) do
    assign(:admissions, [
      Admission.create!(),
      Admission.create!()
    ])
  end
end
