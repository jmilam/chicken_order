class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]
    @user = params[:user]
    @payment_type = Order.payments[@order.payment_type.to_s]
    mail(to: 'jasonlmilam@gmail.com', subject: 'New Order Placed')
  end

  def order_filled
    @order = params[:order]
    @pickup_location = PickupLocation.find(@order.pickup_location_id)
    @user = params[:user]
    mail(to: "#{@user.email}", subject: 'Fresh Eggs are on their way')
  end
end
