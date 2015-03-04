class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|

      t.timestamps null: false
    end
  end
end
