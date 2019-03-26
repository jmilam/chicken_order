FactoryBot.define do
  factory :farm do
    name { 'Boomslang' }
    address { '111 sunset dr' }
    city { 'farm' }
    state { 'FL' }
    zipcode { '12345' }
    phone_number { '4445556666' }
    unique_key { '19873' }
    egg_cost { 3.0 }
    chicken_count { 1 }
  end
end
