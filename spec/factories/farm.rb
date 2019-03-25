FactoryBot.define do
  factory :farm do
    name { 'Boomslang' }
    address { '111 sunset dr' }
    city { 'farm' }
    state { 'FL' }
    zipcode { '12345' }
    phone_number { '4445556666' }
    egg_cost { 3.0 }
    chicken_count { 1 }
  end
end
