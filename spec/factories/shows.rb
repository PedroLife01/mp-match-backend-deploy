FactoryBot.define do
  factory :show do
    name { "show-#{Time.now.to_i}" }
    director { "director-#{Time.now.to_i}" }
    year { 2000 }
  end
end
