FactoryGirl.define do
  factory :referral do
    orig_practice_id 1
    dest_practice_id 2
    patient_id 3
    memo 'This is a memo about the referral'
  end
end