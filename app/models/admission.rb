class Admission < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, against: :name
  pg_search_scope :search_by_religion, against: :religion
  pg_search_scope :search_by_parentage, against: :parentage

  def shared_history_number?
    Admission.where(history_number: self.history_number).count > 1
  end
end
