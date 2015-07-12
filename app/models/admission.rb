class Admission < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_alias, against: :alias
  pg_search_scope :search_by_name, against: :name
  pg_search_scope :search_by_religion, against: :religion
  pg_search_scope :search_by_parentage, against: :parentage
  pg_search_scope :search_by_whereborn_city, against: :whereborn_city
  pg_search_scope :search_by_whereborn_state, against: :whereborn_state
  pg_search_scope :search_by_whereborn_country, against: :whereborn_country
  pg_search_scope :search_by_disposal, against: :disposal
  pg_search_scope :search_by_what_committed, against: :for_what_committed
  pg_search_scope :search_by_by_whom_committed, against: :by_whom_committed
  pg_search_scope :search_by_history_number, against: :history_number

  def shared_history_number?
    Admission.where(history_number: self.history_number).count > 1
  end
end
