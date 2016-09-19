class AddHandleToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :handle, :text
  end
end
