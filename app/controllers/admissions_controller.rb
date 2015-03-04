class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show, :edit, :update, :destroy]

  # GET /admissions
  # GET /admissions.json
  def index
    @admissions = Admission.all
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  # GET /admissions/new
  def new
    @admission = Admission.new
  end

  # GET /admissions/1/edit
  def edit
  end

  # POST /admissions
  # POST /admissions.json
  def create
    @admission = Admission.new(admission_params)

    respond_to do |format|
      if @admission.save
        format.html { redirect_to @admission, notice: 'Admission was successfully created.' }
        format.json { render :show, status: :created, location: @admission }
      else
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admissions/1
  # PATCH/PUT /admissions/1.json
  def update
    respond_to do |format|
      if @admission.update(admission_params)
        format.html { redirect_to @admission, notice: 'Admission was successfully updated.' }
        format.json { render :show, status: :ok, location: @admission }
      else
        format.html { render :edit }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admissions/1
  # DELETE /admissions/1.json
  def destroy
    @admission.destroy
    respond_to do |format|
      format.html { redirect_to admissions_url, notice: 'Admission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission
      @admission = Admission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_params
      params[:admission]
    end
end
