class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, only: %i(new edit)
  before_action :load_product, only: %i(destroy edit show update)


  def index
    @search = Product.search params[:q]
    @search.sorts  = "created_at desc" if @search.sorts.empty?
    @products = @search.result.includes(:category).page(params[:page]).per_page 10
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = "Bạn đả tạo thành công"
      redirect_to admin_products_path
    else
      flash[:danger] = "Bạn đả tạo không thành công"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = "Chúc mừng bạn đả cập nhật thành công."
      redirect_to admin_products_path
    else
      flash[:danger] = "Xin lỗi ! Bạn đã cập nhật không thành công."
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "Chúc mừng bạn đả xóa thành công."
    else
      flash[:danger] = "Xin lỗi ! Bạn đã xóa không thành công, xin thử lại."
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
