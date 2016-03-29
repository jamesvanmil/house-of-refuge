require 'rails_helper'

RSpec.describe Admission, type: :model do

  it 'has a valid factory' do
    expect(build(:admission)).to be_valid
  end

  subject { Admission.new }

  it { should respond_to(:admission_date) }
  it { should respond_to(:for_what_committed_index) }
  it { should respond_to(:full_name) }
  it { should respond_to(:gender) }
  it { should respond_to(:history_number) }
  it { should respond_to(:image_no) }
  it { should respond_to(:parentage_index) }
  it { should respond_to(:religion_index) }
  it { should respond_to(:shared_history_number?) }
  it { should respond_to(:whereborn_city) }
  it { should respond_to(:whereborn_country) }
  it { should respond_to(:whereborn_state) }

  it 'shared_history_number? returns true if other admissions with the same number exist' do
    Admission.create(history_number: 1234)
    expect(Admission.create(history_number: 1234).shared_history_number?).to be_truthy
  end

  it 'shared_history_number? returns false if no other admissions with the same number exist' do
    Admission.create(history_number: 1234)
    expect(Admission.create(history_number: 5678).shared_history_number?).to be_falsey
  end
end
