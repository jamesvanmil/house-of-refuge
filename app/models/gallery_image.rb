class GalleryImage < ActiveRecord::Base

  serialize :subject
  serialize :format

  validates_presence_of :image
  has_attached_file :image, styles: { medium: "600x600>", thumb: "400x300#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  searchable do
    text :subject
    string :subject, multiple: true
  end
end
