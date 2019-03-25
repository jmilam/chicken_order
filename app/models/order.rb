class Order < ApplicationRecord
  belongs_to :user
  belongs_to :farm
  validates :qty, numericality: true
  validates :qty, presence: true

  enum payment: { '0': 'Cash', '1': 'Check' }

  def status
    if filled && delivered
      'Filled & Delivered'
    elsif filled && !delivered
      'Filled, not Delivered'
    else
      'Not Processed Yet'
    end
  end

  def pickup_location
    PickupLocation.find(pickup_location_id).name unless pickup_location_id.nil?
  end

  def cost
    total = qty * 3
    total += 2 if Order.payments[payment_type.to_s] == 'Delivered'
    total
  end

  def estimate_delivery_date
    pending_qty = farm.orders.where(filled: false).where.not(id: id).sum(&:qty)
    calculated_egg_count = farm.total_eggs - pending_qty - qty
    if calculated_egg_count.positive? || calculated_egg_count.zero?
      # mark estimated due date as today
      Date.today
    else
      # take calcaulted egg count
      Date.today + calculated_egg_count.abs.days
    end
  end
end
