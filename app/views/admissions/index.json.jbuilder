json.array!(@admissions) do |admission|
  json.extract! admission, :id, :startdate, :enddate, :user_id, :sclass_id, :subject_id
  json.url admission_url(admission, format: :json)
end
