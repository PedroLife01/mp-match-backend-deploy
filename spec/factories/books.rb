FactoryBot.define do
  factory :book do
    name { "book-#{Time.now.to_i}" }
    author { "author-#{Time.now.to_i}" }
    year { 2000 }
  end
end
