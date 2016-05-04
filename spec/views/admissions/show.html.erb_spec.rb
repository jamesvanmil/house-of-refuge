require 'rails_helper'

RSpec.describe "admissions/show", type: :view do
  describe "related admissions" do
    before(:each) do
      @admission1 = create(:admission, history_number: 1)
      @admission2 = create(:admission, history_number: 1)
      @admission3 = create(:admission, history_number: 1)
      @admission4 = create(:admission, history_number: 2)
      visit admission_path(@admission1)
    end

    it "are displayed with the same history number" do
      expect(page).to have_link(admission_path @admission2)
      expect(page).to have_link(admission_path @admission3)
    end

    it "are not displayed with different history numbers" do
      expect(page).to have_no_link(admission_path @admission4)
    end
  end
end
