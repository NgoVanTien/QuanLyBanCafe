class Admin::StaticPagesController < ApplicationController
  def index

    @table_home = Table.includes(:orders).where position_id: 1

    @table_out_left = Table.includes(:orders).where position_id: 2

    @table_front = Table.includes(:orders).where position_id: 3

    @products = Product.all

  end

  def show
  end

  def home
  end

end
