class GalleryImage < ActiveRecord::Base
  validates :image_thumb, :image_medium, :image_original, presence: true
end
