class Admin::ReportsController < ApplicationController
  def index
    @order_of_day = Order
      .where("created_at between :begin_day and :end_day", begin_day: Time.current.beginning_of_day, end_day: Time.current.end_of_day)
      .where(order_status: 0)

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


    @order_of_day.each do |order_of_day|


    end

    # số order của ngày
    @total_order = @order_of_day.size
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
    @order_product_show = ProductOrder.includes(:product).where(order_id: params[:id])

    @order_show = Order.includes(:table).find_by_id params[:id]

    @show_total_price = @order_product_show.sum { |q| q.quantity  * q.product.price}

    @show_total_products = @order_product_show.sum(:quantity)
  end
end
