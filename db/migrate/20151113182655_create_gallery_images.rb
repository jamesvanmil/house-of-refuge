class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.text :title
      t.text :creator
      t.text :date
      t.text :description
      t.text :source_text
      t.text :source_link
      t.text :format
      t.text :subject

      t.timestamps null: false
    end
  end
end
