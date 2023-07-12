FactoryBot.define do
  factory :tag do
    name { "tag-#{Time.now.to_i}" }
  end
end
