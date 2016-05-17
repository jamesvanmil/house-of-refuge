class GalleryImagesController < ApplicationController
  def index
    @subject_search = Array.new
    @subject_search << params[:subject] unless params[:subject].blank?

    @gallery_images = image_search
  end

  def show
    @gallery_image = GalleryImage.find(params[:id])
  end

  def per_page_default
    @per_page ||= 12
  end

  private

  def image_search
    GalleryImage.where("subject @> ?", "{#{@subject_search.join(',')}}")
      .paginate(:page => params[:page], per_page: per_page_default)
  end

  def gallery_image_params
    params.require(:gallery_image)
      .permit(:title, :creator, :date,
              :description, :source_text,
              :source_link, :format,
              :subject, :image)
  end
end
