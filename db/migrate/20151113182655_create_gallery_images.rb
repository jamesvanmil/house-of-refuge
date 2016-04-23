class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.text :image_thumb
      t.text :image_medium
      t.text :image_original
      t.text :title
      t.text :creator
      t.text :date
      t.text :description
      t.text :source_text
      t.text :source_link
      t.text :format, array: true
      t.text :subject, array: true

      t.timestamps null: false
    end
  end
end
