class Admin::Ajax::OrdersReportsController < ApplicationController
  def index
    time = params[:time]
    if time != ""
      @order_of_day = Order.includes(:product_orders, :products).where("created_at between :begin_day and :end_day", begin_day: time.to_datetime.beginning_of_day, end_day: time.to_datetime.end_of_day).where(order_status: 0)
    else
      @order_of_day = Order.includes(:product_orders, :products)
        .where("created_at between :begin_day and :end_day", begin_day: Time.current.beginning_of_day, end_day: Time.current.end_of_day)
        .where(order_status: 0)
    end

    # tổng giá tiền
    @total_price = 0
    
    # tổng số sản phảm
    @total_products = 0

    @order_of_day.each do |order_of_day|
      total_price = order_of_day.product_orders.sum { |q| q.quantity  * q.product.price}
      @total_price += total_price

      total_products = order_of_day.product_orders.sum(:quantity)
      @total_products += total_products
    end

    # số order của ngày
    @total_order = @order_of_day.size
  end
end
