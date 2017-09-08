class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category
  before_action :load_product, only: [:show, :destroy, :edit, :update]

  def index
    @products = Product.page(params[:page])
      .per 10
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = "Tao thanh cong"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "xoa thanh cong"
    else
      flash[:warning] = "xoa khong thanh cong"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit :code, :name, :description, :price, :unit, :category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
  end

  def load_category
    @categories = Category.all
  end
end
