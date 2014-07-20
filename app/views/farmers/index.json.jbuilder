json.array!(@farmers) do |farmer|
  json.extract! farmer, :id, :name, :phone_number, :location, :registration_number
  json.url farmer_url(farmer, format: :json)
end
