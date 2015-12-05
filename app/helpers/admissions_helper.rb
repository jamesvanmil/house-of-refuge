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
    values = Array.new
    Hash[
      @admissions.uniq.pluck(field).zip([nil])
    ].keys.each do |value|
      values << ["#{value} (#{@admissions.where("#{field.to_s} = ? ", value).count})", value]
    end
    values
  end

  def facet_count_for_gender(value)
    "(#{@admissions.where(gender: value.to_s).count})"
  end

  def default_value(value)
    params[value]
  end
end
