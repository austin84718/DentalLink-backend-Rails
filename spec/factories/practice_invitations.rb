# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :practice_invitation do
    practice_name ""
    contact_first_name ""
    contact_last_name ""
    contact_email ""
    contact_phone "MyString"
  end
end
