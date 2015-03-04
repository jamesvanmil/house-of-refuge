json.array!(@admissions) do |admission|
  json.extract! admission, :id
  json.url admission_url(admission, format: :json)
end
