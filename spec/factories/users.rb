FactoryGirl.define do
  factory :user do
    group 'My Group'
    title 'My Title'
    first_name 'My First Name'
    middle_initial 'M'
    last_name "My Last Name"
    username 'user'
    password 'my password'
    email 'email@domain.eml'
    practice_id 1
  end

  factory :doctor, class: User do
    group 'My Group'
    title 'My Title'
    first_name 'My First Name'
    middle_initial 'M'
    last_name "My Last Name"
    username 'user'
    password 'my password'
    email 'email@domain.eml'
    practice_id 1
    roles [:doctor]
  end

  factory :admin, class: User do
    group 'My Group'
    title 'My Title'
    first_name 'My First Name'
    middle_initial 'M'
    last_name "My Last Name"
    username 'user'
    password 'my password'
    email 'email@domain.eml'
    practice_id 1
    roles [:admin]
  end

  factory :aux, class: User do
    group 'My Group'
    title 'My Title'
    first_name 'My First Name'
    middle_initial 'M'
    last_name "My Last Name"
    username 'user'
    password 'my password'
    email 'email@domain.eml'
    practice_id 1
    roles [:aux]
  end
end