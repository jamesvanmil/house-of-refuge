namespace :hor do

  require 'csv'

  desc "Destroy all admission records"
  task:delete => :environment do
    puts "Destroying all records"
    Admission.destroy_all
  end

  desc "Import all admission records"
  task:import => :environment do
    puts "Importing records from #{data_path}"
    data.each { |row| create_admission(row) }
    puts "Done!"
  end

  desc "Destroy and import all admission records"
  task:reset => [:delete_all, :import_from_csv] do
  end

  def create_admission(row)
    Admission.create(
      date: row["date"],
      history_number: row["history_number"],
      full_name: row["full_name"],
      alias: row["alias"],
      gender: row["gender"],
      for_what_committed: row["for_what_committed"],
      by_whom_committed: row["by_whom_committed"],
      age: row["age"],
      whereborn_city: row["whereborn_city"],
      whereborn_state: row["whereborn_state"],
      whereborn_country: row["whereborn_country"],
      parentage: row["parentage"],
      religion: row["religion"],
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
      image_no: row["image_no"]
    )
    print "."
  end

  def data
    CSV.read(data_path, headers: :first_row)
  end

  FILENAME = "/vendor/data.csv"
  def data_path
    "#{Rails.root}#{FILENAME}"
  end

end
