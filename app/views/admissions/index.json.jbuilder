json.array!(@admissions) do |admission|
  json.extract! admission,
    :id,
    :full_name,
    :history_number,
    :admission_date,
    :no_of_times_in_refuge,
    :for_what_committed,
    :by_whom_committed,
    :disposal,
    :age,
    :gender,
    :whereborn_city,
    :whereborn_state,
    :religion,
    :parentage,
    :handle

  json.url admission_url(admission, format: :json)
end
