class AdmissionsController < ApplicationController
  def index
    search_params = initialize_search_params

    @admissions = AdmissionSearcher.new(
      page: page,
      search_params: search_params
    ).results

    @facet_hash = AdmissionFacetHashBuilder.new(
      relation: @admissions,
      facet_array: facet_fields
    ).facet_hash
  end

  def show
    @admission = Admission.find(params[:id])
  end

  private
  
  def initialize_search_params
    search_params = Hash.new

    facet_fields.each do |field|
      unless params[field].blank?
        search_params[field] = prepare_field(field)
      end
    end

    unless params[:female].blank? and params[:male].blank? and params[:unknown].blank?
      search_params[:gender] = prepare_gender_field
    end

    unless params[:begin_date].blank? and params[:end_date].blank?
      search_params[:admission_date] = prepare_date_range
    end

    unless params[:name].blank?
      search_params[:name] = prepare_field(:name)
    end

    search_params
  end

  def page
    params[:page]
  end

  def prepare_field(field)
    params[field] 
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

  def prepare_gender_field
    gender_search_array = Array.new
    gender_search_array << "female" if params[:female] == "1"
    gender_search_array << "male" if params[:male] == "1"
    gender_search_array << "unknown" if params[:unknown] == "1"
    gender_search_array unless gender_search_array.blank?
  end

  def prepare_date_range
    if params[:begin_date].blank? && params[:end_date].blank?
      nil
    elsif params[:begin_date].present? && params[:end_date].blank?
      (parse_date(params[:begin_date]) - 1)..(99999999)
    elsif params[:begin_date].blank? && params[:end_date].present?
      (0)..(parse_date(params[:end_date]))
    else
      (parse_date(params[:begin_date]) - 1)..(parse_date(params[:end_date]))
    end
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
