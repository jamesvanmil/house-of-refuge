class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show]

  # GET /admissions
  # GET /admissions.json
  def index
    @fields = ["by_whom_committed", "name", "alias", "for_what_committed", "disposal", "whereborn_city", "whereborn_state", "whereborn_country", "parentage", "religion", "history_number"]
    @facets = [:gender, :no_of_reader, :no_of_times_in_refuge, :complaint_of_mother, :complaint_of_father, :complaint_of_police, :appearance_bad, :appearance_good, :can_read, :can_write, :father_drinks, :father_living, :had_regular_work, :has_step_father, :has_step_mother, :mother_drinks, :mother_living, :played_truant, :swears, :uses_liquour, :uses_tobacco]
    parse_search_request
    search(@search_array, @facets)

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

  def search(search_array, facets, per_page = 20)
    @search = Admission.search do
      search_array.each do |search|
        fulltext search[:value], fields: search[:field]
      end


      facets.each do |f| 
        with f, params[f] unless params[f].nil?
        facet f
      end

      paginate(per_page: per_page, page: params[:page])
    end

    #params = @saved_params
    @admissions = @search.results
  end

  def non_paginated_search
    ## Sunspot imposes per_page limits by default
    ## we're working around this by limiting our results to the total number of records
    params.delete(:page)
    search(@search_array, @facets, Admission.all.count)
  end

  def parse_search_request
    fields = select_all_search_fields
    values = select_all_search_values
    remove_blank_valued_fields(fields, values)
    validate_search_fields(fields, values)
    set_search_fields_and_values(fields, values)
    handle_blank_search
  end

  def select_all_search_fields
    params.select { |key, value| key.to_s.match(/^field/)}.values
  end

  def select_all_search_values
    params.select { |key, value| key.to_s.match(/^value/)}.values
  end

  def remove_blank_valued_fields(fields, values)
    while values.rindex("") != nil
      blank_index = values.rindex("")
      [fields, values].each { |array| array.slice!(blank_index) }
    end
  end

  def validate_search_fields(fields, values)
    raise "Search Field Error" unless fields.length == values.length
  end

  def set_search_fields_and_values(fields, values)
    @search_array = Array.new
    counter = set_counter(fields)
    counter.times do |i|
      @search_array[i] = { field: fields[i], value: values[i] }
    end
  end

  def set_counter(fields)
    return fields.count
  end

  def handle_blank_search
    @search_array = [{ value: nil, field: nil }] if @search_array.empty?
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
