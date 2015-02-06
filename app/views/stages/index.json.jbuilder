json.array!(@stages) do |stage|
  json.extract! stage, :id
  json.url stage_url(stage, format: :json)
end
