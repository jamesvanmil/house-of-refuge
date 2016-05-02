class FacetIndices < ActiveRecord::Migration
  def change
    add_index :admissions, :age, unique: false
    add_index :admissions, :for_what_committed_index, unique: false
    add_index :admissions, :religion_index, unique: false
    add_index :admissions, :parentage_index, unique: false
    add_index :admissions, :whereborn_country, unique: false
    add_index :admissions, :whereborn_state, unique: false
    add_index :admissions, :whereborn_city, unique: false
  end
end
