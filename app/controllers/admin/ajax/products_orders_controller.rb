class Admin::Ajax::ProductsOrdersController < ApplicationController
  before_action :load_table, only: %i(create update)

  def index
    id_table = params[:id_table]
    @current_table = Table.where(id: id_table.to_i)
    @products = Product.all

    # show product of table when order
    order_of_table = Order.where(table_id: id_table, order_status: 1)
    if order_of_table.present?
      @product_order_of_table = ProductOrder.includes(:product).where(order_id: order_of_table.first.id)
      # @products_of_table = Product.where(id: product_order_of_table)
    end
  end

  def create

    item_order = params["order"]
    id_table = params["id_table"]

    if get_order(id_table).present?
      order = @order
    else
      order = Order.create(table_id: params["id_table"], order_status: 1)
    end

    arr_params_order = []
    arr_order = []
    item_order.map do |id_product, number_product|
      if get_items_order(order, id_product, number_product).present?
        @item_order.update(quantity: number_product)
      else
        ProductOrder.create(product_id: id_product, order_id: order.id, quantity: number_product)
      end
      arr_params_order.push(id_product)
      arr_params_order.map! { |i| i.to_i }
    end
    arr_order = get_product_with_order order
    list_id_product = arr_order - arr_params_order

    unless list_id_product.blank?
      destroy_product_with_order list_id_product, order
      if @list_product.present?
        @list_product.destroy_all
      end
    end
  end

  def update
    table_id =  params[:id]
    order = Order.where(table_id: table_id, order_status: 1)
    order.update(order_status: 0)
  end

  private

  def get_order id_table
    @order = Order.find_by(table_id: id_table, order_status: 1)
  end

  def get_items_order order, id_product, number_product
    @item_order = ProductOrder.where(product_id: id_product, order_id: order.id)
  end

  def get_product_with_order order
    ProductOrder.where(order_id: order.id).pluck(:product_id)
  end

  def destroy_product_with_order list_id_product, order
    @list_product = ProductOrder.where(product_id: list_id_product).where(order_id: order.id)
  end

  def load_table
    @table_home = Table.includes(:orders).where position_id: 1
    @table_out_left = Table.includes(:orders).where position_id: 2
    @table_front = Table.includes(:orders).where position_id: 3
  end
end
