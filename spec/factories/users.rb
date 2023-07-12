FactoryBot.define do
  factory :user do
    name { "user-#{Time.now.to_i}" }
    email { "user-#{Time.now.to_i}@example.com" }
    password { "#{Time.now.to_i}" }
    is_admin { false }
  end
end
