module AdmissionsHelper
  def related_admissions
    @admissions = Admission.where(history_number: @admission.history_number)
  end
end
