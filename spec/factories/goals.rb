FactoryGirl.define do
  factory :goal do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }    
  end

end
