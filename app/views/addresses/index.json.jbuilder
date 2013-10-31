json.array!(@addresses) do |address|
  json.extract! address, :street_line_1, :street_line_2, :city, :state, :zip
  json.url address_url(address, format: :json)
end
