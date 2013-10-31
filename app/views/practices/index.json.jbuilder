json.array!(@practices) do |practice|
  json.extract! practice, :type, :name, :description, :address_id
  json.url practice_url(practice, format: :json)
end
