FactoryBot.define do
  factory :order do
    farm
    user
    qty { 1 }
    payment_type { 0 }
  end
end
