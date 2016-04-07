class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: [:show, :edit, :update, :destroy]

  # GET /gallery_images
  # GET /gallery_images.json
  def index
    subject_search = Array.new

    subject_search << params[:subject] unless params[:subject].blank?

    @gallery_images = GalleryImage
      .where("subject @> ?", "{#{subject_search.join(',')}}")
      .paginate(:page => params[:page])
  end

  # GET /gallery_images/1
  # GET /gallery_images/1.json
  def show
  end

  # GET /gallery_images/new
  def new
    @gallery_image = GalleryImage.new
  end

  # GET /gallery_images/1/edit
  def edit
  end

  # POST /gallery_images
  # POST /gallery_images.json
  def create
    @gallery_image = GalleryImage.new(gallery_image_params)

    respond_to do |format|
      if @gallery_image.save
        format.html { redirect_to @gallery_image, notice: 'Gallery image was successfully created.' }
        format.json { render :show, status: :created, location: @gallery_image }
      else
        format.html { render :new }
        format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gallery_images/1
  # PATCH/PUT /gallery_images/1.json
  def update
    respond_to do |format|
      if @gallery_image.update(gallery_image_params)
        format.html { redirect_to @gallery_image, notice: 'Gallery image was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery_image }
      else
        format.html { render :edit }
        format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_images/1
  # DELETE /gallery_images/1.json
  def destroy
    @gallery_image.destroy
    respond_to do |format|
      format.html { redirect_to gallery_images_url, notice: 'Gallery image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery_image
    @gallery_image = GalleryImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_image_params
    params.require(:gallery_image).permit(:title, :creator, :date, :description, :source_text, :source_link, :format, :subject, :image)
  end
end
