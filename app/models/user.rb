class User < ApplicationRecord
	has_many :orders
	validates :phone_number, presence: true
	validates :phone_number, uniqueness: true
end
