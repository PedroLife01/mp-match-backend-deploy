FactoryBot.define do
  factory :movie do
    name { "movie-#{Time.now.to_i}" }
    director { "director-#{Time.now.to_i}" }
    year { 2000 }
  end
end
