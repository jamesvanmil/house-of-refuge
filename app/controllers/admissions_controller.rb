class AdmissionsController < ApplicationController
  def index
    @search_params = Hash.new
    prepare_facet_fields
    prepare_gender_field
    prepare_date_fields

    @admissions = search_results.paginate(:page => params[:page], per_page: per_page_default)
    @facet_hash = build_facets(search_results)
  end

  def show
    @admission = Admission.find(params[:id])
  end

  def per_page_default
    @per_page ||= 10
  end
  helper_method :per_page_default

  private

  def prepare_facet_fields
    facet_fields.each do |field|
      set_facet_search_values(field)
    end
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

  def set_facet_search_values(field)
    @search_params[field.to_sym] = params[field.to_sym] unless params[field.to_sym].blank?
  end

  def prepare_gender_field
    gender_search_array = Array.new
    gender_search_array << "female" if params[:female] == "1"
    gender_search_array << "male" if params[:male] == "1"
    gender_search_array << "unknown" if params[:unknown] == "1"
    @search_params[:gender] = gender_search_array unless gender_search_array.blank?
  end

  def prepare_date_fields
    if params[:begin_date].blank? && params[:end_date].blank?
      # Do nothing
    elsif params[:begin_date].present? && params[:end_date].blank?
      @search_params[:admission_date] = (parse_date(params[:begin_date]) - 1)..(99999999)
    elsif params[:begin_date].blank? && params[:end_date].present?
      @search_params[:admission_date] = (0)..(parse_date(params[:end_date]))
    else
      @search_params[:admission_date] = (parse_date(params[:begin_date]) - 1)..(parse_date(params[:end_date]))
    end
  end

  def search_results
    Admission.where("full_name ILIKE ?", "%#{params[:name]}%").where(@search_params)
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

  def parse_date(date)
    month, day, year = date.match(/(\d+)\/(\d+)\/(\d+)/).captures
    ("#{ year }#{ month.rjust(2, "0") }#{ day.rjust(2, "0") }").to_i
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admission_params
    params[:admission]
  end
end
