require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AdmissionsHelper. For example:
#
# describe AdmissionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
#
RSpec.describe AdmissionsHelper, type: :helper do
  it 'friendly_date should return string with readable date' do
    expect(helper.friendly_date('18911020')).to eq('10/20/1891')
  end
end
