class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show]

  # GET /admissions
  # GET /admissions.json
  def index
    @fields = ["by_whom_committed", "name", "alias", "for_what_committed", "disposal", "whereborn_city", "whereborn_state", "whereborn_country", "parentage", "religion", "history_number"]
    @facets = [:gender, :no_of_reader, :no_of_times_in_refuge, :complaint_of_mother, :complaint_of_father, :complaint_of_police, :appearance_bad, :appearance_good, :can_read, :can_write, :father_drinks, :father_living, :had_regular_work, :has_step_father, :has_step_mother, :mother_drinks, :mother_living, :played_truant, :swears, :uses_liquour, :uses_tobacco]
    parse_search_request
    search(@facets)

    respond_to do |format|
      format.html
      format.json { render json: non_paginated_search }
      format.xml { render xml: non_paginated_search }
    end
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  private

  def search(facets, per_page = 20)
    @search = Admission.search do
      params[:search].each do |search|
        fulltext search[:value], fields: search[:field]
      end


      facets.each do |f| 
        with f, params[f] unless params[f].nil?
        facet f
      end

      paginate(per_page: per_page, page: params[:page])
    end

    @admissions = @search.results
  end

  def non_paginated_search
    ## Sunspot imposes per_page limits by default
    ## we're working around this by limiting our results to the total number of records
    params.delete(:page)
    search(Admission.all.count)
  end

  def parse_search_request
    fields = select_all_search_fields
    values = select_all_search_values
    validate_search_fields(fields, values)
    set_search_fields_and_values(fields, values)
    handle_blank_search
  end

  def set_search_fields_and_values(fields, values)
    params[:search] = Array.new
    counter = set_counter(fields, values)
    counter.times do |i|
      params[:search][i] = { field: fields["field#{i}"], value: values["value#{i}"] }
    end
  end

  def validate_search_fields(fields, values)
    raise "Search Field Error" unless get_indices(fields) == get_indices(values)
  end

  def get_indices(search_hash)
    (search_hash.keys.collect { |key| key[/\d+$/] }).sort
  end

  def set_counter(fields, values)
    return fields.count
  end

  def select_all_search_fields
    params.select { |key, value| key.to_s.match(/^field/)}
  end

  def select_all_search_values
    params.select { |key, value| key.to_s.match(/^value/)}
  end

  def handle_blank_search
    params[:search] = [{ value: nil, field: nil }] if params[:search].empty?
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
