json.array!(@practices) do |practice|
  json.extract! practice, :name, :description, :address_id
  json.url practice_url(practice, format: :json)
end
