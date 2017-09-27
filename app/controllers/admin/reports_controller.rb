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

    # số order của ngày
    @total_order = @order_of_day.size

    # Thống kê 15 sản phẩm bán chạy
    @report_selling_product = []
    order_id_of_day = @order_of_day.pluck(:id)

    # Hiển thị tất cả các sản phẩm trong ngày

    # product_id_of_day = ProductOrder.where(order_id: order_id_of_day).pluck(:product_id).uniq
    # product_id_of_day.each do |product|
    #   name_product = Product.find_by_id(product).name
    #   quantity_product = ProductOrder.where(product_id: product, order_id: order_id_of_day).sum(:quantity)
    #   array_product = []
    #   array_product << name_product
    #   array_product << quantity_product
    #   @report_selling_product << array_product
    # end

    @report_selling_product = ProductOrder.joins(:product)
      .where(order_id: order_id_of_day)
      .select("sum(quantity) as total_quantity, product_id")
      .group(:product_id).order("total_quantity desc").first(15)
      .map{|po| [po.product.name, po.total_quantity]}

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
