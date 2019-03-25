class Farm < ApplicationRecord
  has_many :orders

  def available_eggs_count
    pending_orders = orders.where(filled: false)
    available_eggs = total_eggs - pending_orders.sum(&:qty)
    available_eggs > 0 ? total_eggs : 0
  end
end
