class Admin::WeekReportsController < ApplicationController
  def index

    # Sản phẩm tiêu biểu trong tuần
    @order_of_week = Order
      .where("created_at between :begin_week and :end_week", begin_week: Time.current.beginning_of_week, end_week: Time.current.end_of_week)
      .where(order_status: 0)

    @price_of_week = []

    (0..6).each do |day|
      time = Time.current.beginning_of_week + day.days
      @order_of_day = Order
        .where("created_at between :begin_day and :end_day", begin_day: time.beginning_of_day, end_day: time.end_of_day)
        .where(order_status: 0)

      # tổng giá tiền
      @total_price = 0
      @order_of_day.each do |order_of_day|
        total_price = order_of_day.product_orders.sum { |q| q.quantity  * q.product.price}
        @total_price += total_price
      end
      @price_of_week << @total_price
    end


    @report_selling_product_week = []
    order_id_of_week = @order_of_week.pluck(:id)
    @report_selling_product_week = ProductOrder.joins(:product)
      .where(order_id: order_id_of_week)
      .select("sum(quantity) as total_quantity, product_id")
      .group(:product_id).order("total_quantity desc").first(15)
      .map{|po| [po.product.name, po.total_quantity]}
  end
end
