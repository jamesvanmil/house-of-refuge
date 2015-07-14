class AddCounty < ActiveRecord::Migration
  def change
  	add_column :admissions, :whereborn_county, :string
  end
end
