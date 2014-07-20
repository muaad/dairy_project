json.array!(@commodities) do |commodity|
  json.extract! commodity, :id, :name, :commodity_type, :units
  json.url commodity_url(commodity, format: :json)
end
