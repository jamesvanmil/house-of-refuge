class AdmissionSearcher
  attr_reader :results

  def initialize(page: nil, paginate: true, search_params:)
    per_page = set_per_page(paginate)
    @results = admission_search(page, search_params, per_page)
  end

  private

  def admission_search(page, search_params, per_page)
    name = search_params.delete(:name) || ""
    Admission.where("full_name ILIKE ?", "%#{name}%").where(search_params).paginate(page: page, per_page: per_page)
  end

  def set_per_page(paginate)
    # instead of not paginating searches, set per_page to Admission.count
    if paginate
      Admission.per_page
    else
      Admission.count
    end
  end
end
