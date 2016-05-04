class Admission < ActiveRecord::Base
  self.per_page = 10

  def shared_history_number?
    Admission.where(history_number: self.history_number).count > 1
  end
end
