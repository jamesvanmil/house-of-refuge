require 'rails_helper'

RSpec.describe Admission, type: :model do

  subject { Admission.new }

  ## Administrative 
  it { should respond_to(:by_whom_committed) }
  it { should respond_to(:complaint_of_father) }
  it { should respond_to(:complaint_of_mother) }
  it { should respond_to(:complaint_of_police) }
  it { should respond_to(:date) }
  it { should respond_to(:disposal) }
  it { should respond_to(:for_what_committed) }
  it { should respond_to(:history_number) }
  it { should respond_to(:no_of_times_in_refuge) }
  it { should respond_to(:no_of_reader) }

  ## Biographic
  it { should respond_to(:age) }
  it { should respond_to(:alias) }
  it { should respond_to(:gender) }
  it { should respond_to(:name) }
  it { should respond_to(:whereborn_city) }
  it { should respond_to(:whereborn_state) }
  it { should respond_to(:whereborn_country) }
  it { should respond_to(:religion) }
  it { should respond_to(:parentage) }

  ## Other Demographic (Boolean)
  it { should respond_to(:appearance_bad) }
  it { should respond_to(:appearance_good) }
  it { should respond_to(:can_read) }
  it { should respond_to(:can_write) }
  it { should respond_to(:father_drinks) }
  it { should respond_to(:father_living) }
  it { should respond_to(:had_regular_work) }
  it { should respond_to(:has_step_father) }
  it { should respond_to(:has_step_mother) }
  it { should respond_to(:mother_drinks) }
  it { should respond_to(:mother_living) }
  it { should respond_to(:played_truant) }
  it { should respond_to(:swears) }
  it { should respond_to(:uses_liquour) }
  it { should respond_to(:uses_tobacco) }

  ## System
  it { should respond_to(:image_no) }

end
