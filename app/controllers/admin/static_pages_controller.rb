class Admin::StaticPagesController < ApplicationController
  def index

    @table_home = Table.includes(:orders).where table_location: 1

    @table_out_left = Table.includes(:orders).where table_location: 2

    @table_front = Table.includes(:orders).where table_location: 3

    @products = Product.all

  end

  def show
  end

  def home
  end

end
