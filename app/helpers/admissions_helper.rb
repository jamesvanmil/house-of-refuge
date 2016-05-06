module AdmissionsHelper
  def index_page
   return 1 if params[:page].nil?
   params[:page].to_i
  end

  def page_start
    (index_page - 1) * per_page_default + 1
  end

  def page_end
    page_start + per_page_default - 1
  end

  def result_number(index)
    page_start + index
  end

  def related_admissions
    @admissions = Admission.where(history_number: @admission.history_number)
  end

  def facets_for_select(field)
    array = Array.new
    (@facet_hash[field].sort_by {|k,v| v}.reverse).each do |value|
      array << ["#{value[0]} (#{value[1]})", value[0]]
    end
    array
  end

  def facet_count_for_gender(value)
    "(#{@admissions.where(gender: value.to_s).count})"
  end

  def default_value(value)
    params[value]
  end

  def friendly_date(value)
    date_string = value.to_s
    year = date_string[0..3]
    month = date_string[4..5]
    day = date_string[6..7]
    "#{month}/#{day}/#{year}"
  end
end
