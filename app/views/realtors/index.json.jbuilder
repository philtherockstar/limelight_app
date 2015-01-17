json.array!(@realtors) do |realtor|
  json.extract! realtor, :id, :first_name, :last_name, :company, :phone, :email, :created_at, :updated_at
  json.url realtor_url(realtor, format: :json)
end
