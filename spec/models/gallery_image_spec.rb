require 'rails_helper'

RSpec.describe GalleryImage, type: :model do

  it 'has a valid factory' do
    expect(build(:gallery_image)).to be_valid
  end

  subject { GalleryImage.new }

  it { should respond_to(:image_thumb) }
  it { should respond_to(:image_medium) }
  it { should respond_to(:image_original) }
  it { should respond_to(:title) }
  it { should respond_to(:creator) }
  it { should respond_to(:date) }
  it { should respond_to(:description) }
  it { should respond_to(:source_text) }
  it { should respond_to(:source_link) }
  it { should respond_to(:format) }
  it { should respond_to(:subject) }

  it 'should be invalid without image_thumb' do
    expect( GalleryImage.create(image_thumb: '')).to be_invalid
  end

  it 'should be invalid without image_medium' do
    expect(GalleryImage.create(image_medium: '')).to be_invalid
  end

  it 'should be invalid without image_original' do
    expect(GalleryImage.create(image_original: '')).to be_invalid
  end
    
end
