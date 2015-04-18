class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show]

  # GET /admissions
  # GET /admissions.json
  def index
    parse_search_request
    search 

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

  def search(per_page = 20)
    @search = Admission.search do
      params[:search].each do |search|
        fulltext search[:value], fields: search[:field]
      end
      paginate(per_page: per_page, page: params[:page])
    end

    @admissions = @search.results
  end

  def non_paginated_search
    ## Sunspot imposes per_page limits by default
    ## we're working around this by limiting our results to the total number of records
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
