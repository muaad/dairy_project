json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :farmer_id, :delivery_id, :user_id, :transaction_number
  json.url payment_url(payment, format: :json)
end
