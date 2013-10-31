json.array!(@referrals) do |referral|
  json.extract! referral, :orig_practice_id, :dest_practice_id, :patient_id, :memo
  json.url referral_url(referral, format: :json)
end
