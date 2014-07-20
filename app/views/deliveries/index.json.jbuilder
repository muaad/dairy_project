json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :commodity_id, :farmer_id, :quantity, :price, :total, :paid_for
  json.url delivery_url(delivery, format: :json)
end
