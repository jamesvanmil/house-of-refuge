class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show]

  # GET /admissions
  # GET /admissions.json
  def index
    @admissions = Admission.paginate(page: params[:page], per_page: 20)
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
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
