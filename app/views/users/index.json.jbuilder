json.array!(@users) do |user|
  json.extract! user, :type, :title, :first_name, :middle_initial, :last_name, :username, :password, :practice_id
  json.url user_url(user, format: :json)
end
