json.array!(@rents) do |rent|
  json.extract! rent, :id
  json.url rent_url(rent, format: :json)
end
