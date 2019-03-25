class OrderController < ApplicationController
  protect_from_forgery except: %i[filled delivered]

  def index
    @farms = Farm.all
    @pickup_locations = PickupLocation.all
    @farm = Farm.first
  end

  def create
    user = User.find_by(phone_number: params[:order][:phone_number])

    @user = user.nil? ? User.new(user_params) : user
    @order = @user.orders.build(order_params)

    ActiveRecord::Base.transaction do
      begin
        @user.save!
        @order.save!
        flash[:notice] = 'Your order has been placed. You will hear from us soon.'
        redirect_to order_details_path(@order.id)
      rescue ActiveRecord::RecordInvalid => invalid
        return_message = ''
        invalid.record.errors.messages.each do |message|
          return_message << message[0].to_s + ' ' + message[1].join(',') + '\n'
        end
        flash[:alert] = return_message
        redirect_to order_index_path
      end
    end
  end

  def show
    @orders = Order.all.sort
  end

  def filled
    order = Order.find(params[:id])
    ActiveRecord::Base.transaction do
      order.update(filled: params[:checked])
      order.farm.update(total_eggs: order.farm.total_eggs - order.qty)
    end
  end

  def delivered
    order = Order.find(params[:id])
    order.update(delivered: params[:checked])
  end

  def list
    user = User.find_by(phone_number: params[:past_orders][:phone_number])
    @orders = user.nil? ? [] : user.orders
  end

  def details
    @order = Order.find(params[:id])
    @payment_type = Order.payments[@order.payment_type.to_s]
  end

  def farm_order_availability
    @farm = Farm.find(params[:id])

    render json: { farm: @farm, available_eggs: @farm.available_eggs_count, egg_cost: @farm.egg_cost }
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.update!(cancelled: true)
    flash[:notice] = 'Your order has been cancelled.'
  rescue ActiveRecord::RecordInvalid => invalid
    flash[:alert] = invalid.record.errors.messages
  ensure
    redirect_to order_list_path(past_orders: { phone_number: @order.user.phone_number })
  end

  private

  def user_params
    params.require(:order).permit(:first_name, :last_name, :phone_number)
  end

  def order_params
    params.require(:order).permit(:qty, :pickup_location_id, :farm_id, :payment_type)
  end
end
