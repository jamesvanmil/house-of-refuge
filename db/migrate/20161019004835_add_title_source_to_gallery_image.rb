class AddTitleSourceToGalleryImage < ActiveRecord::Migration
  def change
    add_column :gallery_images, :title_source, :text
  end
end
