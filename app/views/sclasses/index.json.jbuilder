json.array!(@sclasses) do |sclass|
  json.extract! sclass, :id, :sclassname
  json.url sclass_url(sclass, format: :json)
end
