require 'rails_helper'

RSpec.describe GalleryImagesController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdmissionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #show" do
    it "assigns the requested gallery_image as @gallery_image" do
      gallery_image = GalleryImage.create!
      get :show, {:id => gallery_image.to_param}, valid_session
      expect(assigns(:gallery_image)).to eq(gallery_image)
    end
  end

  describe "GET #index" do
    before :all do
      pick_subject = proc { ['music', 'housing', 'school'].sample }

      30.times do
        FactoryGirl.create(:gallery_image,
          subject: [pick_subject.call]
        )
      end
    end

    after :all do
      GalleryImage.destroy_all
    end

    let(:limit) { subject.per_page_default }
    let(:page) { search.limit(limit).collect { |a| a.id } }
    let(:result) { assigns(:gallery_images).collect { |a| a.id } }

    context "with no params set" do
      let(:search) { GalleryImage.all }

      it "assigns first page of matching gallery_images as @gallery_images " do
        get :index, {  }, valid_session
        expect(result).to eq page
      end
    end

    context "with subjects selected" do
      let(:subject_one_value) { [GalleryImage.uniq.pluck(:subject).sample] }
      let(:subject_two_values) { GalleryImage.uniq.pluck(:subject).sample(2) }

      context "(one subject)" do
        let(:search) { GalleryImage.where("subject @> ?", "{#{subject_one_value.join(',')}}") }

        it "assigns first page of matching gallery_images as @gallery_images " do
          get :index, { subject: subject_one_value }, valid_session
          expect(result).to eq page
        end
      end

      context "(more than one subject)" do
        let(:search) { GalleryImage.where("subject @> ?", "{#{subject_two_values.join(',')}}") }

        it "assigns first page of matching gallery_images as @gallery_images " do
          get :index, { subject: subject_two_values }, valid_session
          expect(result).to eq page
        end
      end
    end

    context "with page set" do
      let(:search) { GalleryImage.offset(limit) }

      it "assigns correct page of matching admission as @admissions" do
        get :index, { page: 2 }, valid_session
        expect(result).to eq page
      end
    end
  end

  describe "#per_page_default" do
    it "should equal 12" do
      expect(subject.per_page_default).to eq(12)
    end
  end
end
