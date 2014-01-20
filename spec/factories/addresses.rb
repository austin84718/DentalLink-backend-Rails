FactoryGirl.define do
  factory :address do
    street_line_1 'Street line 1'
    street_line_2   'Street line 2'
    city 'City'
    state 'State'
    zip '123456789'
  end
end