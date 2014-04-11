FactoryGirl.define do
  factory :practice do
    name 'My Practice'
    description  'My practice description'
    address_id 1
    address {FactoryGirl.build(:address)}
  end
end