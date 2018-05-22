FactoryGirl.define do
  factory :user, class: User do
    first_name  "Eugene"
    last_name "Kolomiets"
    email "koloma@mail.com"
    password "koloma"
    password_confirmation "koloma"
  end
end