class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show]

  # GET /admissions
  # GET /admissions.json
  def index

    search_params = Hash.new

    facet_fields.each do |field|
      search_params[field.to_sym] = params[field.to_sym] unless params[field.to_sym].blank?
    end

    gender_search_array = Array.new
    gender_search_array << "female" if params[:female] == "1"
    gender_search_array << "male" if params[:male] == "1"
    gender_search_array << "unknown" if params[:unknown] == "1"
    search_params[:gender] = gender_search_array unless gender_search_array.blank?

    if params[:begin_date].blank? && params[:end_date].blank?
      # Do nothing
    elsif params[:begin_date].present? && params[:end_date].blank?
      search_params[:admission_date] = (parse_begin_date(params[:begin_date]) - 1)..(99999999)
    elsif params[:begin_date].blank? && params[:end_date].present?
      search_params[:admission_date] = (0)..(parse_end_date(params[:end_date]))
    else
      search_params[:admission_date] = (parse_begin_date(params[:begin_date]) - 1)..(parse_end_date(params[:end_date]))
    end

    @admissions = search_results(search_params).paginate(:page => params[:page], per_page: per_page_default)
    session[:search_results] = request.url
    @facet_hash = build_facets(search_results(search_params))
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  def per_page_default
    @per_page ||= 10
  end
  helper_method :per_page_default

  private

  def search_results(search_params)
    Admission.where("full_name ILIKE ?", "%#{params[:name]}%").where(search_params)
  end

  def build_facets(search_results)
    facets = Hash.new
    facet_fields.each do |field|
      facets[field] = Hash[ search_results.uniq.pluck(field).zip([nil]) ]
      facets[field].keys.each do |value|
        facets[field][value] = search_results.where("#{field.to_s} = ? ", value).count
      end
    end
    facets
  end

  def facet_fields
    @facets ||= [:age,
     :for_what_committed_index,
     :religion_index,
     :parentage_index,
     :whereborn_country,
     :whereborn_state,
     :whereborn_city
    ]
  end

  def parse_begin_date(date)
    parse_date(date, :begin)
  end

  def parse_end_date(date)
    parse_date(date, :end)
  end

  def parse_date(date, type)
    if date =~ /^ \d+ \/ \d+ \/ \d+ $/x
      month, day, year = date.match(/ (\d+) \/ (\d+) \/ (\d+)/x).captures
    else date =~ /^ \d{4} $/
      month, day = ["01", "01"] if type == :begin
      month, day = ["12", "31"] if type == :end
      year = date
    end

    ("#{ year }#{ month.rjust(2, "0") }#{ day.rjust(2, "0") }").to_i
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admission
    @admission = Admission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admission_params
    params[:admission]
  end
end
