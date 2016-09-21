namespace :hor do

  require 'csv'

  desc "Destroy all admission records"
  task:delete => :environment do
    puts "Destroying all records"
    Admission.destroy_all
  end

  desc "Import all admission records"
  task:import => :environment do
    data.each { |row| create_admission(row) }
  end

  desc "Destroy and import all admission records"
  task:reset => [:delete, :import] do
  end

  def create_admission(row)
    puts row["full_name_not_standardized"]
    Admission.create(
      admission_date: convert_date(row["date"]),
      history_number: row["number"],
      full_name: row["full_name_not_standardized"],
      given_name: row["given_name_standardized"],
      surname: row["surname_standardized"],
      alias: row["alias_or_other_name"],
      gender: gender_filter(row["gender"]),
      for_what_committed: row["for_what_committed"],
      for_what_committed_index: row["for_what_committed_index_fields"],
      by_whom_committed: row["by_whom_committed"],
      age: row["age"],
      whereborn_city: row["whereborn_city"],
      whereborn_state: row["whereborn_state"],
      whereborn_county: row["whereborn_county"],
      whereborn_country: row["whereborn_country"],
      parentage: row["parentage"],
      parentage_index: row["parentage_index_fields"],
      religion: row["religion"],
      religion_index: row["religion_index_fields"],
      father_living: row["father_living"],
      mother_living: row["mother_living"],
      has_step_father: row["has_step_father"],
      has_step_mother: row["has_step_mother"],
      father_drinks: row["father_drinks"],
      mother_drinks: row["mother_drinks"],
      appearance_good: row["appearance_good"],
      appearance_bad: row["appearance_bad"],
      uses_tobacco: row["uses_tobacco"],
      uses_liquour: row["uses_liquour"],
      swears: row["swears"],
      had_regular_work: row["had_regular_work"],
      can_read: row["can_read"],
      no_of_reader: row["no_of_reader"],
      can_write: row["can_write"],
      played_truant: row["played_truant"],
      no_of_times_in_refuge: row["no_of_times_in_refuge"],
      complaint_of_father: row["complaint_of_father"],
      complaint_of_mother: row["complaint_of_mother"],
      complaint_of_police: row["complaint_of_police"],
      disposal: row["disposal"],
      trial_date: row["trial_date"],
      image_no: row["image_no"],
      handle: row["handle"]
    )
  end

  def data
    CSV.read(data_path, headers: :first_row)
  end

  FILENAME = "/vendor/data.csv"
  def data_path
    "#{Rails.root}#{FILENAME}"
  end

  def gender_filter(value)
    case value
    when "female"
      value
    when "male"
      value
    else
      "unknown"
    end
  end

  def convert_date(date)
    return date.tr("-", "").to_i unless date.nil?
    nil
  end
end
