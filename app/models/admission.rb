class Admission < ActiveRecord::Base
  ## Sunspot search
  searchable do
    text  :by_whom_committed, :name, :alias, :for_what_committed, :disposal, :whereborn_city, :whereborn_state, :whereborn_country, :parentage, :religion
    boolean :complaint_of_father
    boolean :complaint_of_mother
    boolean :complaint_of_police
    boolean :appearance_bad
    boolean :appearance_good
    boolean :can_read
    boolean :can_write
    boolean :father_drinks
    boolean :father_living
    boolean :had_regular_work
    boolean :has_step_father
    boolean :has_step_mother
    boolean :mother_drinks
    boolean :mother_living
    boolean :played_truant
    boolean :swears
    boolean :uses_liquour
    boolean :uses_tobacco
    string :gender
    string :no_of_reader
    integer :age
    integer :no_of_times_in_refuge
    integer :history_number
  end

  def shared_history_number?
    Admission.where(history_number: self.history_number).count > 1
  end
end
