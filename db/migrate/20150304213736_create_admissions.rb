class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
      t.integer :admission_date
      t.integer :age
      t.string :alias
      t.boolean :appearance_bad
      t.boolean :appearance_good
      t.string :by_whom_committed
      t.boolean :can_read
      t.boolean :can_write
      t.boolean :complaint_of_father
      t.boolean :complaint_of_mother
      t.boolean :complaint_of_police
      t.string :disposal
      t.boolean :father_drinks
      t.boolean :father_living
      t.string :for_what_committed
      t.string :for_what_committed_index
      t.string :full_name
      t.string :gender
      t.string :given_name
      t.boolean :had_regular_work
      t.boolean :has_step_father
      t.boolean :has_step_mother
      t.integer :history_number
      t.string :image_no
      t.boolean :mother_drinks
      t.boolean :mother_living
      t.text :no_of_reader
      t.integer :no_of_times_in_refuge
      t.string :parentage
      t.string :parentage_index
      t.boolean :played_truant
      t.string :religion
      t.string :religion_index
      t.string :surname
      t.boolean :swears
      t.date :trial_date
      t.boolean :uses_liquour
      t.boolean :uses_tobacco
      t.string :whereborn_city
      t.string :whereborn_county
      t.string :whereborn_country
      t.string :whereborn_state

      t.timestamps null: false
    end
  end
end
