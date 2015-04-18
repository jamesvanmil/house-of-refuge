class Admission < ActiveRecord::Base
  ## Sunspot search
  searchable do
    text  :by_whom_committed, :name, :alias, :for_what_committed, :disposal, :whereborn_city, :whereborn_state, :whereborn_country, :parentage
    boolean :complaint_of_father, :complaint_of_mother, :complaint_of_police, :appearance_bad, :appearance_good, :can_read, :can_write, :father_drinks, :father_living, :had_regular_work, :has_step_father, :has_step_mother, :mother_drinks, :mother_living, :played_truant, :swears, :uses_liquour, :uses_tobacco
    integer :age, :no_of_times_in_refuge, :history_number
    text :no_of_reader, :gender, :whereborn_city, :whereborn_state, :whereborn_country, :religion, :parentage, :image_no
  end
end
