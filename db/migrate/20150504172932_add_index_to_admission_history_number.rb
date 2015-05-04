class AddIndexToAdmissionHistoryNumber < ActiveRecord::Migration
  def change
    add_index :admissions, :history_number
  end
end
